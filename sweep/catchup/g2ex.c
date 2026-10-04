/* Even pair-unions Q inside {1..M} with v(Q,2) = W (the partner reply a+1 fails there).
   Print them, to see their shape. */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
static int M; static uint8_t *tab;
static int v(uint32_t R,int g,int sumR){
  if(!R) return g>0?1:2;
  if(sumR<g) return 1;
  uint64_t idx=(uint64_t)R*(M+1)+g; if(tab[idx]) return tab[idx];
  int best=1;
  for(int x=M;x>=1;x--) if(R>>(x-1)&1){ uint32_t R2=R&~(1u<<(x-1));
    int r=(x>=g)?4-v(R2,x-g,sumR-x):v(R2,g-x,sumR-x); if(r>best){best=r; if(best==3)break;} }
  tab[idx]=best; return best;
}
static int sumof(uint32_t R){int s=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1) s+=x; return s;}
static void rec(int start,uint32_t R,int np){
  if(R && !(np&1)){ int r=v(R,2,sumof(R)); if(r==3){ printf("v(Q,2)=W  Q pairs starting at:"); for(int x=1;x<=M;x++) if(R>>(x-1)&1){ printf(" %d",x); x++; } printf("\n"); } }
  for(int a=start;a+1<=M;a++) rec(a+2,R|(3u<<(a-1)),np+1);
}
int main(int c,char**argv){ M=atoi(argv[1]); tab=calloc(((uint64_t)1<<M)*(M+1),1); rec(1,0,0); }
