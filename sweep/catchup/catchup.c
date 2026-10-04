/* Exact Catch-Up solver for S = {1..N}, matching CatchUp.valueAux.
   State: remaining mask R (bit i-1 <-> number i), gap g = s_opp - s_me >= 0.
   v(R,g): R empty -> (g>0 ? loss : draw); sum(R) < g -> loss;
           else max over x in R of (x >= g ? neg v(R-x, x-g) : v(R-x, g-x)).
   The first-move flag is irrelevant: at g = 0 every pick x >= 1 ends the turn.
   Encoding: 1 loss, 2 draw, 3 win, 0 unknown. Dense 2-bit table. */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
static int N;
static uint64_t *tab;
static long long visited;
static inline int get(uint64_t i){ return (tab[i>>5] >> ((i&31)*2)) & 3; }
static inline void put(uint64_t i,int v){ tab[i>>5] |= ((uint64_t)v) << ((i&31)*2); }
static int v(uint32_t R, int g, int sumR){
  if(!R) return g>0 ? 1 : 2;
  if(sumR < g) return 1;
  uint64_t idx = (uint64_t)R*(N+1)+g;
  int c = get(idx); if(c) return c;
  visited++;
  int best = 1;
  for(int x=N; x>=1; x--) if(R>>(x-1)&1){
    uint32_t R2 = R & ~(1u<<(x-1));
    int r = (x >= g) ? 4 - v(R2, x-g, sumR-x) : v(R2, g-x, sumR-x);
    if(r > best){ best = r; if(best==3) break; }
  }
  put(idx,best);
  return best;
}
int main(int argc,char**argv){
  int lo=atoi(argv[1]), hi=atoi(argv[2]);
  for(N=lo; N<=hi; N++){
    uint64_t entries = ((uint64_t)1<<N)*(N+1);
    tab = calloc(entries/32+1, 8);
    if(!tab){ printf("N=%d alloc fail\n",N); return 1; }
    visited=0;
    int T = N*(N+1)/2;
    int r = v(N? ((1u<<N)-1) : 0, 0, T);
    const char*nm[]={"?","loss","draw","win"};
    printf("N=%d T=%d Teven=%d value=%s states=%lld\n",N,T,T%2==0,nm[r],visited);
    fflush(stdout);
    free(tab);
  }
}
