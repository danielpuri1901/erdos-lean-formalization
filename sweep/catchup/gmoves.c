/* In G-positions (R = disjoint union of k pairs {a,a+1}, g = k mod 2), classify each single
   pick x of the mover by the opponent's value v(R-x, x-g): count picks where the opponent
   gets exactly D (drawing picks) vs W.  Also test reply rules for the hard case
   (k odd, g = 1, x = a): does "opponent takes a+1" give the opponent >= D? */
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
static long long pos=0, picks[2][4], small_draw_all=0, large_draw_all=0, hard=0, hard_ok=0;
static void rec(int start,uint32_t R,int np){
  if(R){ int g=np&1, s=sumof(R); pos++; int sd=1, ld=1;
    for(int x=1;x<=M;x++) if(R>>(x-1)&1){ int small = !((R>>x)&1) ? 0 : 1; /* x+1 in R and x is a pair start? */
      /* determine if x is the smaller element of its pair: pairs are disjoint, scan from left */
      (void)small; }
    /* recover pairs by scanning */
    int pa[20], n=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1){ pa[n++]=x; x++; }
    for(int i=0;i<n;i++){ int a=pa[i];
      for(int w=0;w<2;w++){ int x=a+w; uint32_t R2=R&~(1u<<(x-1)); int r=v(R2,x-g,s-x); picks[w][r]++;
        if(r!=2){ if(w==0) sd=0; else ld=0; }
        if(g==1 && w==0){ hard++; /* opponent takes a+1: lead (a+1)-(a-1)=2, mover faces (R\p,2) */
          uint32_t R3=R2&~(1u<<a); int rr = 4 - v(R3,2,s-x-(a+1)); if(rr>=2) hard_ok++; } } }
    small_draw_all+=sd; large_draw_all+=ld; }
  for(int a=start;a+1<=M;a++) rec(a+2,R|(3u<<(a-1)),np+1);
}
int main(int c,char**argv){ M=atoi(argv[1]); tab=calloc(((uint64_t)1<<M)*(M+1),1);
  rec(1,0,0);
  printf("G-positions: %lld\n",pos);
  printf("picks of smaller element a: opp L=%lld D=%lld W=%lld\n",picks[0][1],picks[0][2],picks[0][3]);
  printf("picks of larger element a+1: opp L=%lld D=%lld W=%lld\n",picks[1][1],picks[1][2],picks[1][3]);
  printf("positions where every smaller-element pick draws: %lld; every larger-element pick draws: %lld\n",small_draw_all,large_draw_all);
  printf("hard case (k odd, pick a): reply a+1 secures >= D for opponent in %lld of %lld\n",hard_ok,hard);
}
