/* Over all R ⊆ {1..M}, 1 <= g <= M, sum R >= g: compare v(R,g) with the parity-best
   outcome (W if sumR-g odd, D if even).  Report failures by g and smallest examples. */
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
int main(int c,char**a){ M=atoi(a[1]); tab=calloc(((uint64_t)1<<M)*(M+1),1);
  long long tot[40]={0},fail[40]={0},failL[40]={0};
  for(uint32_t R=1;R<(1u<<M);R++){ int s=0,cnt=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1){s+=x;cnt++;}
    for(int g=1;g<=M;g++){ if(s<g) continue; int r=v(R,g,s); int pb=((s-g)&1)?3:2;
      tot[g]++; if(r!=pb){ fail[g]++; if(r==1) failL[g]++; } } }
  for(int g=1;g<=M;g++) printf("g=%2d positions=%lld not-parity-best=%lld (of which loss=%lld)\n",g,tot[g],fail[g],failL[g]);
}
