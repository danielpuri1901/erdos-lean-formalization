/* v(R,0) for structured families R ⊆ {1..M}:
   A: unions of consecutive pairs {2k-1,2k};  B: unions of mirror pairs {k, M+1-k};
   C: unions of blocks {4j+1..4j+4};  D: intervals {a..b}. */
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
static void report(const char*name,uint32_t*fam,int n){
  int cnt[2][4]={{0}}; for(int i=0;i<n;i++){ int s=sumof(fam[i]); cnt[s&1][v(fam[i],0,s)]++; }
  printf("%s: %d sets | even sum: L=%d D=%d W=%d | odd sum: L=%d W=%d\n",name,n,cnt[0][1],cnt[0][2],cnt[0][3],cnt[1][1],cnt[1][3]);
}
int main(int c,char**a){ M=atoi(a[1]); tab=calloc(((uint64_t)1<<M)*(M+1),1);
  static uint32_t fam[1<<16]; int n;
  n=0; for(uint32_t K=1;K<(1u<<(M/2));K++){ uint32_t R=0; for(int k=1;k<=M/2;k++) if(K>>(k-1)&1) R|=3u<<(2*k-2); fam[n++]=R;} report("A consecutive pairs",fam,n);
  n=0; for(uint32_t K=1;K<(1u<<(M/2));K++){ uint32_t R=0; for(int k=1;k<=M/2;k++) if(K>>(k-1)&1) R|=(1u<<(k-1))|(1u<<(M-k)); fam[n++]=R;} report("B mirror pairs",fam,n);
  n=0; for(uint32_t K=1;K<(1u<<(M/4));K++){ uint32_t R=0; for(int k=0;k<M/4;k++) if(K>>k&1) R|=0xFu<<(4*k); fam[n++]=R;} report("C blocks of 4",fam,n);
  n=0; for(int a1=1;a1<=M;a1++) for(int b=a1;b<=M;b++){ uint32_t R=0; for(int x=a1;x<=b;x++) R|=1u<<(x-1); fam[n++]=R;} report("D intervals",fam,n);
}
