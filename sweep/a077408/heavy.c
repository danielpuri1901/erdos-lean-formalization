// For each term of the trajectory, find the smallest i with d_i + d_{L-1-i} >= 3
// (a "heavy" mirrored pair). By the characterization in NOTES.md, the conjecture
// is equivalent to: every term has a heavy pair. Prints the histogram of i.
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
int main(int argc,char**argv){
  long N=atol(argv[1]);
  uint8_t *d=calloc(N+64,1),*e=calloc(N+64,1);
  long L=0; unsigned x=103; while(x){d[L++]=x%3;x/=3;}
  long hist[64]={0}; long worst=-1, worstk=-1;
  for(long k=0;k<N;k++){
    long i=0; while(2*i<=L-1 && d[i]+d[L-1-i]<3) i++;
    if(2*i>L-1){printf("NO HEAVY PAIR at step %ld (carry-free)\n",k);return 0;}
    if(i<63) hist[i]++; else hist[63]++;
    if(i>worst){worst=i;worstk=k;printf("step %ld len %ld first heavy pair at %ld\n",k,L,i);}
    int c=0;
    for(long t=0;t<L;t++){int s=d[t]+d[L-1-t]+c; e[t]=s%3; c=s/3;}
    long nl=L; if(c) e[nl++]=c;
    uint8_t*tmp=d; d=e; e=tmp; L=nl;
  }
  for(int i=0;i<64;i++) if(hist[i]) printf("first heavy at %d: %ld\n",i,hist[i]);
}
