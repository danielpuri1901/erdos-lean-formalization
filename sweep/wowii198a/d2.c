// Sanity check for Theorem B2: self-centered, D=2, b<=4  =>  no cut vertex and alpha<=3.
#define main main_unused
#include "check.c"
#undef main
static int alphaS(u32 S){ if(!S) return 0; int v=__builtin_ctz(S); u32 R=S&~(1u<<v);
  int a=alphaS(R); int b2=1+alphaS(R&~adj[v]); return a>b2?a:b2; }
static int conn_without(int w){ u32 all=((1u<<n)-1)&~(1u<<w); int s=__builtin_ctz(all); u32 seen=1u<<s,fr=seen;
  while(fr){u32 nf=0;for(int v=0;v<n;v++)if(fr>>v&1)nf|=adj[v];nf&=all&~seen;seen|=nf;fr=nf;} return seen==all; }
int main(int argc,char**argv){ n=atoi(argv[1]); int E=n*(n-1)/2,pi[64],pj[64],k=0; long cnt=0,bad=0;
  for(int i=0;i<n;i++)for(int j=i+1;j<n;j++){pi[k]=i;pj[k]=j;k++;}
  for(uint64_t m=0;m<(1ull<<E);m++){ memset(adj,0,sizeof adj);
    for(int q=0;q<E;q++) if(m>>q&1){adj[pi[q]]|=1u<<pj[q];adj[pj[q]]|=1u<<pi[q];}
    if(!connected()) continue; int e[32],D=0,s=1; u32 L[32]; int nl;
    for(int v=0;v<n;v++){e[v]=ecc(v,L,&nl); if(e[v]>D)D=e[v];}
    for(int v=0;v<n;v++) if(e[v]!=D){s=0;break;}
    if(!s||D!=2) continue; if(hasK(0,5)) continue; cnt++;
    int ok = alphaS((1u<<n)-1)<=3; for(int w=0;w<n;w++) if(!conn_without(w)) ok=0;
    if(!ok){bad++; printg("B2_FAIL");} }
  printf("n=%d selfcentered_D2_b<=4=%ld failures=%ld\n",n,cnt,bad); return 0; }
