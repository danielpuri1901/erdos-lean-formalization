// Checker for WOWII conjecture 61: f(G) >= residue(G) + ceil(diam/3)
// also tests the stronger f(G) >= alpha(G) + ceil(diam/3).
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
typedef uint32_t u32;
static int n;
static u32 adj[32];

static int residue(void){
  int d[32], m=n;
  for(int i=0;i<n;i++) d[i]=__builtin_popcount(adj[i]);
  for(;;){
    // sort descending
    for(int i=1;i<m;i++){int x=d[i],j=i;while(j>0&&d[j-1]<x){d[j]=d[j-1];j--;}d[j]=x;}
    if(m==0) return 0;
    if(d[0]==0) return m;
    int k=d[0];
    for(int i=0;i<m-1;i++) d[i]=d[i+1];
    m--;
    for(int i=0;i<k && i<m;i++) if(d[i]>0) d[i]--;
  }
}
static int diam(void){ // returns -1 if disconnected
  int D=0;
  for(int s=0;s<n;s++){
    u32 seen=1u<<s, fr=1u<<s; int e=0; u32 all=(n==32)?0xffffffffu:((1u<<n)-1);
    while(seen!=all){
      u32 nf=0; for(u32 t=fr;t;t&=t-1) nf|=adj[__builtin_ctz(t)];
      nf&=~seen; if(!nf) return -1; seen|=nf; fr=nf; e++;
    }
    if(e>D) D=e;
  }
  return D;
}
// alpha by simple branch and bound
static int abest;
static void arec(u32 cand,int sz){
  if(!cand){ if(sz>abest) abest=sz; return; }
  if(sz+__builtin_popcount(cand)<=abest) return;
  int v=__builtin_ctz(cand);
  // if v has no neighbours in cand, take it
  if(!(adj[v]&cand)){ arec(cand&~(1u<<v),sz+1); return; }
  arec(cand&~(1u<<v)&~adj[v],sz+1);
  arec(cand&~(1u<<v),sz);
}
static int alpha(void){ abest=0; arec((n==32)?0xffffffffu:((1u<<n)-1),0); return abest; }
// max induced forest: branch on vertices in order, maintain component masks
static int fbest;
static void frec(int v,u32 *comp,int nc,int sz){
  if(sz+(n-v)<=fbest) return;
  if(v==n){ fbest=sz; return; }
  // include v?
  u32 nb=adj[v]; int ok=1; u32 merged=1u<<v; u32 nc2[32]; int k=0;
  for(int i=0;i<nc;i++){ int c=__builtin_popcount(nb&comp[i]); if(c>1){ok=0;break;} if(c==1) merged|=comp[i]; else nc2[k++]=comp[i]; }
  if(ok){ nc2[k++]=merged; frec(v+1,nc2,k,sz+1); }
  frec(v+1,comp,nc,sz);
}
static int forest(void){ u32 c[32]; fbest=0; frec(0,c,0,0); return fbest; }

static int ceil3(int d){ return (d+2)/3; }

int main(int argc,char**argv){
  const char*mode=argc>1?argv[1]:"exh";
  if(!strcmp(mode,"exh")){
    int N=atoi(argv[2]);
    for(n=2;n<=N;n++){
      int ne=n*(n-1)/2; long long tot=0,fail=0,failA=0,tight=0,tightA=0;
      int pu[64],pv[64],e=0; for(int i=0;i<n;i++)for(int j=i+1;j<n;j++){pu[e]=i;pv[e]=j;e++;}
      for(long long m=0;m<(1LL<<ne);m++){
        memset(adj,0,sizeof adj);
        for(int b=0;b<ne;b++) if(m>>b&1){adj[pu[b]]|=1u<<pv[b];adj[pv[b]]|=1u<<pu[b];}
        int D=diam(); if(D<0) continue; tot++;
        int r=residue(), f=forest(), a=alpha();
        int s=f-r-ceil3(D), sA=f-a-ceil3(D);
        if(s<0) fail++; if(s==0) tight++;
        if(sA<0){ if(failA<3){printf("A-fail n=%d D=%d r=%d a=%d f=%d edges:",n,D,r,a,f);for(int i=0;i<n;i++)for(int j=i+1;j<n;j++)if(adj[i]>>j&1)printf(" %d-%d",i,j);printf("\n");} failA++;} if(sA==0) tightA++;
        if(r>a){printf("residue>alpha?! n=%d m=%lld\n",n,m);}
      }
      printf("n=%d labeled connected=%lld fail61=%lld tight61=%lld failAlphaVersion=%lld tightAlpha=%lld\n",n,tot,fail,tight,failA,tightA);
      fflush(stdout);
    }
  }
  return 0;
}
