/* Count nodes of the naive (no memo) search with win cutoff, as the Lean kernel
   would evaluate Outcome.best (foldl short-circuits after a win).  dir=+1: picks
   in increasing order, dir=-1: decreasing. */
#include <stdio.h>
#include <stdlib.h>
static int N, dir; static long long nodes;
static int v(unsigned R,int g,int sumR){
  nodes++;
  if(!R) return g>0?1:2;
  if(sumR<g) return 1;
  int best=1;
  for(int k=0;k<N;k++){ int x = dir>0 ? k+1 : N-k; if(!(R>>(x-1)&1)) continue;
    unsigned R2=R&~(1u<<(x-1));
    int r=(x>=g)?4-v(R2,x-g,sumR-x):v(R2,g-x,sumR-x);
    if(r>best)best=r; if(best==3)break; }
  return best;
}
int main(int c,char**a){ int hi=atoi(a[1]);
  for(N=1;N<=hi;N++) for(dir=1;dir>=-1;dir-=2){ nodes=0; int r=v((1u<<N)-1,0,N*(N+1)/2);
    printf("N=%d dir=%+d value=%d nodes=%lld\n",N,dir,r,nodes);} }
