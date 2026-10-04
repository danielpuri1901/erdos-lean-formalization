// Structure statistics along the base-3 trajectory of 103:
// runs/len (a self-similar Lychrel pattern would have O(1) runs) and the longest
// matching outer prefix/suffix (how close a term comes to a palindrome).
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
int main(int argc,char**argv){
  long N=atol(argv[1]);
  uint8_t *d=calloc(N+64,1),*e=calloc(N+64,1);
  long L=0; unsigned x=103; while(x){d[L++]=x%3;x/=3;}
  double minratio=1e9; long bestmatch=0;
  for(long k=0;k<N;k++){
    long i=0,j=L-1; while(i<j && d[i]==d[j]){i++;j--;}
    if(i>=j){printf("PALINDROME at %ld\n",k);return 0;}
    if(i>bestmatch){bestmatch=i;printf("step %ld len %ld outer match %ld\n",k,L,i);}
    long runs=1; for(long t=1;t<L;t++) runs+=(d[t]!=d[t-1]);
    double r=(double)runs/L;
    if(k>=100 && r<minratio){minratio=r;printf("step %ld len %ld runs %ld ratio %.4f\n",k,L,runs,r);}
    int c=0;
    for(long t=0;t<L;t++){int s=d[t]+d[L-1-t]+c; e[t]=s%3; c=s/3;}
    long nl=L; if(c) e[nl++]=c;
    uint8_t*tmp=d; d=e; e=tmp; L=nl;
  }
  printf("done %ld\n",N);
}
