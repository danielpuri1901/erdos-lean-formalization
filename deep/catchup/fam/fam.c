/* Catch-Up gap-form solver + pairs-family experiments.  usage: fam M [dump]
   values: 1=L 2=D 3=W (mover's view). R bitmask bit i-1 <-> number i. */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
static int M,G; static uint8_t *tab;
static int sumof(uint32_t R){int s=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1) s+=x; return s;}
static int v(uint32_t R,int g){
  if(!R) return g>0?1:2;
  int s=sumof(R); if(s<g) return 1;
  uint64_t idx=(uint64_t)R*G+g; if(tab[idx]) return tab[idx];
  int best=1;
  for(int x=M;x>=1;x--) if(R>>(x-1)&1){ uint32_t R2=R&~(1u<<(x-1));
    int r=(x>=g)?4-v(R2,x-g):v(R2,g-x); if(r>best){best=r; if(best==3)break;} }
  tab[idx]=best; return best;
}
/* value, for the player who picks, of picking y at (R,g) */
static int mv(uint32_t R,int g,int y){ uint32_t R2=R&~(1u<<(y-1)); return (y>=g)?4-v(R2,y-g):v(R2,g-y); }
static const char *VS="?LDW";
static void prR(FILE*f,uint32_t R){ fprintf(f,"{"); int first=1; for(int x=1;x<=M;x++) if(R>>(x-1)&1){fprintf(f,first?"%d":",%d",x);first=0;} fprintf(f,"}"); }
static void prPairs(FILE*f,uint32_t R){ fprintf(f,"["); int first=1; for(int x=1;x<=M;x++) if(R>>(x-1)&1){fprintf(f,first?"%d":",%d",x);first=0;x++;} fprintf(f,"]"); }
/* enumerate pair-unions */
static uint32_t *PU; static int *PK; static int npu=0;
static void rec(int start,uint32_t R,int k){ PU[npu]=R; PK[npu]=k; npu++;
  for(int a=start;a+1<=M;a++) rec(a+2,R|(3u<<(a-1)),k+1); }
