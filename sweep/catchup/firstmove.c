/* For S={1..N}: value for P2 after P1's first move y, i.e. v(S\{y}, y), for every y. */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
static int N; static uint64_t *tab;
static inline int get(uint64_t i){ return (tab[i>>5] >> ((i&31)*2)) & 3; }
static inline void put(uint64_t i,int v){ tab[i>>5] |= ((uint64_t)v) << ((i&31)*2); }
static int v(uint32_t R,int g,int sumR){
  if(!R) return g>0?1:2;
  if(sumR<g) return 1;
  uint64_t idx=(uint64_t)R*(N+1)+g; int c=get(idx); if(c) return c;
  int best=1;
  for(int x=N;x>=1;x--) if(R>>(x-1)&1){ uint32_t R2=R&~(1u<<(x-1));
    int r=(x>=g)?4-v(R2,x-g,sumR-x):v(R2,g-x,sumR-x); if(r>best){best=r; if(best==3)break;} }
  put(idx,best); return best;
}
int main(int c,char**a){ int lo=atoi(a[1]),hi=atoi(a[2]); const char*nm="?LDW";
  for(N=lo;N<=hi;N++){ tab=calloc(((uint64_t)1<<N)*(N+1)/32+1,8); int T=N*(N+1)/2;
    printf("N=%2d T%%2=%d  P2 value after y=1..N: ",N,T%2);
    for(int y=1;y<=N;y++) putchar(nm[v(((1u<<N)-1)&~(1u<<(y-1)),y,T-y)]);
    putchar('\n'); fflush(stdout); free(tab);} }
