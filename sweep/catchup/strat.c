/* Test whether a fixed simple strategy for one player guarantees >= draw
   against an optimal opponent on {1..N}.  w(R,g,turnA): value for player A,
   where the current player is A iff turnA.  A picks by strategy; B minimises. */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
static int N, S;
static uint8_t *tab;
static int pick(uint32_t R, int g){
  int lo=0, hi=0, mincatch=0;
  for(int x=1;x<=N;x++) if(R>>(x-1)&1){ if(!lo) lo=x; hi=x; if(x>=g && !mincatch) mincatch=x; }
  switch(S){
    case 1: return hi;                               /* largest */
    case 2: return mincatch ? mincatch : hi;         /* smallest catching pick, else largest */
    case 3: return lo;                               /* smallest */
    case 4: return (g==0) ? lo : (mincatch?mincatch:hi);
    case 5: return (g==0) ? hi : (mincatch?mincatch:lo);
  }
  return hi;
}
/* values: 1 loss 2 draw 3 win (for A) */
static int w(uint32_t R, int g, int sumR, int turnA){
  if(!R) return g>0 ? (turnA?1:3) : 2;
  if(sumR < g) return turnA?1:3;
  uint64_t idx = ((uint64_t)R*(N+1)+g)*2+turnA;
  if(tab[idx]) return tab[idx];
  int res;
  if(turnA){
    int x = pick(R,g); uint32_t R2=R&~(1u<<(x-1));
    res = (x>=g) ? w(R2,x-g,sumR-x,0) : w(R2,g-x,sumR-x,1);
  } else {
    res = 3;
    for(int x=N;x>=1;x--) if(R>>(x-1)&1){
      uint32_t R2=R&~(1u<<(x-1));
      int r = (x>=g) ? w(R2,x-g,sumR-x,1) : w(R2,g-x,sumR-x,0);
      if(r<res){res=r; if(res==1)break;}
    }
  }
  tab[idx]=res; return res;
}
int main(int argc,char**argv){
  int hi=atoi(argv[1]);
  const char*nm[]={"?","L","D","W"};
  for(S=1;S<=5;S++){
    printf("strategy %d:\n  as P1:",S);
    for(N=1;N<=hi;N++){ if((N*(N+1)/2)%2) continue;
      tab=calloc(((uint64_t)1<<N)*(N+1)*2,1);
      printf(" N%d=%s",N,nm[w((1u<<N)-1,0,N*(N+1)/2,1)]); free(tab);}
    printf("\n  as P2:");
    for(N=1;N<=hi;N++){ if((N*(N+1)/2)%2) continue;
      tab=calloc(((uint64_t)1<<N)*(N+1)*2,1);
      printf(" N%d=%s",N,nm[w((1u<<N)-1,0,N*(N+1)/2,0)]); free(tab);}
    printf("\n"); fflush(stdout);
  }
}
