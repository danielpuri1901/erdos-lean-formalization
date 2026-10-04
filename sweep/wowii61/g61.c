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
        if(sA<0) failA++; if(sA==0) tightA++;
        if(r>a){printf("residue>alpha?! n=%d m=%lld\n",n,m);}
      }
      printf("n=%d labeled connected=%lld fail61=%lld tight61=%lld failAlphaVersion=%lld tightAlpha=%lld\n",n,tot,fail,tight,failA,tightA);
      fflush(stdout);
    }
  }

  if(!strcmp(mode,"search")){
    n=atoi(argv[2]); long long iters=atoll(argv[3]); unsigned seed=atoi(argv[4]); srand(seed);
    int bestEver=1000; long long evals=0;
    while(evals<iters){
      // random start: path-like tree with random extra edges
      memset(adj,0,sizeof adj);
      for(int i=1;i<n;i++){int j = (rand()%3==0)? rand()%i : i-1; adj[i]|=1u<<j; adj[j]|=1u<<i;}
      int extra=rand()%(n);
      for(int t=0;t<extra;t++){int a=rand()%n,b=rand()%n; if(a!=b){adj[a]|=1u<<b;adj[b]|=1u<<a;}}
      int D=diam(); int cur=forest()-residue()-ceil3(D);
      double T=1.0;
      for(int step=0;step<4000 && evals<iters;step++){
        int a=rand()%n,b=rand()%n; if(a==b) continue;
        adj[a]^=1u<<b; adj[b]^=1u<<a;
        int D2=diam();
        if(D2<0){ adj[a]^=1u<<b; adj[b]^=1u<<a; continue; }
        evals++;
        int r=residue(), f=forest(); int s=f-r-ceil3(D2);
        if(s<=cur || (rand()/(double)RAND_MAX) < T*0.05){ cur=s; }
        else { adj[a]^=1u<<b; adj[b]^=1u<<a; }
        if(s<bestEver || s<0){ bestEver= s<bestEver? s:bestEver;
          printf("n=%d slack=%d D=%d r=%d f=%d a=%d edges:",n,s,D2,r,f,alpha());
          for(int i=0;i<n;i++)for(int j=i+1;j<n;j++)if(adj[i]>>j&1)printf(" %d-%d",i,j);
          printf("\n"); fflush(stdout);
          if(s<0) return 0; }
        T*=0.999;
      }
    }
    printf("done n=%d evals=%lld bestslack=%d\n",n,evals,bestEver);
  }

  if(!strcmp(mode,"band")){
    n=atoi(argv[2]); long long iters=atoll(argv[3]); unsigned seed=atoi(argv[4]); int w=atoi(argv[5]); srand(seed);
    int bestEver=1000; long long evals=0; int restarts=0;
    while(evals<iters){
      restarts++;
      memset(adj,0,sizeof adj);
      for(int i=1;i<n;i++){adj[i]|=1u<<(i-1); adj[i-1]|=1u<<i;}
      for(int i=0;i<n;i++)for(int j=i+2;j<=i+w&&j<n;j++) if(rand()%3==0){adj[i]|=1u<<j;adj[j]|=1u<<i;}
      if(diam()<0) continue;
      int D=diam(); int cur=forest()-residue()-ceil3(D);
      for(int step=0;step<3000 && evals<iters;step++){
        int a=rand()%n; int b=a+1+rand()%w; if(b>=n) continue;
        // also allow pendant-like long edges rarely? no: keep band
        adj[a]^=1u<<b; adj[b]^=1u<<a;
        int D2=diam();
        if(D2<0){ adj[a]^=1u<<b; adj[b]^=1u<<a; continue; }
        evals++;
        int r=residue(), f=forest(); int s=f-r-ceil3(D2);
        if(s<=cur || (rand()%1000)<3){ cur=s; }
        else { adj[a]^=1u<<b; adj[b]^=1u<<a; }
        if(s<bestEver){ bestEver=s;
          printf("n=%d w=%d slack=%d D=%d r=%d f=%d a=%d edges:",n,w,s,D2,r,f,alpha());
          for(int i=0;i<n;i++)for(int j=i+1;j<n;j++)if(adj[i]>>j&1)printf(" %d-%d",i,j);
          printf("\n"); fflush(stdout);
          if(s<0) return 0; }
      }
    }
    printf("done n=%d w=%d evals=%lld restarts=%d bestslack=%d\n",n,w,evals,restarts,bestEver);
  }
  if(!strcmp(mode,"eval")){
    // read graphs: n m then m pairs, repeated
    int m;
    while(scanf("%d %d",&n,&m)==2){
      memset(adj,0,sizeof adj);
      for(int i=0;i<m;i++){int a,b;scanf("%d %d",&a,&b);adj[a]|=1u<<b;adj[b]|=1u<<a;}
      int D=diam(); int r=residue(), f=forest(), a=alpha();
      printf("n=%d m=%d D=%d r=%d alpha=%d f=%d slack=%d\n",n,m,D,r,a,f, D<0?999:f-r-ceil3(D));
    }
  }

  if(!strcmp(mode,"mix")){
    // moves: edge toggle or degree-preserving double-edge swap; start: random caterpillar-like tree
    n=atoi(argv[2]); long long iters=atoll(argv[3]); unsigned seed=atoi(argv[4]); srand(seed);
    int bestEver=1000; long long evals=0; int minD=argc>5?atoi(argv[5]):4;
    while(evals<iters){
      memset(adj,0,sizeof adj);
      int L=minD+1+rand()%(n-minD-1); // spine length
      for(int i=1;i<L;i++){adj[i]|=1u<<(i-1);adj[i-1]|=1u<<i;}
      for(int i=L;i<n;i++){int j=rand()%L; adj[i]|=1u<<j; adj[j]|=1u<<i;}
      int extra=rand()%n;
      for(int t=0;t<extra;t++){int a=rand()%n,b=rand()%n; if(a!=b && abs(a-b)<4){adj[a]|=1u<<b;adj[b]|=1u<<a;}}
      int D=diam(); if(D<minD) continue;
      int cur=forest()-residue()-ceil3(D);
      for(int step=0;step<3000 && evals<iters;step++){
        u32 save[32]; memcpy(save,adj,sizeof adj);
        if(rand()%2){ int a=rand()%n,b=rand()%n; if(a==b) continue; adj[a]^=1u<<b; adj[b]^=1u<<a; }
        else { int a=rand()%n,c=rand()%n; if(a==c||!adj[a]||!adj[c]) continue;
          // pick b in N(a), d in N(c)
          int nb=__builtin_popcount(adj[a]), nd=__builtin_popcount(adj[c]);
          int ib=rand()%nb, id=rand()%nd; int b=-1,d=-1;
          for(u32 t=adj[a];t;t&=t-1){ if(ib--==0){b=__builtin_ctz(t);break;} }
          for(u32 t=adj[c];t;t&=t-1){ if(id--==0){d=__builtin_ctz(t);break;} }
          if(b==c||d==a||b==d) continue;
          if(adj[a]>>c&1 || adj[b]>>d&1) continue;
          adj[a]&=~(1u<<b); adj[b]&=~(1u<<a); adj[c]&=~(1u<<d); adj[d]&=~(1u<<c);
          adj[a]|=1u<<c; adj[c]|=1u<<a; adj[b]|=1u<<d; adj[d]|=1u<<b; }
        int D2=diam();
        if(D2<minD){ memcpy(adj,save,sizeof adj); continue; }
        evals++;
        int r=residue(), f=forest(); int s=f-r-ceil3(D2);
        if(s<=cur || (rand()%1000)<5){ cur=s; } else memcpy(adj,save,sizeof adj);
        if(s<bestEver){ bestEver=s;
          printf("n=%d slack=%d D=%d r=%d f=%d a=%d edges:",n,s,D2,r,f,alpha());
          for(int i=0;i<n;i++)for(int j=i+1;j<n;j++)if(adj[i]>>j&1)printf(" %d-%d",i,j);
          printf("\n"); fflush(stdout);
          if(s<0) return 0; }
      }
    }
    printf("done n=%d evals=%lld bestslack=%d (D>=%d)\n",n,evals,bestEver,minD);
  }
  if(!strcmp(mode,"exh8")){
    // labeled exhaustive n=8, part p of P (split by top bits of edge mask)
    n=8; int P=atoi(argv[2]), part=atoi(argv[3]);
    int ne=28; int pu[64],pv[64],e=0; for(int i=0;i<n;i++)for(int j=i+1;j<n;j++){pu[e]=i;pv[e]=j;e++;}
    long long tot=0,fail=0,tight=0,tightD4=0;
    for(long long m=part;m<(1LL<<ne);m+=P){
      memset(adj,0,sizeof adj);
      for(int b=0;b<ne;b++) if(m>>b&1){adj[pu[b]]|=1u<<pv[b];adj[pv[b]]|=1u<<pu[b];}
      int D=diam(); if(D<0) continue; tot++;
      int s=forest()-residue()-ceil3(D);
      if(s<0){fail++; printf("FAIL m=%lld\n",m);} if(s==0){tight++; if(D>=4) tightD4++;}
    }
    printf("exh8 part %d/%d: connected=%lld fail=%lld tight=%lld tight_with_D>=4=%lld\n",part,P,tot,fail,tight,tightD4);
  }

  if(!strcmp(mode,"tight")){
    int N=atoi(argv[2]);
    for(n=4;n<=N;n++){
      int ne=n*(n-1)/2; int pu[64],pv[64],e=0; for(int i=0;i<n;i++)for(int j=i+1;j<n;j++){pu[e]=i;pv[e]=j;e++;}
      for(long long m=0;m<(1LL<<ne);m++){
        memset(adj,0,sizeof adj);
        for(int b=0;b<ne;b++) if(m>>b&1){adj[pu[b]]|=1u<<pv[b];adj[pv[b]]|=1u<<pu[b];}
        int D=diam(); if(D<4) continue;
        int r=residue(), f=forest(); if(f-r-ceil3(D)!=0) continue;
        int d[32]; for(int i=0;i<n;i++) d[i]=__builtin_popcount(adj[i]);
        for(int i=1;i<n;i++){int x=d[i],j=i;while(j>0&&d[j-1]<x){d[j]=d[j-1];j--;}d[j]=x;}
        printf("n=%d D=%d r=%d a=%d f=%d m=%d deg=",n,D,r,alpha(),f,__builtin_popcountll(m));
        for(int i=0;i<n;i++) printf("%d",d[i]); printf("\n");
      }
    }
  }
  return 0;
}
