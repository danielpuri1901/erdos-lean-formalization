#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
static int M,G; static uint8_t *tab;
static int sumof(uint32_t R){int s=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1) s+=x; return s;}
static int v(uint32_t R,int g){ if(!R) return g>0?1:2; if(sumof(R)<g) return 1;
  uint64_t idx=(uint64_t)R*G+g; if(tab[idx]) return tab[idx]; int best=1;
  for(int x=M;x>=1;x--) if(R>>(x-1)&1){ uint32_t R2=R&~(1u<<(x-1)); int r=(x>=g)?4-v(R2,x-g):v(R2,g-x); if(r>best){best=r; if(best==3)break;} }
  tab[idx]=best; return best; }
static int mv(uint32_t R,int g,int y){ uint32_t R2=R&~(1u<<(y-1)); return (y>=g)?4-v(R2,y-g):v(R2,g-y); }
static uint32_t *PU; static int *PK; static int npu=0;
static void rec(int start,uint32_t R,int k){ PU[npu]=R; PK[npu]=k; npu++; for(int a=start;a+1<=M;a++) rec(a+2,R|(3u<<(a-1)),k+1); }
static int haspair(uint32_t R,int p){ for(int x=1;x<=M;x++) if(R>>(x-1)&1){ if(x==p) return 1; if(x>p) return 0; x++; } return 0; }
static void pr(uint32_t R){ printf("["); for(int x=1;x<=M;x++) if(R>>(x-1)&1){printf("%d,",x);x++;} printf("]"); }
int main(int c,char**argv){ M=atoi(argv[1]); G=M+2; tab=calloc(((uint64_t)1<<M)*G,1);
  PU=malloc(4*2000000); PK=malloc(4*2000000); rec(1,0,0);
  /* F2: v(Q,2) for even pair-unions Q, split by pair {2,3} present */
  long c2[2][4]={{0}}; int sh=0;
  for(int i=0;i<npu;i++){ if(PK[i]&1) continue; uint32_t Q=PU[i]; if(!Q) continue; int h=haspair(Q,2); int val=v(Q,2); c2[h][val]++;
    if(!h && val==3 && sh<10){ sh++; printf("  W at (Q,2) without {2,3}: "); pr(Q); printf("\n"); } }
  printf("F2 v(Q,2), Q even nonempty pair-union in {1..%d}: without pair{2,3}: L=%ld D=%ld W=%ld ; with pair{2,3}: L=%ld D=%ld W=%ld\n",M,c2[0][1],c2[0][2],c2[0][3],c2[1][1],c2[1][2],c2[1][3]);
  /* F4: v({3} u Q', 4), Q' pair-union inside {4..M}; split by k parity */
  long c4[2][4]={{0}}; sh=0;
  for(int i=0;i<npu;i++){ uint32_t Q=PU[i]; if(Q&7) continue; uint32_t S=Q|4u; int val=v(S,4); c4[PK[i]&1][val]++;
    if((PK[i]&1) && val!=2 && sh<10){ sh++; printf("  non-D at ({3}uQ',4), k odd: Q'="); pr(Q); printf(" v=%c\n","?LDW"[val]); } }
  printf("F4 v({3}uQ',4), Q' pair-union in {4..%d}: k odd: L=%ld D=%ld W=%ld ; k even: L=%ld D=%ld W=%ld\n",M,c4[1][1],c4[1][2],c4[1][3],c4[0][1],c4[0][2],c4[0][3]);
  /* combined: with r6, the (Q,2) positions arising are Q = R-{a,a+1} where R odd pair-union w/o pair {2,3} or a<4; values */
  return 0; }
