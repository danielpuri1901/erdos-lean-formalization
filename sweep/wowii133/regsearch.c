// Random k-regular graphs of girth >= 5 (MCMC by edge switches preserving girth>=5),
// report rad + k - path (l(v)=k for all v when girth>=5). score >= 0 means tight, > 0 counterexample.
// usage: regsearch n k steps seed
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef unsigned long long u64;
static int n,k; static u64 adj[64];
static int best_len, need;
static void dfs(u64 used, u64 forbid, int last, int len){
  if(len>best_len) best_len=len; if(best_len>=need) return;
  u64 c = adj[last] & ~used & ~forbid;
  while(c){ int w=__builtin_ctzll(c); c&=c-1; dfs(used|(1ULL<<w), forbid|adj[last], w, len+1); if(best_len>=need) return; }
}
static int pathnum(int cap){ best_len=1; need=cap; for(int s=0;s<n;s++){ dfs(1ULL<<s,0,s,1); if(best_len>=need) break;} return best_len; }
static int rad(){ int r=1000; for(int s=0;s<n;s++){ u64 seen=1ULL<<s, fr=seen; int d=0;
  while(1){u64 nf=0,f=fr; while(f){int v=__builtin_ctzll(f); f&=f-1; nf|=adj[v];} nf&=~seen; if(!nf)break; seen|=nf; fr=nf; d++;}
  if(__builtin_popcountll(seen)!=n) return -1; if(d<r) r=d;} return r; }
static int shortcycles(){ // count of C3 + C4 (non induced), proxy
  int c=0; for(int a=0;a<n;a++) for(int b=a+1;b<n;b++){ int cn=__builtin_popcountll(adj[a]&adj[b]); if(cn>=2) c+=cn*(cn-1)/2; if((adj[a]>>b&1) && cn) c+=cn; } return c; }
int main(int argc,char**argv){
  n=atoi(argv[1]); k=atoi(argv[2]); long steps=atol(argv[3]); srand(atoi(argv[4]));
  // random pairing until simple
  int pts[64*16];
  while(1){ memset(adj,0,sizeof adj); int m=0; for(int v=0;v<n;v++) for(int j=0;j<k;j++) pts[m++]=v;
    for(int i=m-1;i>0;i--){int j=rand()%(i+1); int t=pts[i]; pts[i]=pts[j]; pts[j]=t;}
    int ok=1; for(int i=0;i<m;i+=2){int a=pts[i],b=pts[i+1]; if(a==b||(adj[a]>>b&1)){ok=0;break;} adj[a]|=1ULL<<b; adj[b]|=1ULL<<a;}
    if(ok) break; }
  int sc=shortcycles(); int bestscore=-1000; long found=0;
  for(long it=0; it<steps; it++){
    // pick two edges ab, cd and switch to ac, bd
    int a=rand()%n; u64 na=adj[a]; int b; { int t=rand()%k; u64 x=na; for(int i=0;i<t;i++) x&=x-1; b=__builtin_ctzll(x);} 
    int c=rand()%n; u64 nc=adj[c]; int d; { int t=rand()%k; u64 x=nc; for(int i=0;i<t;i++) x&=x-1; d=__builtin_ctzll(x);} 
    if(a==c||a==d||b==c||b==d) continue; if((adj[a]>>c&1)||(adj[b]>>d&1)) continue;
    u64 sa=adj[a],sb=adj[b],sc2=adj[c],sd=adj[d];
    adj[a]^=(1ULL<<b)|(1ULL<<c); adj[b]^=(1ULL<<a)|(1ULL<<d); adj[c]^=(1ULL<<d)|(1ULL<<a); adj[d]^=(1ULL<<c)|(1ULL<<b);
    int s2=shortcycles();
    if(s2<=sc || (sc>0 && rand()%20==0)){ sc=s2; } else { adj[a]=sa; adj[b]=sb; adj[c]=sc2; adj[d]=sd; continue; }
    if(sc==0){ int r=rad(); if(r<0) continue; found++;
      int p=pathnum(r+k+1); int score=r+k-p;
      if(score>bestscore || score>=0){ if(score>bestscore) bestscore=score;
        if(score>=0){ printf("n=%d k=%d rad=%d path=%d score=%d edges:",n,k,r,p,score); for(int u=0;u<n;u++) for(int v=u+1;v<n;v++) if(adj[u]>>v&1) printf(" %d-%d",u,v); printf("\n"); fflush(stdout);} }
    }
  }
  printf("done n=%d k=%d girth5-samples=%ld best=%d\n",n,k,found,bestscore);
}
