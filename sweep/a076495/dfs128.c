// Search B beyond 2^64: odd x <= L with sigma(x) > H*x and sigma(x) mod x == T, 128-bit n.
// Same tree as dfs.c, plus:
//  * children loop stops at the first prime q whose upper bound h(n)*q/(q-1)*boost(>q, L/(n q)) < H (monotone in q);
//  * prime list only up to PMAX; boost beyond the list is bounded by (PMAX/(PMAX-1))^(#extra primes that fit);
//    if a children loop would need a prime beyond the list, abort loudly;
//  * work split over NPROC processes by a counter on depth-2 nodes.
// usage: dfs128 L T P0 H PMAX NPROC ID [q]
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
typedef unsigned long long u64; typedef unsigned __int128 u128;
static u128 L; static u64 T; static double H; static unsigned *pr; static long np; static u64 PMAX;
static int NPROC=1, ID=0, quiet=0; static u64 cnt2=0;
static u64 hits=0, nodes=0, leaves=0;
static u64 mulmod(u64 a,u64 b,u64 m){return (u128)a*b%m;}
static u64 powmod(u64 a,u64 e,u64 m){u64 r=1;a%=m;while(e){if(e&1)r=mulmod(r,a,m);a=mulmod(a,a,m);e>>=1;}return r;}
static int isprime(u64 n){ if(n<2)return 0; static const u64 sp[]={2,3,5,7,11,13,17,19,23,29,31,37};
  for(int i=0;i<12;i++){if(n%sp[i]==0)return n==sp[i];}
  u64 d=n-1;int s=0;while(!(d&1)){d>>=1;s++;}
  for(int i=0;i<12;i++){u64 x=powmod(sp[i],d,n);if(x==1||x==n-1)continue;int ok=0;for(int r=1;r<s;r++){x=mulmod(x,x,n);if(x==n-1){ok=1;break;}}if(!ok)return 0;}
  return 1;}
static u128 isqrt128(u128 v){ u128 r=(u128)sqrtl((long double)v); while(r*r>v) r--; while((r+1)*(r+1)<=v) r++; return r; }
static void pu(u128 v,char*buf){ char t[64]; int k=0; if(!v){buf[0]='0';buf[1]=0;return;} while(v){t[k++]='0'+(int)(v%10); v/=10;} for(int i=0;i<k;i++) buf[i]=t[k-1-i]; buf[k]=0; }
static void report(u128 x,u128 s,const char*how){ if(x>T && s%x==T){ hits++; if(!quiet){ char a[64],b[64]; pu(x,a); pu(s,b); printf("HIT x=%s sigma=%s (%s)\n",a,b,how); fflush(stdout);} } }
// upper bound for sigma(c)/c over c <= budget with all primes >= pr[j]
static double boost(long j, u128 budget){ double prod=1; u128 pp=1;
  while(j<np && pp<=budget/pr[j]){ pp*=pr[j]; prod*=(double)pr[j]/(pr[j]-1); j++; }
  if(j>=np){ u128 rest=budget/pp; double lg=log((double)PMAX); int extra=0; long double rr=(long double)rest;
    while(rr>=(long double)PMAX){ rr/= (long double)PMAX; extra++; }
    (void)lg; for(int i=0;i<extra;i++) prod*=(double)PMAX/(PMAX-1); }
  return prod; }
static void dfs(u128 n,u128 sn,long pi,int depth){
  if(depth==2){ cnt2++; if((int)(cnt2%NPROC)!=ID) return; }
  else if(depth<2 && ID!=0) goto skipself;
  nodes++;
  if(n>1 && (H<=0 || (double)sn > H*(1-1e-12)*(double)n)) report(n,sn,"node");
  skipself:;
  u128 budget=L/n; if(budget<2) return;
  if(pi>=np) { if(budget>=PMAX){ fprintf(stderr,"ABORT: list exhausted at depth %d\n",depth); exit(2);} return; }
  double hb=(double)sn/(double)n;
  if(H>0 && hb*boost(pi,budget) < H*(1-1e-12)) return;
  u128 sq=isqrt128(budget);
  if(depth>=2 || ID==0){ // leaves belong to the owner of node n
    u128 pmin = sq+1; if(pmin<pr[pi]) pmin=pr[pi];
    if(pmin<=budget && (H<=0 || hb*(1.0+1.0/(double)pmin) > H*(1-1e-12))){
      if(sn>T){ u128 D=sn-T; u128 t0=(n-(sn%n))%n; if(t0==0) t0=n;
        for(u128 t=t0; t*pmin<=D; t+=n){ if(D%t) continue; u128 P=D/t; if(P<pmin||P>budget) continue;
          if(P>>64){ fprintf(stderr,"ABORT: P beyond 64 bits\n"); exit(3);} leaves++; if(isprime((u64)P)) report(n*P, sn*(P+1), "leaf"); } }
      else if(sn<T){ u128 D=T-sn; u128 u0=sn%n; if(u0==0) u0=n;
        for(u128 u=u0; u*pmin<=D; u+=n){ if(D%u) continue; u128 P=D/u; if(P<pmin||P>budget) continue;
          if(P>>64){ fprintf(stderr,"ABORT: P beyond 64 bits\n"); exit(3);} leaves++; if(isprime((u64)P)) report(n*P, sn*(P+1), "leafneg"); } }
      else { fprintf(stderr,"ABORT: sigma(n)==T branch not supported\n"); exit(4); } } }
  for(long j=pi; ; j++){
    if(j>=np){ if((u128)PMAX<=sq){ fprintf(stderr,"ABORT: children need primes beyond PMAX\n"); exit(5);} break; }
    u64 q=pr[j]; if((u128)q>sq) break;
    if(H>0 && hb*((double)q/(q-1))*boost(j+1,budget/q) < H*(1-1e-12)) break; // monotone in q
    u128 qe=q; u128 s_=1+q;
    while(1){ dfs(n*qe, sn*s_, j+1, depth+1); if(qe>budget/q) break; qe*=q; s_=s_*q+1; } }
}
int main(int argc,char**argv){
  L=(u128)strtold(argv[1],0); // exact for powers of ten up to 10^27 in long double? use string parse instead:
  { u128 v=0; for(char*c=argv[1];*c;c++) v=v*10+(*c-'0'); L=v; }
  T=strtoull(argv[2],0,10); u64 P0=strtoull(argv[3],0,10); H=atof(argv[4]); PMAX=strtoull(argv[5],0,10);
  NPROC=atoi(argv[6]); ID=atoi(argv[7]); quiet=argc>8;
  u64 r=PMAX; char*c=calloc(r+1,1); pr=malloc(sizeof(unsigned)*(size_t)(1.3*r/log((double)r)+1000)); np=0;
  for(u64 i=2;i<=r;i++){ if(!c[i]){ if(i>=P0) pr[np++]=(unsigned)i; for(u64 j=i*i;j<=r;j+=i) c[j]=1; } }
  free(c); PMAX=pr[np-1];
  dfs(1,1,0,0);
  char a[64]; pu(L,a);
  printf("L=%s T=%llu P0=%llu H=%g PMAX=%llu part %d/%d: nodes=%llu leafcands=%llu hits=%llu\n",a,T,P0,H,PMAX,ID,NPROC,nodes,leaves,hits);
}
