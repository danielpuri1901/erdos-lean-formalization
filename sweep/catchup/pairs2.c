/* G : R = disjoint union of k pairs {a,a+1} in {1..M}:  v(R,0)=D if k even, v(R,1)=D if k odd.
   G3: R = triple {t,t+1,t+2} ∪ disjoint pairs (all disjoint) in {1..M}: tabulate v(R,0), v(R,1)
       by (t parity, k parity). */
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
static long long gtot=0,gbad=0; static long long c3[2][2][2][4];
static uint32_t used;
static void recP(int start,uint32_t R,int np,int t){
  if(t==0){ if(R){ int s=sumof(R); int g=np&1; gtot++; if(v(R,g,s)!=2){ gbad++; } } }
  else { int s=sumof(R); for(int g=0;g<2;g++) c3[t&1][np&1][g][v(R,g,s)]++; }
  for(int a=start;a+1<=M;a++){ uint32_t p=3u<<(a-1); if(R&p) continue; recP(a+2,R|p,np+1,t); }
}
int main(int c,char**argv){ M=atoi(argv[1]); tab=calloc(((uint64_t)1<<M)*(M+1),1);
  recP(1,0,0,0);
  printf("G on {1..%d}: %lld pair-unions, %lld violations\n",M,gtot,gbad); fflush(stdout);
  for(int t=1;t+2<=M;t++) recP(1,7u<<(t-1),0,t);
  const char*nm="?LDW";
  for(int tp=0;tp<2;tp++) for(int kp=0;kp<2;kp++) for(int g=0;g<2;g++)
    printf("G3 triple start %s, pairs %s, g=%d: L=%lld D=%lld W=%lld\n",tp?"odd":"even",kp?"odd":"even",g,c3[tp][kp][g][1],c3[tp][kp][g][2],c3[tp][kp][g][3]);
}
