/* print every independent dominating set of size i(G) (distinct sets), with a summary */
#include <stdio.h>
#include "eval.h"
static int target; static int stack_[64], sp;
static void rec(u64 dom, u64 excl, int sz){
  u64 und=((1ULL<<N)-1)&~dom;
  if(!und){printf("set:");for(int k=0;k<sp;k++)printf(" %d",stack_[k]);printf("\n");return;}
  if(sz>=target)return;
  int bv=-1,bc=100;
  for(u64 t=und;t;t&=t-1){int v=__builtin_ctzll(t);int c=popc((ADJ[v]|(1ULL<<v))&und&~excl);if(c==0)return;if(c<bc){bc=c;bv=v;}}
  u64 cand=(ADJ[bv]|(1ULL<<bv))&und&~excl;
  for(u64 t=cand;t;t&=t-1){int w=__builtin_ctzll(t);stack_[sp++]=w;rec(dom|ADJ[w]|(1ULL<<w),excl,sz+1);sp--;excl|=1ULL<<w;}
}
int main(void){int e;if(scanf("%d %d",&N,&e)!=2)return 1;for(int k=0;k<e;k++){int a,b;if(scanf("%d %d",&a,&b)!=2)return 1;ADJ[a]|=1ULL<<b;ADJ[b]|=1ULL<<a;}
 target=indep_dom();printf("i=%d mu=%d\n",target,sat_num());rec(0,0,0);}
