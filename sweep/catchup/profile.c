/* Profiles g -> v(S,g) for S = {1..N}, and the quadruple-extension test:
   for sets S with max S = m, is v(S ∪ {m+1..m+4}, 0) = v(S, 0)? */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
static int M; /* universe 1..M */
static uint8_t *tab; /* index R*(M+1)+g ; gap capped at M */
static int v(uint32_t R,int g,int sumR){
  if(!R) return g>0?1:2;
  if(sumR<g) return 1;
  uint64_t idx=(uint64_t)R*(M+1)+g;
  if(tab[idx]) return tab[idx];
  int best=1;
  for(int x=M;x>=1;x--) if(R>>(x-1)&1){ uint32_t R2=R&~(1u<<(x-1));
    int r=(x>=g)?4-v(R2,x-g,sumR-x):v(R2,g-x,sumR-x); if(r>best){best=r; if(best==3)break;} }
  tab[idx]=best; return best;
}
static int sumof(uint32_t R){int s=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1) s+=x; return s;}
int main(int c,char**a){
  M=atoi(a[1]);
  tab=calloc(((uint64_t)1<<M)*(M+1),1);
  const char*nm="?LDW";
  for(int N=0;N+0<=M;N++){ uint32_t R=(N?((1u<<N)-1):0); printf("N=%2d T%%2=%d profile g=0..N: ",N,(N*(N+1)/2)%2);
    for(int g=0;g<=N && g<=M;g++) putchar(nm[v(R,g,sumof(R))]); putchar('\n'); }
  /* quadruple extension test over all S with max S = m <= M-4 */
  long long tot=0,pres=0,draws=0,drawpres=0;
  for(uint32_t S=1; S < (1u<<(M-4)); S++){
    int m=32-__builtin_clz(S); uint32_t Q=0xFu<<m; int s=sumof(S);
    int a0=v(S,0,s), a1=v(S|Q,0,s+4*m+10); tot++; if(a0==a1)pres++;
    if(a0==2){draws++; if(a1==2)drawpres++;}
  }
  printf("quad-extension: sets %lld, value preserved %lld; draws %lld, draw preserved %lld\n",tot,pres,draws,drawpres);
}
