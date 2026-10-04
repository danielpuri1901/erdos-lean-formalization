/* minimal closure of pairs positions under "partner reply, else smallest securing first pick". usage: closure M */
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
static uint8_t *inF, *seenT; static uint32_t *QR; static int *QG; static int qh=0,qt=0; static long notD=0, nofail=0, partnerUsed=0, smallUsed=0;
static void add(uint32_t R,int g){ uint64_t i=(uint64_t)R*G+g; if(inF[i]) return; inF[i]=1; QR[qt]=R; QG[qt]=g; qt++; }
static void reply(uint32_t R,int h,int x){ /* opponent to move at (R,h); ensure turn */
  for(;;){ if(!R){ if(h>0) nofail++; return; }
    int y=0; int c[2]={x+1,x-1};
    for(int j=0;j<2;j++){ int z=c[j]; if(z>=1&&z<=M&&(R>>(z-1)&1)&&mv(R,h,z)>=2){y=z;break;} }
    if(y) partnerUsed++; else { for(int z=1;z<=M;z++) if((R>>(z-1)&1)&&mv(R,h,z)>=2){y=z;break;} if(y) smallUsed++; }
    if(!y){ nofail++; return; }
    uint32_t R2=R&~(1u<<(y-1));
    if(y>=h){ add(R2,y-h); return; }
    R=R2; h=h-y; } }
static void moverTurns(uint32_t R,int g){ /* all mover turns from (R,g) */
  uint64_t i=(uint64_t)R*G+g; if(seenT[i]) return; seenT[i]=1;
  for(int x=1;x<=M;x++) if(R>>(x-1)&1){ uint32_t R2=R&~(1u<<(x-1));
    if(x>=g) reply(R2,x-g,x); else moverTurns(R2,g-x); } }
static int nsing(uint32_t R,uint32_t *S){ int n=0; *S=0; int x=1; while(x<=M){ if(R>>(x-1)&1){ int y=x; while(y<=M&&(R>>(y-1)&1)) y++; if((y-x)&1){ n++; } /* singleton = last elt of odd run? record run end */ if((y-x)&1) *S|=1u<<(y-2); x=y; } else x++; } return n; }
int main(int c,char**argv){ M=atoi(argv[1]); G=M+2; uint64_t N=((uint64_t)1<<M)*G;
  tab=calloc(N,1); inF=calloc(N,1); seenT=calloc(N,1); QR=malloc(N*4); QG=malloc(N*4);
  /* initial pair positions */
  for(uint32_t R=1;R<(1u<<M);R++){ /* is pair-union? */ int k=0,ok=1; for(int x=1;x<=M;x++) if(R>>(x-1)&1){ if(x==M||!(R>>x&1)){ok=0;break;} k++; x++; }
    if(ok) add(R,k&1); }
  int init=qt;
  while(qh<qt){ uint32_t R=QR[qh]; int g=QG[qh]; qh++; if(v(R,g)!=2) notD++; memset(seenT,0,N); moverTurns(R,g); }
  long vc[4]={0}; for(int i=0;i<qt;i++) vc[v(QR[i],QG[i])]++; printf("member values L=%ld D=%ld W=%ld\n",vc[1],vc[2],vc[3]);
  printf("M=%d initial pair positions %d, closure size %d, members with v!=D %ld, reply failures %ld, partner replies %ld, smallest replies %ld\n",M,init,qt,notD,nofail,partnerUsed,smallUsed);
  /* classify */
  static long cls[32][32]; static long near[32][32]; long nearAll=0;
  for(int i=0;i<qt;i++){ uint32_t S; int ns=nsing(QR[i],&S); int g=QG[i]; cls[ns][g]++;
    int nr=0; for(int s=1;s<=M;s++) if(S>>(s-1)&1) for(int d=-2;d<=2;d++) if(g==s+d) nr=1; if(nr){near[ns][g]++; nearAll++;} }
  printf("classification (#singletons ns, gap g): count [count with g within 2 of some singleton]\n");
  for(int ns=0;ns<32;ns++) for(int g=0;g<G;g++) if(cls[ns][g]) printf("  ns=%d g=%d: %ld [%ld]\n",ns,g,cls[ns][g],near[ns][g]);
  printf("members with g within 2 of a singleton: %ld of %d\n",nearAll,qt);
  printf("members (R as list, g, v):\n");
  for(int i=0;i<qt;i++){ printf("  {"); int f=1; for(int x=1;x<=M;x++) if(QR[i]>>(x-1)&1){printf(f?"%d":",%d",x);f=0;} printf("} g=%d v=%c\n",QG[i],"?LDW"[v(QR[i],QG[i])]); }
  return 0; }
