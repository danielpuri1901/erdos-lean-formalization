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
/* family: T0 pairs k even g0; T1 pairs k odd g1; T2 pairs k even g2 no pair{2,3}; T4 {3}u odd pairs in {4..} g4.
   check <=D closure: for every member and every mover full turn, some opponent full turn lands in the family. */
static int pairdec(uint32_t R,int *k,int *has23){ *k=0;*has23=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1){ if(x==M||!(R>>x&1)) return 0; if(x==2)*has23=1; (*k)++; x++; } return 1; }
static int type(uint32_t R,int g){ int k,h;
  if(pairdec(R,&k,&h)){ if(g==0&&!(k&1)) return 1; if(g==1&&(k&1)) return 2; if(g==2&&!(k&1)&&!h) return 3; return 0; }
  if(g==4 && (R&7)==4){ if(pairdec(R&~7u,&k,&h) && (k&1)) return 4; } return 0; }
static int found;
static void oppTurns(uint32_t R,int h){ if(found) return; /* opponent to move at (R,h) */
  for(int y=1;y<=M&&!found;y++) if(R>>(y-1)&1){ uint32_t R2=R&~(1u<<(y-1)); if(y>=h){ if(type(R2,y-h)) found=1; } else { int t=type(R2,h-y); if(t==1||t==2||t==4) found=1; else oppTurns(R2,h-y);} } }
static long hist[8][24]; static long histNone=0; static char shapes[200000][64]; static long shapeCnt[200000]; static int nsh=0;
static int nsing(uint32_t R,uint32_t *S){ int n=0; *S=0; int x=1; while(x<=M){ if(R>>(x-1)&1){ int y=x; while(y<=M&&(R>>(y-1)&1)) y++; if((y-x)&1){ n++; *S|=1u<<(y-2);} x=y; } else x++; } return n; }
static void classify(uint32_t R,int h){ /* best single-pick turn-ending securing reply */
  int bns=99,bg=99; uint32_t bS=0; int by=0;
  for(int y=1;y<=M;y++) if(R>>(y-1)&1){ if(y<h) continue; uint32_t R2=R&~(1u<<(y-1)); if(4-v(R2,y-h)<2) continue; uint32_t S; int ns=nsing(R2,&S); int g=y-h; if(ns<bns||(ns==bns&&g<bg)){bns=ns;bg=g;bS=S;by=y;} }
  if(bns==99){ histNone++; return; } if(bns>7)bns=7; hist[bns][bg<24?bg:23]++;
  char t[64]; int L=sprintf(t,"ns=%d g=%d sing-g:",bns,bg); for(int z=1;z<=M;z++) if(bS>>(z-1)&1) L+=sprintf(t+L,"%+d",z-bg);
  int j; for(j=0;j<nsh;j++) if(!strcmp(shapes[j],t)) break; if(j==nsh){ strcpy(shapes[nsh++],t);} shapeCnt[j]++; }
static long cnt[5],bad[5],memb[5],shown[5],notle[5];
static int curT; static uint32_t curR; static int curG;
static void moverTurns(uint32_t R,int g,uint32_t taken){
  for(int x=1;x<=M;x++) if(R>>(x-1)&1){ uint32_t R2=R&~(1u<<(x-1));
    if(x>=g){ cnt[curT]++; found=0; if(!R2 && x==g) found=1; else oppTurns(R2,x-g);
      if(!found){ bad[curT]++; classify(R2,x-g); if(shown[curT]<6){ shown[curT]++; printf("  T%d member R=",curT==1?0:curT==2?1:curT==3?2:4); for(int z=1;z<=M;z++) if(curR>>(z-1)&1) printf("%d.",z); printf(" g=%d, mover takes",curG); for(int z=1;z<=M;z++) if((taken|(1u<<(x-1)))>>(z-1)&1) printf(" %d",z); printf(" -> no reply into family (opp value %c)\n","?LDW"[v(R2,x-g)]); } } }
    else moverTurns(R2,g-x,taken|(1u<<(x-1))); } }
/* >=D half: does every opponent turn from (R,h) land in family? (turn-end at D-claimed member for mover, or mid-turn at any member for opponent) */
static int allLand(uint32_t R,int h){ if(!R) return h==0; for(int y=1;y<=M;y++) if(R>>(y-1)&1){ uint32_t R2=R&~(1u<<(y-1));
    if(y>=h){ int t=type(R2,y-h); if(!(t==1||t==2||t==4) && !(R2==0&&y==h)) return 0; }
    else { int t=type(R2,h-y); if(!t){ if(!allLand(R2,h-y)) return 0; } } } return 1; }
static int goodMoverTurn(uint32_t R,int g){ for(int x=1;x<=M;x++) if(R>>(x-1)&1){ uint32_t R2=R&~(1u<<(x-1));
    if(x>=g){ if(allLand(R2,x-g)) return x; } else { int t=type(R2,g-x); if(t==1||t==2||t==4) return x; if(goodMoverTurn(R2,g-x)) return x; } } return 0; }
static long geBad[5],geShown[5]; static long firstPick[5][32];
int main(int c,char**argv){ M=atoi(argv[1]); G=M+2; tab=calloc(((uint64_t)1<<M)*G,1);
  for(uint32_t R=0;R<(1u<<M);R++) for(int g=0;g<=4;g++){ int t=type(R,g); if(!t||!R) continue; memb[t]++; if(v(R,g)>2) notle[t]++; curT=t; curR=R; curG=g; moverTurns(R,g,0); }
  for(uint32_t R=1;R<(1u<<M);R++) for(int g=0;g<=4;g++){ int t=type(R,g); if(!(t==1||t==2||t==4)) continue; int x=goodMoverTurn(R,g); if(!x){ geBad[t]++; if(geShown[t]<5){geShown[t]++; printf("  >=D fail T%d R=",t); for(int z=1;z<=M;z++) if(R>>(z-1)&1) printf("%d.",z); printf(" g=%d\n",g);} } }
  printf(">=D half (exists mover pick s.t. every opponent turn lands in family): failures T0=%ld T1=%ld T4=%ld\n",geBad[1],geBad[2],geBad[4]);
  printf("best single-pick securing replies for unclosed turns (fewest singletons, then smallest gap); none-single-pick: %ld\n",histNone);
  for(int j=0;j<nsh;j++) if(shapeCnt[j]>=10) printf("  %s : %ld\n",shapes[j],shapeCnt[j]);
  const char*nm[5]={"","T0 pairs k even g=0","T1 pairs k odd g=1","T2 pairs k even g=2 no {2,3}","T4 {3}u odd pairs>=4 g=4"};
  for(int t=1;t<=4;t++) printf("%s: members %ld (v=W: %ld), mover turns %ld, turns with no reply into family %ld\n",nm[t],memb[t],notle[t],cnt[t],bad[t]);
  return 0; }
