/* read graphs: line "n e u1 v1 u2 v2 ..."; print "i mu" per graph */
#include <stdio.h>
#include "eval.h"
int main(void){
  int n,e;
  while(scanf("%d %d",&n,&e)==2){
    N=n; memset(ADJ,0,sizeof ADJ);
    for(int k=0;k<e;k++){int a,b;scanf("%d %d",&a,&b);ADJ[a]|=1ULL<<b;ADJ[b]|=1ULL<<a;}
    {int ii=indep_dom(); printf("%d %d %ld\n",ii,sat_num(),count_idom(ii,1000000000L));} fflush(stdout);
  }
}
