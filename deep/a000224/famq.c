// Family search: n = m*q, m odd in [3, MMAX], q prime not dividing m, q of ANY size.
// With A = a(m), w = (q+1)/2, k = (n^2-1)/(a(a-1)) the congruence is (lemma Q1(iv))
//   (4m^2 - kA^2) w^2 - (4m^2 - kA) w + (m^2 - 1) = 0,  and Q1(i) forces 4m^2 - kA^2 > 0.
// For each m and each k with 4m^2 - kA^2 > 0 we solve the quadratic exactly in 128-bit integers.
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>
typedef unsigned __int128 u128; typedef uint64_t u64; typedef __int128 i128;
static u64 apk(u64 p, int k){ if(k==0) return 1; if(k==1) return (p+1)/2;
  u64 pk1=1; for(int i=0;i<k-1;i++) pk1*=p; return pk1*(p-1)/2 + apk(p,k-2); }
static u64 mulmod(u64 a,u64 b,u64 m){ return (u128)a*b % m; }
static u64 powmod(u64 a,u64 e,u64 m){ u64 r=1; a%=m; while(e){ if(e&1) r=mulmod(r,a,m); a=mulmod(a,a,m); e>>=1;} return r; }
static int isprime(u64 n){ if(n<2) return 0; static const u64 sp[]={2,3,5,7,11,13,17,19,23,29,31,37};
  for(int i=0;i<12;i++){ if(n%sp[i]==0) return n==sp[i]; }
  u64 d=n-1; int s=0; while(!(d&1)){d>>=1;s++;}
  for(int i=0;i<12;i++){ u64 x=powmod(sp[i],d,n); if(x==1||x==n-1) continue; int ok=0;
    for(int r=1;r<s;r++){ x=mulmod(x,x,n); if(x==n-1){ok=1;break;} } if(!ok) return 0; } return 1; }
static u128 isqrt128(u128 n){ if(n==0) return 0; long double f=(long double)n; u128 r=(u128)sqrtl(f);
  while(r*r>n) r--; while((r+1)*(r+1)<=n) r++; return r; }
int main(int argc,char**argv){ u64 MMAX=strtoull(argv[1],0,10); u64 MLO = argc>2? strtoull(argv[2],0,10):3;
  uint32_t *spf=malloc(4*(MMAX+1)); for(u64 i=0;i<=MMAX;i++) spf[i]=0;
  for(u64 i=2;i<=MMAX;i++) if(!spf[i]){ for(u64 j=i;j<=MMAX;j+=i) if(!spf[j]) spf[j]=i; }
  u64 pairs=0, roots=0, hits=0, ms=0;
  for(u64 m=MLO|1; m<=MMAX; m+=2){ ms++;
    u64 A=1, t=m; while(t>1){ u64 p=spf[t]; int k=0; while(t%p==0){t/=p;k++;} A*=apk(p,k); }
    u128 m2=(u128)m*m; u128 A2=(u128)A*A;
    for(u64 k=1; k*A2 < 4*m2; k++){ pairs++;
      i128 del=(i128)(4*m2 - k*A2); i128 b=(i128)(4*m2) - (i128)k*A; i128 c=(i128)(m2-1);
      i128 disc=b*b - 4*del*c; if(disc<0) continue; u128 s=isqrt128((u128)disc); if((i128)(s*s)!=disc) continue;
      for(int sg=-1; sg<=1; sg+=2){ i128 num=b+sg*(i128)s; if(num<=0) continue; if(num % (2*del)) continue;
        i128 w=num/(2*del); roots++; if(w<2) continue; u64 q=(u64)(2*w-1);
        if(m%q==0) continue; if(!isprime(q)) continue;
        // direct verification
        u128 n=(u128)m*q; u128 a=(u128)A*(u128)w; u128 M=a*(a-1); int ok = ((n*n-1)%M==0);
        hits++; printf("HIT m=%llu q=%llu k=%llu direct=%d\n",(unsigned long long)m,(unsigned long long)q,(unsigned long long)k,ok); fflush(stdout); } } }
  printf("m odd in [%llu,%llu]: %llu values, (m,k) pairs %llu, integer roots %llu, prime-q hits %llu\n",
    (unsigned long long)(MLO|1),(unsigned long long)MMAX,(unsigned long long)ms,(unsigned long long)pairs,(unsigned long long)roots,(unsigned long long)hits);
  return 0; }
