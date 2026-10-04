// Search B (and a general validation mode): enumerate all x <= L, built from primes >= P0,
// with abundancy sigma(x)/x > H (H=0: no restriction), and report x with sigma(x) mod x == T.
// Node n = prefix of the factorization (primes increasing). Children n*q^e with q^2 <= L/n.
// A last prime P with exponent 1 and P^2 > L/n is found from P*t = sigma(n)-T, t = -sigma(n) mod n.
// usage: dfs L T P0 H
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
typedef unsigned long long u64; typedef unsigned __int128 u128;
static u64 L,T; static double H; static unsigned *pr; static long np;
static u64 hits=0, nodes=0, leaves=0;
static u64 mulmod(u64 a,u64 b,u64 m){return (u128)a*b%m;}
static u64 powmod(u64 a,u64 e,u64 m){u64 r=1;a%=m;while(e){if(e&1)r=mulmod(r,a,m);a=mulmod(a,a,m);e>>=1;}return r;}
static int isprime(u64 n){ if(n<2)return 0; static const u64 sp[]={2,3,5,7,11,13,17,19,23,29,31,37};
  for(int i=0;i<12;i++){if(n%sp[i]==0)return n==sp[i];}
  u64 d=n-1;int s=0;while(!(d&1)){d>>=1;s++;}
  for(int i=0;i<12;i++){u64 x=powmod(sp[i],d,n);if(x==1||x==n-1)continue;int ok=0;for(int r=1;r<s;r++){x=mulmod(x,x,n);if(x==n-1){ok=1;break;}}if(!ok)return 0;}
  return 1;}
static u64 isqrt(u64 v){u64 r=(u64)sqrtl((long double)v);while(r*r>v)r--;while((r+1)*(r+1)<=v)r++;return r;}
static int quiet=0;
static void report(u64 x,u128 s,const char*how){ if(x>T && s%x==T){hits++; if(!quiet) printf("HIT x=%llu sigma=%llu (%s)\n",x,(u64)s,how); fflush(stdout);} }
static void dfs(u64 n,u128 sn,long pi){
  nodes++;
  if(n>1 && (H<=0 || (double)sn > H*(1-1e-12)*(double)n)) report(n,sn,"node"); // slack: sigma(x)=3x+5 must not be lost to rounding
  u64 budget=L/n; if(budget<2) return;
  if(pi>=np) return;
  // pruning by abundancy
  if(H>0){ double hb=(double)sn/(double)n, prod=1; long j=pi; u64 pp=1; int cnt=0;
    while(j<np && pp<=budget/pr[j]){pp*=pr[j]; prod*=(double)pr[j]/(pr[j]-1); j++; cnt++;}
    if(j>=np && cnt==0) prod*= (double)pr[np-1]/(pr[np-1]-1);
    if(hb*prod < H*(1-1e-12)) return; }
  u64 sq=isqrt(budget);
  // leaves: x = n*P, P prime, P > max(sq, last prime), exponent 1
  { u64 pmin = sq+1; if(pmin<pr[pi]) pmin=pr[pi];
    if(pmin<=budget && (H<=0 || ((double)sn/(double)n)*(1.0+1.0/pmin) > H*(1-1e-12))){
      if(sn>T){ u128 D=sn-T; u64 t0=(u64)((n-(u64)(sn%n))%n); if(t0==0) t0=n;
        for(u128 t=t0; t*pmin<=D; t+=n){ if(D%t) continue; u128 P=D/t; if(P<pmin||P>budget) continue;
          leaves++; if(isprime((u64)P)) report(n*(u64)P, sn*(P+1), "leaf"); } }
      else if(sn<T){ u128 D=T-sn; u64 u0=(u64)(sn%n); if(u0==0) u0=n;
        for(u128 u=u0; u*pmin<=D; u+=n){ if(D%u) continue; u128 P=D/u; if(P<pmin||P>budget) continue;
          leaves++; if(isprime((u64)P)) report(n*(u64)P, sn*(P+1), "leafneg"); } }
      else { /* sn==T: every prime P works iff n | sn; impossible for T=5 since no n has sigma(n)=5 */
        if(T==5){ fprintf(stderr,"IMPOSSIBLE sigma(n)=5 at n=%llu\n",n); }
        for(u64 P=pmin; P<=budget; P++) if(isprime(P)) report(n*P, sn*(P+1), "leafeq"); } } }
  // children n*q^e with q^2 <= budget
  for(long j=pi;j<np && pr[j]<=sq;j++){ u64 q=pr[j]; u64 qe=q; u128 sq_=1+q; 
    while(1){ dfs(n*qe, sn*sq_, j+1); if(qe>budget/q) break; qe*=q; sq_=sq_*q+1; if(n*qe>L) break; } }
}
int main(int argc,char**argv){
  L=strtoull(argv[1],0,10); T=strtoull(argv[2],0,10); u64 P0=strtoull(argv[3],0,10); H=atof(argv[4]); quiet=argc>5;
  u64 r=isqrt(L)+2; char*c=calloc(r+1,1); pr=malloc(sizeof(unsigned)*(size_t)(1.3*r/log((double)r)+1000)); np=0;
  for(u64 i=2;i<=r;i++){ if(!c[i]){ if(i>=P0) pr[np++]=(unsigned)i; for(u64 j=i*i;j<=r;j+=i) c[j]=1; } }
  free(c); fprintf(stderr,"primes: %ld up to %llu\n",np,r);
  dfs(1,1,0);
  printf("L=%llu T=%llu P0=%llu H=%g: nodes=%llu leafcands=%llu hits=%llu\n",L,T,P0,H,nodes,leaves,hits);
}
