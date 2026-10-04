/* G3': R = {1,2,3} ∪ (disjoint pairs {a,a+1}, a >= 4) in {1..M}: v(R,g) for g = 0,1 by k parity. */
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
static long long c[2][2][4]; static uint32_t ex[2][2][4];
static void rec(int start,uint32_t R,int np){
  int s=sumof(R); for(int g=0;g<2;g++){ int r=v(R,g,s); c[np&1][g][r]++; if(!ex[np&1][g][r]) ex[np&1][g][r]=R; }
  for(int a=start;a+1<=M;a++) rec(a+2,R|(3u<<(a-1)),np+1);
}
int main(int cc,char**argv){ M=atoi(argv[1]); tab=calloc(((uint64_t)1<<M)*(M+1),1);
  rec(4,7u,0); const char*nm="?LDW";
  for(int k=0;k<2;k++) for(int g=0;g<2;g++){ printf("{1,2,3}+pairs, k %s, g=%d: L=%lld D=%lld W=%lld",k?"odd":"even",g,c[k][g][1],c[k][g][2],c[k][g][3]);
    for(int r=1;r<=3;r++) if(c[k][g][r] && c[k][g][r] < 50){ printf("  ex %c: {",nm[r]); for(int x=1;x<=M;x++) if(ex[k][g][r]>>(x-1)&1) printf(" %d",x); printf(" }"); }
    printf("\n"); }
}
