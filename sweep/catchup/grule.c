/* In G-positions, does a fixed first-pick rule always draw (opponent value exactly D)? */
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
static long long pos[2], ok[2][4];
static void rec(int start,uint32_t R,int np){
  if(R){ int g=np&1, s=sumof(R); pos[g]++;
    int lo=0,hi=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1){ if(!lo) lo=x; hi=x; }
    int cand[4]={lo, lo+1, hi-1, hi}; /* smallest, its partner, partner of largest, largest */
    for(int r=0;r<4;r++){ int x=cand[r]; if(v(R&~(1u<<(x-1)),x-g,s-x)==2) ok[g][r]++; } }
  for(int a=start;a+1<=M;a++) rec(a+2,R|(3u<<(a-1)),np+1);
}
int main(int c,char**argv){ M=atoi(argv[1]); tab=calloc(((uint64_t)1<<M)*(M+1),1);
  rec(1,0,0); const char*nm[4]={"smallest a1","a1+1","largest-1","largest"};
  for(int g=0;g<2;g++){ printf("g=%d (k %s): %lld positions;",g,g?"odd":"even",pos[g]);
    for(int r=0;r<4;r++) printf(" %s draws in %lld;",nm[r],ok[g][r]); printf("\n"); }
}
