// For each length L, count L-digit base-3 numbers x (leading digit nonzero)
// such that x + rev(x) is a base-3 palindrome, split by whether the sum carries out.
#include <stdio.h>
#include <stdlib.h>
int main(int argc,char**argv){
  int maxL=atoi(argv[1]);
  for(int L=1;L<=maxL;L++){
    long total=1; for(int i=1;i<L;i++) total*=3; total*=2;
    int d[64],e[64]; long cnt=0,cntNo=0,cntCarry=0;
    for(int i=0;i<L;i++) d[i]=0; d[L-1]=1;
    for(long it=0;it<total;it++){
      int c=0;
      for(int t=0;t<L;t++){int s=d[t]+d[L-1-t]+c; e[t]=s%3; c=s/3;}
      int n=L; if(c) e[n++]=c;
      int ok=1; for(int i=0,j=n-1;i<j;i++,j--) if(e[i]!=e[j]){ok=0;break;}
      if(ok){cnt++; if(c) cntCarry++; else cntNo++;}
      // increment d (little endian), keep leading digit in {1,2}
      int t=0; while(t<L){ d[t]++; if(t==L-1){ if(d[t]<=2) break; else break;} if(d[t]<3) break; d[t]=0; t++; }
    }
    printf("L=%2d total=%10ld pal=%9ld (nocarry %ld, carry %ld) frac=%.3e\n",L,total,cnt,cntNo,cntCarry,(double)cnt/total);
  }
}
