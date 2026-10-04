/* Node count when the pre-picks of a turn (all picks but the last) are taken in
   increasing order: parameter lo = smallest allowed pre-pick. */
#include <stdio.h>
#include <stdlib.h>
static int N; static long long nodes;
static int v(unsigned R,int g,int sumR,int lo){
  nodes++;
  if(!R) return g>0?1:2;
  if(sumR<g) return 1;
  int best=1;
  for(int x=1;x<=N;x++){ if(!(R>>(x-1)&1)) continue;
    unsigned R2=R&~(1u<<(x-1)); int r;
    if(x>=g) r=4-v(R2,x-g,sumR-x,1);
    else { if(x<lo) continue; r=v(R2,g-x,sumR-x,x+1); }
    if(r>best)best=r; if(best==3)break; }
  return best;
}
int main(int c,char**a){ int hi=atoi(a[1]);
  for(N=1;N<=hi;N++){ nodes=0; int r=v((1u<<N)-1,0,N*(N+1)/2,1);
    printf("N=%d value=%d nodes=%lld\n",N,r,nodes);} }
