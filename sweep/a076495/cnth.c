// independent check of the pruned mode: count odd x<=N with sigma(x) > H*x and sigma(x) mod x == T, T=0..40
#include <stdio.h>
#include <stdlib.h>
int main(int argc,char**argv){ long N=atol(argv[1]); double H=atof(argv[2]); unsigned long*s=calloc(N+1,8);
 for(long d=1;d<=N;d+=2)for(long m=d;m<=N;m+=2*d)s[m]+=d; long c[41]={0};
 for(long x=3;x<=N;x+=2){ if((double)s[x]<=H*x) continue; unsigned long r=s[x]%x; if(r<=40)c[r]++;}
 for(int i=0;i<=40;i++)printf("%d %ld\n",i,c[i]); }
