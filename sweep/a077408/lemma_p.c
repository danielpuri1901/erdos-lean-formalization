// Exhaustive check of Lemma P for all L-digit x, L <= maxL:
// x + rev(x) palindrome  <=>  (N) all d_i + d_{L-1-i} <= 2  or  (O) x palindrome with digits in {0,2}.
#include <stdio.h>
#include <stdlib.h>
int main(int argc,char**argv){
  int maxL=atoi(argv[1]);
  for(int L=1;L<=maxL;L++){
    int d[64],e[64]; long bad=0,cnt=0;
    for(int i=0;i<L;i++) d[i]=0; d[L-1]=1;
    for(;;){
      int c=0;
      for(int t=0;t<L;t++){int s=d[t]+d[L-1-t]+c; e[t]=s%3; c=s/3;}
      int n=L; if(c) e[n++]=c;
      int pal=1; for(int i=0,j=n-1;i<j;i++,j--) if(e[i]!=e[j]){pal=0;break;}
      int N=1; for(int i=0;i<L;i++) if(d[i]+d[L-1-i]>2){N=0;break;}
      int O=1; for(int i=0;i<L;i++) if(d[i]!=d[L-1-i] || d[i]==1){O=0;break;}
      if(pal!=(N||O)) bad++;
      cnt+=pal;
      int t=0; while(t<L-1 && d[t]==2){d[t]=0;t++;}
      if(t==L-1 && d[t]==2) break;
      d[t]++;
    }
    printf("L=%2d palindromic sums %ld mismatches %ld\n",L,cnt,bad);
  }
}
