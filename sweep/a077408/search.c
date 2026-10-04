// Base-3 reverse-and-add trajectory of 103; checks every term for being a palindrome.
// usage: ./search N  -> runs steps 0..N-1, prints progress, and a checksum (value mod 1e9+7) at checkpoints.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
int main(int argc,char**argv){
  long N=atol(argv[1]);
  long cap=N+64; // digits grow < 1 per step
  uint8_t *d=calloc(cap,1),*e=calloc(cap,1);
  long L=0; unsigned x=103; while(x){d[L++]=x%3;x/=3;}
  const uint64_t P=1000000007ULL;
  for(long k=0;k<N;k++){
    // palindrome check
    long i=0,j=L-1; while(i<j && d[i]==d[j]){i++;j--;}
    if(i>=j){printf("PALINDROME at step %ld, length %ld\n",k,L);return 0;}
    if((k & (k-1))==0 || k%100000==0 || k==N-1){
      uint64_t h=0; for(long t=L-1;t>=0;t--) h=(h*3+d[t])%P;
      printf("step %ld len %ld mod %llu\n",k,L,(unsigned long long)h); fflush(stdout);
    }
    int c=0;
    for(long t=0;t<L;t++){int s=d[t]+d[L-1-t]+c; e[t]=s%3; c=s/3;}
    long nl=L; if(c) e[nl++]=c;
    uint8_t*tmp=d; d=e; e=tmp; L=nl;
  }
  printf("done %ld steps, no palindrome, final length %ld\n",N,L);
  return 0;
}
