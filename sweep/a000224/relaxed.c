// Relaxed semiprime system: 2<=u<v<=V, uv(uv-1) | ((2u-1)(2v-1))^2 - 1, no primality.
#include <stdio.h>
#include <stdlib.h>
typedef unsigned __int128 u128; typedef unsigned long long u64;
int main(int c, char**v_){ u64 V=strtoull(v_[1],0,10); u64 cnt=0;
 for(u64 u=2;u<=V;u++) for(u64 v=u+1;v<=V;v++){ u64 a=u*v; u128 n=(u128)(2*u-1)*(2*v-1);
   u128 M=(u128)a*(a-1); if(((n*n-1)%M)==0){cnt++; if(cnt<=60) printf("u=%llu v=%llu p=%llu q=%llu k=%llu\n",u,v,2*u-1,2*v-1,(u64)((n*n-1)/M));}}
 printf("relaxed solutions with u<v<=%llu: %llu\n",V,cnt);}