static int parbest(uint32_t R,int g){ int s=sumof(R)+g; int val=v(R,g); return (s&1)? val==3 : val==2; }
int main(int c,char**argv){ M=atoi(argv[1]); G=M+2;
  tab=calloc(((uint64_t)1<<M)*G,1);
  if(c>2){ /* dump all values */
    for(uint32_t R=0;R<(1u<<M);R++){ for(int g=0;g<G;g++) putchar(VS[v(R,g)]); putchar('\n'); } return 0; }
  char fn[256];
  /* sanity */
  printf("== sanity v({1..N},0):"); int bad=0;
  for(int N=0;N<=M;N++){ uint32_t R=(N==0)?0:((1u<<N)-1); int val=v(R,0);
    int exp; int m=N%4; if(m==0||m==3) exp=2; else if(N==9||N==10||N==14||N==18) exp=1; else exp=3;
    printf(" %d:%c",N,VS[val]); if(val!=exp) bad++; }
  printf("\n   mismatches vs expected: %d\n",bad);
  PU=malloc(sizeof(uint32_t)*2000000); PK=malloc(sizeof(int)*2000000); rec(1,0,0);
  /* (P) */
  long tot=0,viol=0;
  for(int i=0;i<npu;i++){ uint32_t R=PU[i]; if(!R) continue; tot++; int val=(PK[i]%2==0)?v(R,0):v(R,1); if(val!=2){viol++; if(viol<5){printf("P viol ");prR(stdout,R);printf("\n");}} }
  printf("== (P): %ld nonempty pair-unions in {1..%d}, %ld violations\n",tot,M,viol);
  /* (P3): {1,2,3} u k pairs a>=4, k even */
  tot=0;viol=0; long tot3odd=0,d3odd=0;
  for(int i=0;i<npu;i++){ uint32_t R=PU[i]; if(R&7) continue; uint32_t R3=R|7;
    if(PK[i]%2==0){ tot++; if(v(R3,0)!=2){viol++; if(viol<5){printf("P3 viol ");prR(stdout,R3);printf("\n");}} }
    else { tot3odd++; if(v(R3,1)==2) d3odd++; } }
  printf("== (P3): %ld sets {1,2,3}u(k even pairs >=4) (incl k=0) in {1..%d}, %ld violations;  [k odd: v(.,1)=D in %ld of %ld]\n",tot,M,viol,d3odd,tot3odd);
  /* Task 2: hard case */
  sprintf(fn,"hard_%d.txt",M); FILE*fh=fopen(fn,"w");
  fprintf(fh,"# odd pair-union R (pair starts), a = smaller elt of a pair taken by mover at gap 1; opponent at (R-a, a-1).\n# columns: pairs | a | v_opp(R-a,a-1) | good first picks (W marked) | a+1 good?\n");
  long H=0, f1=0,f2=0,f3=0,f4a=0,f4b=0,f5=0, nogood=0; int s1=0,s2=0,s3=0,s4a=0,s4b=0,s5=0;
  char b1[4000]="",b2[4000]="",b3[4000]="",b4a[4000]="",b4b[4000]="",b5[4000]="";
  long a1fail_has2345=0; long f6=0,f6b=0; int s6=0,s6b=0; char b6[4000]="",b6b[4000]=""; long fixp[16]={0};
  long histFailA[64]={0}, histBelowPar[2]={0}, histTotA[64]={0};
  for(int i=0;i<npu;i++){ uint32_t R=PU[i]; if(!(PK[i]&1)) continue;
    int has2345 = ((R>>1)&15)==15 && !(R&1); /* {2,3},{4,5} as pairs: bits 2..5 set, 1 not set */
    /* proper: pairs decomposition from left; check decomposition contains pair starting at 2 and 4 */
    { int st[32],np=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1){st[np++]=x;x++;} has2345=0; int h2=0,h4=0; for(int j=0;j<np;j++){ if(st[j]==2)h2=1; if(st[j]==4)h4=1;} has2345=h2&&h4; }
    int npbelow=0;
    for(int a=1;a<M;a++){ if(!(R>>(a-1)&1)) continue;
      /* a must be start of decomposition pair */
      int ok=0,cnt=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1){ if(x==a){ok=1;break;} if(x==a+1) break; x++; cnt++; }
      if(!ok) continue; npbelow=cnt;
      H++; histTotA[a]++;
      uint32_t R2=R&~(1u<<(a-1)); int g=a-1;
      fprintf(fh,"%d ",PK[i]); prPairs(fh,R); fprintf(fh," a=%d v_opp=%c good:",a,VS[v(R2,g)]);
      int any=0; for(int y=1;y<=M;y++) if(R2>>(y-1)&1){ int r=mv(R2,g,y); if(r>=2){fprintf(fh," %d%s",y,r==3?"W":"");any=1;} }
      if(!any) nogood++;
      int r1 = mv(R2,g,a+1)>=2;
      fprintf(fh," | a+1:%s%s\n",r1?"good":"BAD",has2345?" [has23,45]":"");
      #define REC(flag,cnt,shown,buf) if(!(flag)){ cnt++; if(shown<10){shown++; char t[200]; int L=0; L+=sprintf(t+L,"("); for(int x=1;x<=M;x++) if(R>>(x-1)&1){L+=sprintf(t+L,"%d.",x);x++;} sprintf(t+L,",a=%d) ",a); strcat(buf,t);} }
      REC(r1,f1,s1,b1);
      if(!r1){ histFailA[a]++; histBelowPar[npbelow&1]++; if(has2345) a1fail_has2345++; }
      int r2 = ((a>=2) && (R2>>(a-2)&1)) ? (mv(R2,g,a-1)>=2) : r1;
      REC(r2,f2,s2,b2);
      int ys=0; for(int y=(g<1?1:g);y<=M;y++) if(R2>>(y-1)&1){ys=y;break;}
      int r3 = ys? mv(R2,g,ys)>=2 : 0;
      REC(r3,f3,s3,b3);
      /* r4a: a+1 unless has2345; then a+1 or prepick p in{2..5}, p<g, followed by a+1 */
      int r4a=r1, r4b=r1;
      if(!r1 && has2345){
        for(int p=2;p<=5;p++) if((R2>>(p-1)&1) && p<g){ uint32_t R3=R2&~(1u<<(p-1)); int g3=g-p;
          if(R3>>a&1){ if(mv(R3,g3,a+1)>=2) r4a=1; }
          if(v(R3,g3)>=2) r4b=1; }
      }
      REC(r4a,f4a,s4a,b4a); REC(r4b,f4b,s4b,b4b);
      { int h2=0; for(int x=1;x<=M;x++) if(R>>(x-1)&1){ if(x==2){h2=1;break;} if(x>2)break; x++; }
        int r6; if(h2 && a>=4){ uint32_t R3=R2&~2u; r6 = mv(R3,g-2,a+1)>=2; } else r6=r1;
        int r6b = r1 || r6; REC(r6,f6,s6,b6); REC(r6b,f6b,s6b,b6b); }
      if(!r1){ for(int p=1;p<=8;p++){ int okp=0; if((R2>>(p-1)&1) && p<g){ uint32_t R3=R2&~(1u<<(p-1)); if((R3>>a&1) && mv(R3,g-p,a+1)>=2) okp=1; } if(!okp) fixp[p]++; } }
      /* r5: a+1, else any pre-pick p<g (any p) followed by optimal continuation */
      int r5=r1; if(!r1){ for(int p=1;p<g;p++) if((R2>>(p-1)&1)){ if(v(R2&~(1u<<(p-1)),g-p)>=2) r5=1; } }
      REC(r5,f5,s5,b5);
    } }
  fclose(fh);
  printf("== hard case: %ld positions (R odd pair-union, a pair start); positions with NO good reply: %ld\n",H,nogood);
  printf("  r1 a+1                          : %ld fail  %s\n",f1,b1);
  printf("  r2 tie a-1 if avail else a+1    : %ld fail  %s\n",f2,b2);
  printf("  r3 smallest y>=a-1              : %ld fail  %s\n",f3,b3);
  printf("  r4a a+1 | {23,45}: p in2..5 then a+1 : %ld fail  %s\n",f4a,b4a);
  printf("  r4b a+1 | {23,45}: p in2..5 then best: %ld fail  %s\n",f4b,b4b);
  printf("  r5  a+1 | any pre-pick p<a-1 then best: %ld fail  %s\n",f5,b5);
  printf("  r1 failures with {2,3},{4,5}: %ld of %ld; parity of #pairs below a among r1 failures: even %ld odd %ld\n",a1fail_has2345,f1,histBelowPar[0],histBelowPar[1]);
  printf("  r1 failures by a:"); for(int a=1;a<M;a++) if(histTotA[a]) printf(" a=%d:%ld/%ld",a,histFailA[a],histTotA[a]); printf("\n");
  printf("  r6  if {2,3} a pair and a>=4: 2 then a+1, else a+1 : %ld fail  %s\n",f6,b6);
  printf("  r6b a+1 if good, else 2 then a+1 : %ld fail  %s\n",f6b,b6b);
  printf("  among r1 failures, fixed pre-pick p then a+1 fails:"); for(int p=1;p<=8;p++) printf(" p=%d:%ld",p,fixp[p]); printf("\n");
  fflush(stdout);
  /* Task 3: gaps */
  sprintf(fn,"gaps_%d.txt",M); FILE*fg=fopen(fn,"w");
  fprintf(fg,"# pair-unions R (nonempty) in {1..%d}: per gap g, #R with sum>=g, #parity-best, exceptions (pairs starts, value)\n",M);
  for(int g=0;g<=M+1;g++){ long n=0,pb=0; int ex=0; char eb[2000]=""; 
    for(int i=0;i<npu;i++){ uint32_t R=PU[i]; if(!R) continue; if(sumof(R)<g) continue; n++; if(parbest(R,g)) pb++; else if(ex<5){ex++; char t[200]; int L=sprintf(t,"k%d[",PK[i]); for(int x=1;x<=M;x++) if(R>>(x-1)&1){L+=sprintf(t+L,"%d,",x);x++;} sprintf(t+L,"]=%c ",VS[v(R,g)]); strcat(eb,t);} }
    fprintf(fg,"g=%d n=%ld parity-best=%ld (%.2f%%) ex: %s\n",g,n,pb,n?100.0*pb/n:0,eb);
    for(int par=0;par<2;par++){ long n2=0,p2=0,nd=0,nw=0,nl=0; for(int i=0;i<npu;i++){ uint32_t R=PU[i]; if(!R||(PK[i]&1)!=par||sumof(R)<g) continue; n2++; p2+=parbest(R,g); int val=v(R,g); if(val==1)nl++; else if(val==2)nd++; else nw++; }
      fprintf(fg,"   k%s: n=%ld parity-best=%ld (%.2f%%)  L=%ld D=%ld W=%ld\n",par?"odd ":"even",n2,p2,n2?100.0*p2/n2:0,nl,nd,nw); } }
  fclose(fg);
  /* singles, grouped by k parity as well */
  sprintf(fn,"single_%d.txt",M); FILE*fs=fopen(fn,"w");
  int OFF=M+2; int W2=2*M+5;
  fprintf(fs,"# R = pair-union of k pairs (incl k=0) u {s}, s not in pairs, in {1..%d}; groups by (kpar,d=g-s) and (kpar,g,s); ALL=100%%, NEARLY>=99%%\n",M);
  for(int par=0;par<2;par++){
  long *nGS=calloc(G*(M+1),sizeof(long)),*pGS=calloc(G*(M+1),sizeof(long));
  long *nD=calloc(W2,sizeof(long)),*pD=calloc(W2,sizeof(long));
  for(int i=0;i<npu;i++){ uint32_t R=PU[i]; if((PK[i]&1)!=par) continue;
    for(int s=1;s<=M;s++){ if(R>>(s-1)&1) continue; uint32_t RS=R|(1u<<(s-1)); int sm=sumof(RS);
      for(int g=0;g<=M+1&&g<=sm;g++){ int pb=parbest(RS,g); nGS[g*(M+1)+s]++; pGS[g*(M+1)+s]+=pb; nD[g-s+OFF]++; pD[g-s+OFF]+=pb; } } }
  fprintf(fs,"## k %s: groups by d=g-s\n",par?"odd":"even");
  for(int d=-M;d<=M+1;d++){ long n=nD[d+OFF],p=pD[d+OFF]; if(!n) continue; fprintf(fs,"k%s d=g-s=%d n=%ld pb=%ld %.3f%% %s\n",par?"odd":"even",d,n,p,100.0*p/n,p==n?"ALL":(p*100>=99*n?"NEARLY":"")); }
  fprintf(fs,"## k %s: (g,s) groups that are 100%% parity-best (n>=5), as g: s-list\n",par?"odd":"even");
  for(int g=0;g<=M+1;g++){ fprintf(fs,"k%s g=%d ALL s:",par?"odd":"even",g); for(int s=1;s<=M;s++){ long n=nGS[g*(M+1)+s]; if(n>=5&&pGS[g*(M+1)+s]==n) fprintf(fs," %d(n=%ld)",s,n);} fprintf(fs,"\n"); }
  fprintf(fs,"## k %s: NEARLY (>=99%%, not 100%%) (g,s) groups with exceptions\n",par?"odd":"even");
  for(int g=0;g<=M+1;g++) for(int s=1;s<=M;s++){ long n=nGS[g*(M+1)+s],p=pGS[g*(M+1)+s]; if(!n||p==n||p*100<99*n) continue;
    fprintf(fs,"k%s (g=%d,s=%d) n=%ld pb=%ld %.2f%% NEARLY ex:",par?"odd":"even",g,s,n,p,100.0*p/n);
    int ex=0; for(int i=0;i<npu&&ex<6;i++){ uint32_t R=PU[i]; if((PK[i]&1)!=par) continue; if(R>>(s-1)&1) continue; uint32_t RS=R|(1u<<(s-1)); if(sumof(RS)<g) continue; if(!parbest(RS,g)){ex++; fprintf(fs," pairs"); prPairs(fs,R); fprintf(fs,"=%c",VS[v(RS,g)]);} }
    fprintf(fs,"\n"); }
  }
  fclose(fs);
  printf("== done gaps_%d.txt single_%d.txt\n",M,M);
  return 0; }
