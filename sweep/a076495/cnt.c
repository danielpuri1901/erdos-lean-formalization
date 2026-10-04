// independent check: count x<=N with sigma(x) mod x == T, for T=0..40 (plain divisor-sum sieve)
#include <stdio.h>
#include <stdlib.h>
int main(int argc,char**argv){ long N=atol(argv[1]); unsigned long*s=calloc(N+1,8);
 for(long d=1;d<=N;d++)for(long m=d;m<=N;m+=d)s[m]+=d; long c[41]={0};
 for(long x=1;x<=N;x++){unsigned long r=s[x]%x; if(r<=40)c[r]++;}
 for(int i=0;i<=40;i++)printf("%d %ld\n",i,c[i]); }
