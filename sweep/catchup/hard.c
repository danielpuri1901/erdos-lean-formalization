/* Hard case of L3: pair-union R with k odd, gap 1; mover takes a (smaller element of pair
   {a,a+1}); the other player faces gap a-1 with a+1 available.  For the cases where the
   reply a+1 fails, print R, a and the first picks y that keep >= D for the replier. */
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
static int shown=0; static long long fails=0, hist[40];
static void rec(int start,uint32_t R,int np){
  if(R && (np&1)){ int s=sumof(R);
    for(int a=1;a<M;a++) if((R>>(a-1)&1) && (R>>a&1)){
      /* is a the smaller element of its pair? scan pairs from the left */
      int ok=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1){ if(x==a){ok=1;break;} if(x==a+1) break; x++; }
      if(!ok) continue;
      uint32_t R2=R&~(1u<<(a-1)); int g=a-1, s2=s-a;
      uint32_t R3=R2&~(1u<<a); int rr=(a+1>=g)? 4-v(R3,a+1-g,s2-a-1) : 0;
      if(rr>=2) continue;
      fails++; hist[a]++;
      if(shown<12){ shown++; printf("R pairs at:"); for(int x=1;x<=M;x++) if(R>>(x-1)&1){printf(" %d",x); x++;}
        printf(" | mover took a=%d; good first picks y:",a);
        for(int y=1;y<=M;y++) if(R2>>(y-1)&1){ uint32_t R4=R2&~(1u<<(y-1));
          int r=(y>=g)?4-v(R4,y-g,s2-y):v(R4,g-y,s2-y); if(r>=2) printf(" %d%s",y,r==3?"(W)":""); }
        printf("\n"); } } }
  for(int a=start;a+1<=M;a++) rec(a+2,R|(3u<<(a-1)),np+1);
}
int main(int c,char**argv){ M=atoi(argv[1]); tab=calloc(((uint64_t)1<<M)*(M+1),1); rec(1,0,0);
  printf("failures of reply a+1: %lld; by a:",fails); for(int a=1;a<M;a++) if(hist[a]) printf(" a=%d:%lld",a,hist[a]); printf("\n"); }
