// Search A: x = m^2 and x = 2 m^2 for m in [lo, hi): test sigma(x) mod x == 5.
// Segmented factorization of m by primes <= sqrt(hi). Arithmetic in unsigned __int128.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
typedef unsigned __int128 u128; typedef unsigned long long u64;
int main(int argc,char**argv){
  u64 lo=strtoull(argv[1],0,10), hi=strtoull(argv[2],0,10); unsigned T=argc>3?atoi(argv[3]):5;
  if(lo<1) lo=1;
  u64 r=(u64)sqrtl((long double)hi)+2;
  char*comp=calloc(r+1,1); u64*pr=malloc(sizeof(u64)*(r+1)); long np=0;
  for(u64 i=2;i<=r;i++){ if(!comp[i]){pr[np++]=i; for(u64 j=i*i;j<=r;j+=i) comp[j]=1;} }
  const u64 SEG=1<<20;
  u64 *rem=malloc(SEG*8); u128 *s1=malloc(SEG*16), *s2=malloc(SEG*16); // s1 = sigma(m^2) , s2 = sigma(odd part pattern) handled below
  // For x=m^2: sigma(m^2)=prod (p^(2e+1)-1)/(p-1).
  // For x=2m^2: write m=2^a*u, x=2^(2a+1)*u^2, sigma = (2^(2a+2)-1)*sigma(u^2).
  // Keep s1 = sigma(u^2) over odd primes, and a = v2(m).
  int *v2=malloc(SEG*sizeof(int));
  u64 hits=0, tested=0;
  for(u64 b=lo;b<hi;b+=SEG){
    u64 e=b+SEG<hi?b+SEG:hi, n=e-b;
    for(u64 i=0;i<n;i++){ rem[i]=b+i; s1[i]=1; v2[i]=0; }
    for(long k=0;k<np;k++){ u64 p=pr[k]; if(p*p>=e) break;
      u64 st=((b+p-1)/p)*p;
      for(u64 m=st;m<e;m+=p){ u64 i=m-b; int a=0; while(rem[i]%p==0){rem[i]/=p;a++;}
        if(p==2) v2[i]=a; else { u128 pw=1; for(int t=0;t<2*a+1;t++) pw*=p; s1[i]*= (pw-1)/(p-1); } }
    }
    for(u64 i=0;i<n;i++){ u64 m=b+i; u64 q=rem[i];
      if(q>1){ if(q==2) v2[i]=1; else s1[i]*=(u128)q*q+q+1; }
      int a=v2[i]; u128 two=((u128)1<<(2*a+1))-1; // sigma(2^(2a))
      u128 x=(u128)m*m; u128 sig=s1[i]*two;
      tested++; if(sig%x==T){ hits++; printf("HIT m^2 m=%llu\n",m); }
      u128 x2=2*x; u128 sig2=s1[i]*(((u128)1<<(2*a+2))-1);
      if(sig2%x2==T){ hits++; printf("HIT 2m^2 m=%llu\n",m); }
      if(0){ /* sanity print */ fprintf(stderr,"m=%llu sigma(m^2)=%llu sigma(2m^2)=%llu\n",m,(u64)sig,(u64)sig2); }
    }
  }
  printf("range m in [%llu,%llu): tested %llu m, hits %llu\n",lo,hi,tested,hits);
}
