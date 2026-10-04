// Exhaustive / random check of WOWII 198a on labeled graphs.
// usage: ./check exh n   |   ./check rnd n p_percent count seed
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
typedef uint32_t u32;
static int n; static u32 adj[32];
static int popc(u32 x){return __builtin_popcount(x);}
static int connected(void){u32 seen=1,fr=1;while(fr){u32 nf=0;for(int v=0;v<n;v++)if(fr>>v&1)nf|=adj[v];nf&=~seen;seen|=nf;fr=nf;}return seen==((n==32)?0xffffffffu:((1u<<n)-1));}
static int ecc(int s,u32 *layer,int *nl){u32 seen=1u<<s,fr=1u<<s;int d=0;layer[0]=fr;while(1){u32 nf=0;for(int v=0;v<n;v++)if(fr>>v&1)nf|=adj[v];nf&=~seen;if(!nf)break;seen|=nf;fr=nf;d++;layer[d]=nf;}*nl=d+1;return d;}
static int bip(u32 S){ // is G[S] bipartite
  u32 c0=0,c1=0,rem=S;
  while(rem){int s=__builtin_ctz(rem);u32 fr=1u<<s;c0|=fr;rem&=~fr;int col=0;
    while(fr){u32 nf=0;for(int v=0;v<n;v++)if(fr>>v&1)nf|=adj[v]&S;
      u32 same=col?c1:c0; if(nf&same)return 0; nf&=rem; col^=1; if(col)c1|=nf; else c0|=nf; rem&=~nf; fr=nf;}
  }
  return 1;
}
static int hasK(u32 S,int k){ // exists bipartite subset of S with size k? (enumerate k-subsets of full set)
  // simple: gosper over n bits
  if(k>n) return 0;
  u32 x=(k==0)?0:((1u<<k)-1); u32 lim=1u<<n;
  if(k==0) return 1;
  while(x<lim){ if(bip(x)) return 1; u32 c=x&-x,r=x+c; x=(((r^x)>>2)/c)|r; }
  return 0;
}
static int bval(void){ for(int k=n;k>=1;k--) if(hasK(0,k)) return k; return 0;}
static int hampath(void){ // dp[mask] = bitset of endpoints
  int N=1<<n; static u32 dp[1<<22]; memset(dp,0,sizeof(u32)*N);
  for(int v=0;v<n;v++)dp[1u<<v]=1u<<v;
  for(int m=1;m<N;m++){u32 e=dp[m];if(!e)continue;u32 ext=0;for(int v=0;v<n;v++)if(e>>v&1)ext|=adj[v];ext&=~m;
    for(int w=0;w<n;w++)if(ext>>w&1)dp[m|(1u<<w)]|=1u<<w;}
  return dp[N-1]!=0;
}
static int isclique(u32 S){for(int v=0;v<n;v++)if(S>>v&1){if((adj[v]&S)!=(S&~(1u<<v)))return 0;}return 1;}
static long cnt_sat=0,cnt_sc=0,cnt_sc_noclqroot=0,cnt_fail=0,cnt_claimA_bad=0; static long Dhist[32],DhistSC[32];
static void printg(const char*tag){printf("%s n=%d edges:",tag,n);for(int i=0;i<n;i++)for(int j=i+1;j<n;j++)if(adj[i]>>j&1)printf(" %d-%d",i,j);printf("\n");fflush(stdout);}
static void analyze(int full){
  if(!connected())return;
  int e[32],S=0,D=0; u32 L[32]; int nl;
  for(int v=0;v<n;v++){e[v]=ecc(v,L,&nl);S+=e[v];if(e[v]>D)D=e[v];}
  int t=(2*n+S)/n; // hyp iff b<=t
  if(!full){ if(hampath()) return; }
  int hyp = !hasK(0,t+1);
  if(!hyp) return;
  cnt_sat++; Dhist[D]++;
  int sc=1; for(int v=0;v<n;v++) if(e[v]!=D) sc=0;
  int cliqroot=0;
  for(int v=0;v<n;v++){ ecc(v,L,&nl); int ok=1; for(int j=0;j<nl;j++) if(!isclique(L[j])) ok=0; if(ok) cliqroot=1;
     if(!sc && e[v]==D && !ok) { cnt_claimA_bad++; printg("CLAIM_A_VIOLATION"); } }
  if(sc){cnt_sc++;DhistSC[D]++; if(!cliqroot){cnt_sc_noclqroot++; if(cnt_sc_noclqroot<=5) printg("SC_NO_CLIQUE_ROOT");}}
  if(!hampath()){cnt_fail++; printg("COUNTEREXAMPLE");}
}
static u32 rs=12345; static u32 rnd(void){rs^=rs<<13;rs^=rs>>17;rs^=rs<<5;return rs;}
int main(int argc,char**argv){
  if(!strcmp(argv[1],"exh")){ n=atoi(argv[2]); int full=argc>3?atoi(argv[3]):1; int E=n*(n-1)/2; int pi[64],pj[64],k=0;
    for(int i=0;i<n;i++)for(int j=i+1;j<n;j++){pi[k]=i;pj[k]=j;k++;}
    for(uint64_t m=0;m<(1ull<<E);m++){ memset(adj,0,sizeof adj); for(int q=0;q<E;q++) if(m>>q&1){adj[pi[q]]|=1u<<pj[q];adj[pj[q]]|=1u<<pi[q];} analyze(full);} }
  else { n=atoi(argv[2]); int p=atoi(argv[3]); long c=atol(argv[4]); rs=atoi(argv[5])|1;
    for(long it=0;it<c;it++){ memset(adj,0,sizeof adj); for(int i=0;i<n;i++)for(int j=i+1;j<n;j++) if((int)(rnd()%100)<p){adj[i]|=1u<<j;adj[j]|=1u<<i;} analyze(0);} }
  printf("n=%d sat=%ld selfcentered=%ld sc_without_clique_root=%ld claimA_violations=%ld counterexamples=%ld\n",n,cnt_sat,cnt_sc,cnt_sc_noclqroot,cnt_claimA_bad,cnt_fail);
  printf("Dhist(sat):");for(int d=0;d<32;d++)if(Dhist[d])printf(" D%d:%ld",d,Dhist[d]);printf("\nDhist(sat,sc):");for(int d=0;d<32;d++)if(DhistSC[d])printf(" D%d:%ld",d,DhistSC[d]);printf("\n");
  return 0;
}
