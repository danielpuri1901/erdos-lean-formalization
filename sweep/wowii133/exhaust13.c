// Exhaustive generation of connected C4-free graphs up to isomorphism, n = 2..NMAX,
// by adding a vertex to connected C4-free graphs on n-1 vertices (every connected graph has a
// non-cut vertex, and C4-freeness is hereditary). Canonical form: minimum upper-triangle code over
// all permutations that respect an isomorphism-invariant ordered vertex partition (exact).
// For every graph, check n*(path - rad) >= sum_v l(v)  (i.e. rad + l(G) <= path), exact integers.
// usage: exhaust NMAX
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef unsigned __int128 u128;
typedef unsigned long long u64;
#define MAXN 13
static int n;
static unsigned adj[MAXN];
// ---------- invariants and canonical form ----------
static u64 inv[MAXN];
static int order[MAXN], cellstart[MAXN+1], ncells;
static int perm[MAXN]; static u128 best;
static int dist_profile(int s, u64 *h){ unsigned seen=1u<<s, fr=seen; u64 x=1469598103934665603ULL; int d=0;
  while(fr){ unsigned nf=0, f=fr; while(f){int v=__builtin_ctz(f); f&=f-1; nf|=adj[v];} nf&=~seen; d++; x=(x^(u64)(__builtin_popcount(nf)+31*d))*1099511628211ULL; seen|=nf; fr=nf; }
  *h=x; return d; }
static void compute_inv(){
  u64 base[MAXN];
  for(int v=0;v<n;v++){ u64 h; dist_profile(v,&h); int tri=0; unsigned N=adj[v]; unsigned t=N; while(t){int w=__builtin_ctz(t); t&=t-1; tri+=__builtin_popcount(adj[w]&N);} 
    base[v]= h*31 + (u64)__builtin_popcount(adj[v])*1000003ULL + (u64)tri; }
  // two refinement rounds: add sorted multiset of neighbour invariants (sum of mixed hashes is order independent)
  for(int r=0;r<2;r++){ u64 nb[MAXN]; for(int v=0;v<n;v++){ u64 s=0; unsigned t=adj[v]; while(t){int w=__builtin_ctz(t); t&=t-1; u64 z=base[w]*0x9E3779B97F4A7C15ULL; z^=z>>29; s+=z*z+z;} nb[v]=base[v]*1315423911ULL ^ s; } memcpy(base,nb,sizeof nb); }
  memcpy(inv,base,sizeof base);
}
static u128 code_of(const int *p){ // p[i] = original vertex placed at position i
  u128 c=0; for(int i=0;i<n;i++) for(int j=i+1;j<n;j++){ c<<=1; if(adj[p[i]]>>p[j]&1) c|=1; } return c; }
static int pos_used[MAXN];
static void permute_cells(int cell, int idx){
  if(cell==ncells){ u128 c=code_of(perm); if(c<best) best=c; return; }
  int a=cellstart[cell], b=cellstart[cell+1];
  if(idx==b){ permute_cells(cell+1, cellstart[cell+1]); return; }
  for(int k=a;k<b;k++){ int v=order[k]; if(pos_used[v]) continue; pos_used[v]=1; perm[idx]=v; permute_cells(cell, idx+1); pos_used[v]=0; }
}
static u128 canon(){
  compute_inv();
  for(int i=0;i<n;i++) order[i]=i;
  for(int i=1;i<n;i++){ int x=order[i], j=i-1; while(j>=0 && inv[order[j]]>inv[x]){ order[j+1]=order[j]; j--; } order[j+1]=x; }
  ncells=0; for(int i=0;i<n;i++){ if(i==0 || inv[order[i]]!=inv[order[i-1]]) cellstart[ncells++]=i; } cellstart[ncells]=n;
  best=~(u128)0; memset(pos_used,0,sizeof pos_used); permute_cells(0,0); return best;
}
// ---------- hash set of codes ----------
typedef struct { u128 *keys; char *used; long cap, cnt; } hset;
static void hs_init(hset *h, long cap){ h->cap=cap; h->cnt=0; h->keys=calloc(cap,sizeof(u128)); h->used=calloc(cap,1); }
static int hs_add(hset *h, u128 k){ u64 x=(u64)k ^ (u64)(k>>64)*0x9E3779B97F4A7C15ULL; x^=x>>31; long i=x%h->cap;
  while(h->used[i]){ if(h->keys[i]==k) return 0; i=(i+1)%h->cap; } h->used[i]=1; h->keys[i]=k; h->cnt++; return 1; }
static void decode(u128 c, int nn){ n=nn; memset(adj,0,sizeof adj); int bits=nn*(nn-1)/2, b=bits-1;
  for(int i=0;i<nn;i++) for(int j=i+1;j<nn;j++){ if((c>>b)&1){ adj[i]|=1u<<j; adj[j]|=1u<<i; } b--; } }
// ---------- conjecture check ----------
static int best_len;
static void dfs(unsigned used, unsigned forbid, int last, int len){ if(len>best_len) best_len=len;
  unsigned c=adj[last]&~used&~forbid; while(c){int w=__builtin_ctz(c); c&=c-1; dfs(used|(1u<<w), forbid|adj[last], w, len+1);} }
static int indep(unsigned S){ int best=0; // max independent subset of S, brute force
  int k=__builtin_popcount(S); int vs[MAXN], m=0; unsigned t=S; while(t){vs[m++]=__builtin_ctz(t); t&=t-1;}
  for(unsigned sub=0; sub<(1u<<k); sub++){ unsigned T=0; for(int i=0;i<k;i++) if(sub>>i&1) T|=1u<<vs[i];
    int ok=1; for(int i=0;i<k && ok;i++) if((sub>>i&1) && (adj[vs[i]]&T)) ok=0; if(ok && __builtin_popcount(T)>best) best=__builtin_popcount(T); }
  return best; }
