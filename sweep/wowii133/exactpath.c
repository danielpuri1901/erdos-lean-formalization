// exact induced-path number for graph on n<=256 vertices; reads "n m" then m edges from stdin
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define W 4
typedef unsigned long long u64;
typedef struct { u64 b[W]; } bs;
static int n; static bs adj[256]; static int best=1; static int bestp[256], cur[256];
static void dfs(bs used, bs forbid, int last, int len){
  if(len>best){best=len; memcpy(bestp,cur,sizeof(int)*len);}
  // bound: cannot exceed remaining available vertices
  for(int k=0;k<W;k++){ u64 c=adj[last].b[k]&~used.b[k]&~forbid.b[k];
    while(c){ int w=k*64+__builtin_ctzll(c); c&=c-1;
      bs u2=used, f2=forbid; u2.b[w>>6]|=1ULL<<(w&63); for(int j=0;j<W;j++) f2.b[j]|=adj[last].b[j];
      cur[len]=w; dfs(u2,f2,w,len+1);} }
}
int main(int argc,char**argv){
  int m; if(scanf("%d %d",&n,&m)!=2) return 1;
  for(int i=0;i<m;i++){int u,v; scanf("%d %d",&u,&v); adj[u].b[v>>6]|=1ULL<<(v&63); adj[v].b[u>>6]|=1ULL<<(u&63);}
  int start_only = argc>1 ? atoi(argv[1]) : n; // vertex-transitive: only need start vertex 0
  for(int s=0;s<start_only;s++){ bs u={0},f={0}; u.b[s>>6]|=1ULL<<(s&63); cur[0]=s; dfs(u,f,s,1); }
  printf("path=%d :",best); for(int i=0;i<best;i++) printf(" %d",bestp[i]); printf("\n");
}
