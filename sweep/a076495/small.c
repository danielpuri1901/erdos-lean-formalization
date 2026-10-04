// Reproduce a(n) for n=0..40: smallest x>=1 with sigma(x) mod x = n, by a plain divisor-sum sieve up to N.
#include <stdio.h>
#include <stdlib.h>
int main(int argc,char**argv){
  long N = argc>1? atol(argv[1]) : 2000000;
  unsigned long *s = calloc(N+1, sizeof *s);
  for(long d=1; d<=N; d++) for(long m=d; m<=N; m+=d) s[m]+=d;
  long first[41]; for(int i=0;i<41;i++) first[i]=0;
  long cnt5=0;
  for(long x=1;x<=N;x++){ unsigned long r = s[x]%x; if(r<=40 && !first[r]) first[r]=x; if(r==5){cnt5++; printf("HIT %ld\n",x);} }
  for(int i=0;i<41;i++) printf("a(%d)=%ld\n",i,first[i]);
  printf("N=%ld count(sigma mod x == 5)=%ld\n",N,cnt5);
}