static long tight=0, fails=0, checked=0;
static void check_graph(){
  int r=1000; for(int s=0;s<n;s++){ unsigned seen=1u<<s, fr=seen; int d=0; while(1){unsigned nf=0,f=fr; while(f){int v=__builtin_ctz(f); f&=f-1; nf|=adj[v];} nf&=~seen; if(!nf)break; seen|=nf; fr=nf; d++;} if(d<r) r=d; }
  int L=0; for(int v=0;v<n;v++) L+=indep(adj[v]);
  best_len=1; for(int s=0;s<n;s++) dfs(1u<<s,0,s,1);
  checked++;
  long lhs=(long)n*(best_len-r);
  if(lhs<L){ fails++; printf("FAIL n=%d rad=%d sumL=%d path=%d edges:",n,r,L,best_len); for(int u=0;u<n;u++) for(int v=u+1;v<n;v++) if(adj[u]>>v&1) printf(" %d-%d",u,v); printf("\n"); fflush(stdout); }
  else if(lhs==L) tight++;
}
static int need_len;
static void dfs2(unsigned used, unsigned forbid, int last, int len){ if(len>best_len) best_len=len; if(best_len>=need_len) return;
  unsigned c=adj[last]&~used&~forbid; while(c){int w=__builtin_ctz(c); c&=c-1; dfs2(used|(1u<<w), forbid|adj[last], w, len+1); if(best_len>=need_len) return;} }
static long fin_cand=0, fin_big=0, fin_fail=0;
static void final_check(){
  fin_cand++;
  int L=0; for(int v=0;v<n;v++){ unsigned N=adj[v]; int e=0; unsigned t=N; while(t){int w=__builtin_ctz(t); t&=t-1; e+=__builtin_popcount(adj[w]&N);} L+=__builtin_popcount(N)-e/2; }
  if(L<=2*n) return; // l(G) <= 2: proved (conjecture133_of_l_le_two)
  fin_big++;
  int r=1000; for(int s=0;s<n;s++){ unsigned seen=1u<<s, fr=seen; int d=0; while(1){unsigned nf=0,f=fr; while(f){int v=__builtin_ctz(f); f&=f-1; nf|=adj[v];} nf&=~seen; if(!nf)break; seen|=nf; fr=nf; d++;} if(d<r) r=d; }
  need_len = r + (L + n - 1)/n; best_len=1;
  for(int s=0;s<n && best_len<need_len;s++) dfs2(1u<<s,0,s,1);
  if((long)n*(best_len-r) < L){ fin_fail++; printf("FAIL n=%d rad=%d sumL=%d path=%d edges:",n,r,L,best_len); for(int u=0;u<n;u++) for(int v=u+1;v<n;v++) if(adj[u]>>v&1) printf(" %d-%d",u,v); printf("\n"); fflush(stdout); }
}
int main(int argc,char**argv){
  int NMAX=atoi(argv[1]); int NP=atoi(argv[2]), PID=atoi(argv[3]);
  // level 2: K2
  long cap=1<<12; hset cur; hs_init(&cur,cap); n=2; memset(adj,0,sizeof adj); adj[0]=2; adj[1]=1; hs_add(&cur, canon());
  n=2; check_graph();
  printf("n=2 graphs=%ld checked=%ld fails=%ld tight=%ld\n",cur.cnt,checked,fails,tight);
  for(int nn=3; nn<=NMAX-1; nn++){
    hset nxt; hs_init(&nxt, cur.cnt*400+1024);
    long ck0=checked, f0=fails, t0=tight;
    for(long i=0;i<cur.cap;i++) if(cur.used[i]){
      decode(cur.keys[i], nn-1); unsigned base[MAXN]; memcpy(base,adj,sizeof base);
      for(unsigned S=1; S<(1u<<(nn-1)); S++){
        int ok=1; for(int w=0;w<nn-1 && ok;w++) if(__builtin_popcount(base[w]&S)>1) ok=0;
        if(!ok) continue;
        n=nn; memcpy(adj,base,sizeof base); adj[nn-1]=S; for(int w=0;w<nn-1;w++) if(S>>w&1) adj[w]|=1u<<(nn-1);
        u128 c=canon();
        hs_add(&nxt,c);
      }
    }
    printf("n=%d graphs=%ld checked=%ld fails=%ld tight=%ld\n",nn,nxt.cnt,checked-ck0,fails-f0,tight-t0); fflush(stdout);
    free(cur.keys); free(cur.used); cur=nxt;
  }
  { int nn=NMAX; long pi=-1;
    for(long i=0;i<cur.cap;i++) if(cur.used[i]){ pi++; if(pi%NP!=PID) continue;
      decode(cur.keys[i], nn-1); unsigned base[MAXN]; memcpy(base,adj,sizeof base);
      for(unsigned S=1; S<(1u<<(nn-1)); S++){
        int ok=1; for(int w=0;w<nn-1 && ok;w++) if(__builtin_popcount(base[w]&S)>1) ok=0;
        if(!ok) continue;
        n=nn; memcpy(adj,base,sizeof base); adj[nn-1]=S; for(int w=0;w<nn-1;w++) if(S>>w&1) adj[w]|=1u<<(nn-1);
        final_check();
      } }
    printf("final n=%d proc=%d/%d candidates=%ld with_l_gt_2=%ld fails=%ld\n",nn,PID,NP,fin_cand,fin_big,fin_fail); }
}
