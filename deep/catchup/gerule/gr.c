/* gr M : solve Catch-Up gap form for R in {1..M}, output pair-union good sets.
   values 1=L 2=D 3=W mover's view. Output pos_M.txt: k g starts... | goodmask(bits x-1) | Wmask */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
static int M,G; static uint8_t *tab;
static int sumof(uint32_t R){int s=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1) s+=x; return s;}
static int v(uint32_t R,int g){
  if(!R) return g>0?1:2;
  if(sumof(R)<g) return 1;
  uint64_t idx=(uint64_t)R*G+g; if(tab[idx]) return tab[idx];
  int best=1;
  for(int x=M;x>=1;x--) if(R>>(x-1)&1){ uint32_t R2=R&~(1u<<(x-1));
    int r=(x>=g)?4-v(R2,x-g):v(R2,g-x); if(r>best){best=r; if(best==3)break;} }
  tab[idx]=best; return best;
}
static int mv(uint32_t R,int g,int y){ uint32_t R2=R&~(1u<<(y-1)); return (y>=g)?4-v(R2,y-g):v(R2,g-y); }
static const char *VS="?LDW";
static int st[32],ns; static FILE*fo; static long cnt=0;
static void emit(uint32_t R,int k){
  int g=(k%2==0)?0:1; uint32_t gm=0,wm=0;
  for(int x=1;x<=M;x++) if(R>>(x-1)&1){ int r=mv(R,g,x); if(r>=2) gm|=1u<<(x-1); if(r==3) wm|=1u<<(x-1);} 
  fprintf(fo,"%d %d %c",k,g,VS[v(R,g)]); for(int i=0;i<k;i++) fprintf(fo," %d",st[i]);
  fprintf(fo," | %u %u\n",gm,wm); cnt++;
}
static void rec(int start,uint32_t R,int k){ if(k) emit(R,k);
  for(int a=start;a+1<=M;a++){ st[k]=a; rec(a+2,R|(3u<<(a-1)),k+1);} }
int main(int c,char**argv){ M=atoi(argv[1]); G=M+2;
  tab=calloc(((uint64_t)1<<M)*G,1);
  printf("sanity v({1..N},0):"); int bad=0;
  for(int N=0;N<=M;N++){ uint32_t R=(N==0)?0:((1u<<N)-1); int val=v(R,0);
    int exp; int m=N%4; if(m==0||m==3) exp=2; else if(N==9||N==10||N==14||N==18) exp=1; else exp=3;
    printf(" %d:%c",N,VS[val]); if(val!=exp) bad++; }
  printf("\nmismatches: %d\n",bad);
  char fn[64]; sprintf(fn,"pos_%d.txt",M); fo=fopen(fn,"w"); rec(1,0,0); fclose(fo);
  printf("positions: %ld\n",cnt); return 0; }
