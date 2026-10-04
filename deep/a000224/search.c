// Exhaustive segmented search: all n in [2, N], a(n) via prime-power recursion,
// check (n prime odd) <-> n^2 % (a(a-1)) == 1 % (a(a-1)).
// a(p^k): odd p: a(1)=1, a(p)=(p+1)/2, a(p^k)=phi(p^k)/2 + a(p^{k-2}).
//         p=2:  a(1)=1, a(2)=2, a(4)=2, a(2^k)=2^{k-3}+a(2^{k-2}) for k>=3.
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
typedef unsigned __int128 u128;
typedef uint64_t u64;
static u64 apk(u64 p, int k) {
  if (k == 0) return 1;
  if (p == 2) {
    if (k == 1) return 2; if (k == 2) return 2;
    return (1ULL << (k-3)) + apk(2, k-2);
  }
  if (k == 1) return (p+1)/2;
  u64 pk1 = 1; for (int i = 0; i < k-1; i++) pk1 *= p;
  return pk1*(p-1)/2 + apk(p, k-2);
}
int main(int argc, char **argv) {
  u64 lo = strtoull(argv[1],0,10), hi = strtoull(argv[2],0,10); // [lo, hi)
  u64 S = 1<<22;
  u64 sq = 1; while ((sq+1)*(sq+1) < hi) sq++;
  // primes up to sq
  char *c = calloc(sq+2,1); u64 *pr = malloc(sizeof(u64)*(sq/2+10)); u64 np=0;
  for (u64 i=2;i<=sq;i++){ if(!c[i]){pr[np++]=i; for(u64 j=i*i;j<=sq;j+=i)c[j]=1;} }
  u64 *rem = malloc(8*S), *val = malloc(8*S); char *isp = malloc(S);
  u64 mism = 0, checked = 0;
  for (u64 L = lo; L < hi; L += S) {
    u64 R = L + S < hi ? L + S : hi; u64 len = R - L;
    for (u64 i=0;i<len;i++){ rem[i]=L+i; val[i]=1; isp[i]=1; }
    for (u64 t=0;t<np;t++){ u64 p=pr[t]; u64 st = (L + p - 1)/p*p; if (st == 0) st = p;
      for (u64 m = st; m < R; m += p) { u64 i=m-L; int k=0; while (rem[i]%p==0){rem[i]/=p;k++;}
        val[i]*=apk(p,k); if (m!=p) isp[i]=0; } }
    for (u64 i=0;i<len;i++){ u64 n=L+i; if(n<2)continue;
      if (rem[i]>1){ if (rem[i]!=n) isp[i]=0; val[i]*=(rem[i]+1)/2; }
      u64 A=val[i]; u128 M=(u128)A*(A-1); int rhs;
      if (M==0) rhs = 0; else rhs = (((u128)n*n) % M) == (1 % M);
      int lhs = isp[i] && n!=2;
      checked++; if (argc > 3) printf("%llu %llu\n",(unsigned long long)n,(unsigned long long)A);
      if (lhs != rhs) { mism++; printf("MISMATCH n=%llu a=%llu lhs=%d rhs=%d\n",(unsigned long long)n,(unsigned long long)A,lhs,rhs); fflush(stdout);} }
  }
  printf("range [%llu,%llu): checked %llu, mismatches %llu\n",(unsigned long long)lo,(unsigned long long)hi,(unsigned long long)checked,(unsigned long long)mism);
}
