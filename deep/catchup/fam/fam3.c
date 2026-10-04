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
int main(int c,char**argv){ M=atoi(argv[1]); G=M+2; tab=calloc(((uint64_t)1<<M)*G,1); PU=malloc(4*2000000); PK=malloc(4*2000000); rec(1,0,0);
  for(int g=2;g<=6;g++){ static long n[256],w[256],l[256]; memset(n,0,sizeof n); memset(w,0,sizeof w); memset(l,0,sizeof l);
    for(int i=0;i<npu;i++){ uint32_t R=PU[i]; if(!R||(PK[i]&1)!=(g&1)) continue; int key=R&0x7F; int val=v(R,g); n[key]++; if(val==3)w[key]++; if(val==1)l[key]++; }
    printf("gap %d (k%s): low pattern (elements <=7) : n W L\n",g,(g&1)?"odd":"even");
    for(int key=0;key<128;key++) if(n[key]){ printf("   {"); for(int x=1;x<=7;x++) if(key>>(x-1)&1) printf("%d,",x); printf("} n=%ld W=%ld L=%ld%s\n",n[key],w[key],l[key],w[key]==0?"":(w[key]==n[key]?"  ALL-W":"  some-W")); } }
  return 0; }
