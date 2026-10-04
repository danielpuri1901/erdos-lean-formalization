/* Steepest-ascent scan over all double edge swaps (a-b, c-d) -> (a-d, c-b) and (a-c, b-d).
   Objective: i(G) - mu*(G) in units of 10^6 minus the number of minimum independent
   dominating sets (when i == mu*). Reads one graph "n e u v ...". Prints any graph with
   i > mu*. Usage: scan < graph */
#include <stdio.h>
#include <stdlib.h>
#include "eval.h"
static int EA[4096], EB[4096], NE;
static int build(void){memset(ADJ,0,sizeof ADJ);for(int k=0;k<NE;k++){int a=EA[k],b=EB[k];if(a==b||((ADJ[a]>>b)&1))return 0;ADJ[a]|=1ULL<<b;ADJ[b]|=1ULL<<a;}return 1;}
static long score(int *ii,int *mm){int i=indep_dom(),mu=sat_num();*ii=i;*mm=mu;if(i>mu)return 1;return -((long)(mu-i)*1000000+count_idom(i,100000));}
int main(void){
  if(scanf("%d %d",&N,&NE)!=2)return 1;
  for(int k=0;k<NE;k++)if(scanf("%d %d",&EA[k],&EB[k])!=2)return 1;
  build(); int i,mu; long cur=score(&i,&mu);
  fprintf(stderr,"start i=%d mu=%d score=%ld\n",i,mu,cur);
  for(int round=0;round<50;round++){
    long best=-1000000000L; int bp=-1,bq=-1,bt=0;
    for(int p=0;p<NE;p++)for(int q=p+1;q<NE;q++)for(int t=0;t<2;t++){
      int a=EA[p],b=EB[p],c=EA[q],d=EB[q];
      if(t==0){EB[p]=d;EB[q]=b;}else{EB[p]=c;EA[q]=b;}
      if(build()){long s=score(&i,&mu); if(s>0){printf("FOUND i=%d mu=%d\n%d %d",i,mu,N,NE);for(int k=0;k<NE;k++)printf(" %d %d",EA[k],EB[k]);printf("\n");return 0;}
        if(s>best){best=s;bp=p;bq=q;bt=t;}}
      EA[p]=a;EB[p]=b;EA[q]=c;EB[q]=d;
    }
    fprintf(stderr,"round %d best neighbour score %ld (current %ld)\n",round,best,cur);
    if(best<cur)break;
    {int a=EA[bp],b=EB[bp],c=EA[bq],d=EB[bq]; if(bt==0){EB[bp]=d;EB[bq]=b;}else{EB[bp]=c;EA[bq]=b;}}
    build(); cur=best;
  }
  printf("NOFIND score=%ld\n",cur); return 0;
}
