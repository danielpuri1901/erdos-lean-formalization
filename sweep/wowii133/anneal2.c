// Simulated annealing over connected C4-free graphs on n vertices,
// maximising score = rad + l(G) - path(G). A score > 0 is a counterexample to wowii133.
// usage: anneal n iters seed
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
typedef unsigned long long u64;
static int n;
static u64 adj[64];
static int best_len, need;
static void dfs(u64 used, u64 forbid, int last, int len){
  if(len>best_len) best_len=len;
  if(best_len>=need) return;
  // candidates: nbrs of last not used, not adjacent to earlier path vertices (forbid)
  u64 c = adj[last] & ~used & ~forbid;
  while(c){ int w=__builtin_ctzll(c); c&=c-1;
    dfs(used|(1ULL<<w), forbid|adj[last], w, len+1);
    if(best_len>=need) return; }
}
// path number, stop early once >= cap
static int pathnum(int cap){
  best_len=1; need=cap;
  for(int s=0;s<n;s++){ dfs(1ULL<<s, 0, s, 1); if(best_len>=need) break; }
  return best_len;
}
static int connected_rad(int *rad){
  int r=1000;
  for(int s=0;s<n;s++){
    u64 seen=1ULL<<s, fr=seen; int d=0;
    while(1){ u64 nf=0; u64 f=fr; while(f){int v=__builtin_ctzll(f); f&=f-1; nf|=adj[v];}
      nf&=~seen; if(!nf) break; seen|=nf; fr=nf; d++; }
    if(seen != ((n==64)?~0ULL:((1ULL<<n)-1))) return 0;
    if(d<r) r=d;
  }
  *rad=r; return 1;
}
static int has_c4_with(int a,int b){ // would adding edge ab create a C4 (non induced)? i.e. path a-x-y-b length 3, or common nbr issues
  // after adding ab: C4 through ab: a-b-y-x-a with x~a, y~b, x~y, x,y distinct from a,b
  u64 na=adj[a]&~(1ULL<<b), nb=adj[b]&~(1ULL<<a);
  while(na){int x=__builtin_ctzll(na); na&=na-1; if(adj[x]&nb&~(1ULL<<x)) return 1;}
  return 0;
}
static double lsum(){ // C4-free: l(v) = deg - edges inside N(v)
  double s=0; for(int v=0;v<n;v++){ u64 N=adj[v]; int d=__builtin_popcountll(N); int e=0; u64 t=N;
    while(t){int x=__builtin_ctzll(t); t&=t-1; e+=__builtin_popcountll(adj[x]&N);} s+= d - e/2; }
  return s/n;
}
static double score(int *rr,int *pp,double *ll){
  int rad; if(!connected_rad(&rad)) return -1e9;
  double l=lsum(); int p=pathnum(n+1);
  *rr=rad; *pp=p; *ll=l; return rad + l - p;
}
int main(int argc,char**argv){
  n=atoi(argv[1]); long iters=atol(argv[2]); srand(atoi(argv[3]));
  // start: path graph (tree is C4-free, connected)
  memset(adj,0,sizeof adj);
  for(int i=0;i+1<n;i++){ int j=rand()%(i+1); adj[i+1]|=1ULL<<j; adj[j]|=1ULL<<(i+1);}
  { int dens=atoi(argv[4]); for(long t=0;t<(long)dens*n*n;t++){int a=rand()%n,b=rand()%n; if(a!=b && !(adj[a]>>b&1) && !has_c4_with(a,b)){adj[a]|=1ULL<<b; adj[b]|=1ULL<<a;}} }
  int r,p; double l; double cur=score(&r,&p,&l), best=cur; double T=0.5;
  for(long it=0;it<iters;it++){
    T = 0.6*(1.0 - (double)it/iters)+0.02;
    int a=rand()%n, b=rand()%n; if(a==b) continue;
    u64 save_a=adj[a], save_b=adj[b];
    if(adj[a]>>b&1){ adj[a]&=~(1ULL<<b); adj[b]&=~(1ULL<<a);} else { if(has_c4_with(a,b)) continue; adj[a]|=1ULL<<b; adj[b]|=1ULL<<a; }
    int r2,p2; double l2; double s=score(&r2,&p2,&l2);
    if(s>-1e8 && (s>=cur || exp((s-cur)/T) > (double)rand()/RAND_MAX)){ cur=s;
      if(s>best-1e-9){ best=s; if(s> -0.35){ printf("n=%d score=%.4f rad=%d l=%.4f path=%d edges:",n,s,r2,l2,p2);
        for(int u=0;u<n;u++) for(int v=u+1;v<n;v++) if(adj[u]>>v&1) printf(" %d-%d",u,v); printf("\n"); fflush(stdout);} }
    } else { adj[a]=save_a; adj[b]=save_b; }
  }
  printf("done n=%d best=%.4f\n",n,best);
}
