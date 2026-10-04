// Random C4-free connected graphs (random edge order, greedy add up to m edges), exact check of
// rad + l(G) <= path with early stop at ceil(rad+l). usage: sample n trials seed
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
typedef unsigned long long u64;
static int n; static u64 adj[64]; static int best_len, need;
static void dfs(u64 used, u64 forbid, int last, int len){
  if(len>best_len) best_len=len; if(best_len>=need) return;
  u64 c = adj[last] & ~used & ~forbid;
  while(c){ int w=__builtin_ctzll(c); c&=c-1; dfs(used|(1ULL<<w), forbid|adj[last], w, len+1); if(best_len>=need) return; }
}
static int pathnum(int cap){ best_len=1; need=cap; for(int s=0;s<n;s++){ dfs(1ULL<<s,0,s,1); if(best_len>=need) break;} return best_len; }
static int rad(){ int r=1000; for(int s=0;s<n;s++){ u64 seen=1ULL<<s, fr=seen; int d=0;
  while(1){u64 nf=0,f=fr; while(f){int v=__builtin_ctzll(f); f&=f-1; nf|=adj[v];} nf&=~seen; if(!nf)break; seen|=nf; fr=nf; d++;}
  if(__builtin_popcountll(seen)!=n) return -1; if(d<r) r=d;} return r; }
static int c4(int a,int b){ u64 na=adj[a]&~(1ULL<<b), nb=adj[b]&~(1ULL<<a);
  while(na){int x=__builtin_ctzll(na); na&=na-1; if(adj[x]&nb&~(1ULL<<x)) return 1;} return 0; }
int main(int argc,char**argv){
  n=atoi(argv[1]); long trials=atol(argv[2]); srand(atoi(argv[3]));
  int E=n*(n-1)/2; int *eu=malloc(E*sizeof(int)), *ev=malloc(E*sizeof(int));
  double worst=-1e9; long tested=0;
  for(long t=0;t<trials;t++){
    memset(adj,0,sizeof adj); int m=0; for(int u=0;u<n;u++) for(int v=u+1;v<n;v++){eu[m]=u; ev[m]=v; m++;}
    for(int i=m-1;i>0;i--){int j=rand()%(i+1); int a=eu[i],b=ev[i]; eu[i]=eu[j]; ev[i]=ev[j]; eu[j]=a; ev[j]=b;}
    int target = n-1 + rand()% (int)(n*sqrt(n)/2.0 - n + 2 > 1 ? n*sqrt(n)/2.0 - n + 2 : 1); int added=0;
    for(int i=0;i<m && added<target;i++){ int a=eu[i], b=ev[i]; if(!c4(a,b)){ adj[a]|=1ULL<<b; adj[b]|=1ULL<<a; added++; } }
    int r=rad(); if(r<0) continue; tested++;
    double s=0; for(int v=0;v<n;v++){ u64 N=adj[v]; int d=__builtin_popcountll(N), e=0; u64 x=N; while(x){int y=__builtin_ctzll(x); x&=x-1; e+=__builtin_popcountll(adj[y]&N);} s+=d-e/2; }
    double l=s/n; int cap=(int)ceil(r+l-1e-9); int p=pathnum(cap+1);
    double sc=r+l-p; if(sc>worst){ worst=sc; printf("n=%d edges=%d rad=%d l=%.4f path>=%d score=%.4f\n",n,added,r,l,p,sc); fflush(stdout);} 
    if(sc>1e-9){ printf("COUNTEREXAMPLE?"); for(int u=0;u<n;u++) for(int v=u+1;v<n;v++) if(adj[u]>>v&1) printf(" %d-%d",u,v); printf("\n"); }
  }
  printf("done n=%d tested=%ld worst=%.4f\n",n,tested,worst);
}
