/* H*: R ⊆ {1..M} with #odd(R) = #even(R) = k (R splits into k pairs with odd difference).
   Is v(R, k mod 2) = D?  Count violations; print a few smallest. */
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
int main(int c,char**argv){ M=atoi(argv[1]); tab=calloc(((uint64_t)1<<M)*(M+1),1);
  long long tot=0,bad=0; int shown=0; const char*nm="?LDW";
  for(uint32_t R=1;R<(1u<<M);R++){ int s=0,o=0,e=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1){s+=x; if(x&1)o++; else e++;}
    if(o!=e) continue; int g=o&1; tot++; int r=v(R,g,s); if(r!=2){ bad++; if(shown<8){ shown++; printf("violation g=%d value=%c R={",g,nm[r]); for(int x=1;x<=M;x++) if(R>>(x-1)&1) printf(" %d",x); printf(" }\n"); } } }
  printf("H* on {1..%d}: %lld balanced sets, %lld violations\n",M,tot,bad);
}
