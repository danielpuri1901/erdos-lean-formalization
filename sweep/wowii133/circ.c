// All C4-free connected circulants C_n(S), S subset of {1..n/2}, |S|<=5, n<=60:
// vertex-transitive so rad=ecc(0), l=l(0). Check rad + l <= path (early stop at rad+l).
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef unsigned long long u64;
static int n; static u64 adj[64]; static int best_len, need;
static void dfs(u64 used, u64 forbid, int last, int len){
  if(len>best_len) best_len=len; if(best_len>=need) return;
  u64 c = adj[last] & ~used & ~forbid;
  while(c){ int w=__builtin_ctzll(c); c&=c-1; dfs(used|(1ULL<<w), forbid|adj[last], w, len+1); if(best_len>=need) return; }
}
int main(){
  long tested=0, tight=0;
  for(n=5;n<=60;n++){
    int h=n/2;
    for(u64 mask=1; mask < (1ULL<<h); mask++){
      if(__builtin_popcountll(mask)>5) continue;
      memset(adj,0,sizeof adj);
      for(int v=0;v<n;v++) for(int s=1;s<=h;s++) if(mask>>(s-1)&1){ int w=(v+s)%n; adj[v]|=1ULL<<w; adj[w]|=1ULL<<v; }
      // C4-free: common nbrs of 0 and j <= 1
      int bad=0; for(int j=1;j<n && !bad;j++) if(__builtin_popcountll(adj[0]&adj[j])>=2) bad=1;
      if(bad) continue;
      u64 seen=1, fr=1; int d=0; while(1){u64 nf=0,f=fr; while(f){int v=__builtin_ctzll(f); f&=f-1; nf|=adj[v];} nf&=~seen; if(!nf)break; seen|=nf; fr=nf; d++;}
      if(__builtin_popcountll(seen)!=n) continue;
      u64 N=adj[0]; int deg=__builtin_popcountll(N), e=0; u64 x=N; while(x){int y=__builtin_ctzll(x); x&=x-1; e+=__builtin_popcountll(adj[y]&N);} int l=deg-e/2;
      best_len=1; need=d+l+1; u64 u=1; dfs(u,0,0,1); // vertex-transitive: start at 0
      tested++;
      int score=d+l-best_len;
      if(score>=0){ tight+= (score==0); printf("n=%d S=",n); for(int s=1;s<=h;s++) if(mask>>(s-1)&1) printf("%d,",s); printf(" rad=%d l=%d path=%d score=%d\n",d,l,best_len,score); fflush(stdout);} 
    }
  }
  printf("done tested=%ld tight=%ld\n",tested,tight);
}
