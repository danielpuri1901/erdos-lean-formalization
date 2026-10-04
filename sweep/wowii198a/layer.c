// Exhaustive labeled check of Lemma L: self-centered, D>=3  =>  some root u has sum_j alpha(L_j(u)) >= D+3.
#define main main_unused
#include "check.c"
#undef main
static int alphaS(u32 S){ if(!S) return 0; int v=__builtin_ctz(S); u32 R=S&~(1u<<v);
  int a=alphaS(R); int b2=1+alphaS(R&~adj[v]); return a>b2?a:b2; }
int main(int argc,char**argv){ n=atoi(argv[1]); int E=n*(n-1)/2,pi[64],pj[64],k=0; long sc3=0,bad=0;
  for(int i=0;i<n;i++)for(int j=i+1;j<n;j++){pi[k]=i;pj[k]=j;k++;}
  for(uint64_t m=0;m<(1ull<<E);m++){ memset(adj,0,sizeof adj);
    for(int q=0;q<E;q++) if(m>>q&1){adj[pi[q]]|=1u<<pj[q];adj[pj[q]]|=1u<<pi[q];}
    if(!connected()) continue; int e[32],D=0,s=1; u32 L[32]; int nl;
    for(int v=0;v<n;v++){e[v]=ecc(v,L,&nl); if(e[v]>D)D=e[v];}
    for(int v=0;v<n;v++) if(e[v]!=D){s=0;break;}
    if(!s||D<3) continue; sc3++; int mx=0;
    for(int v=0;v<n;v++){ ecc(v,L,&nl); int t=0; for(int j=0;j<nl;j++) t+=alphaS(L[j]); if(t>mx) mx=t; }
    if(mx<D+3){ bad++; if(bad<5) printg("LEMMA_L_FAILS"); } }
  printf("n=%d selfcentered_D>=3=%ld lemmaL_failures=%ld\n",n,sc3,bad); return 0; }
