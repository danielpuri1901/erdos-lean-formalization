// Test candidate residue lemmas on all labeled graphs (not nec. connected), n<=N.
// L1: R(G) <= R(G-v)+1 for all v.  L1b: R(G-v) <= R(G) for all v?  L2: R(G) <= R(G-e) for all edges e.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
static int res(int *deg,int m){ int d[32]; memcpy(d,deg,m*sizeof(int));
  for(;;){ for(int i=1;i<m;i++){int x=d[i],j=i;while(j>0&&d[j-1]<x){d[j]=d[j-1];j--;}d[j]=x;}
    if(m==0) return 0; if(d[0]==0) return m; int k=d[0];
    for(int i=0;i<m-1;i++) d[i]=d[i+1]; m--; for(int i=0;i<k&&i<m;i++) if(d[i]>0) d[i]--; } }
int main(int argc,char**argv){ int N=atoi(argv[1]);
 for(int n=2;n<=N;n++){ int ne=n*(n-1)/2,pu[64],pv[64],e=0; for(int i=0;i<n;i++)for(int j=i+1;j<n;j++){pu[e]=i;pv[e]=j;e++;}
  long long f1=0,f1b=0,f2=0,f2b=0;
  for(long long m=0;m<(1LL<<ne);m++){ int A[8][8]={{0}}; int deg[8]={0};
    for(int b=0;b<ne;b++) if(m>>b&1){A[pu[b]][pv[b]]=A[pv[b]][pu[b]]=1;deg[pu[b]]++;deg[pv[b]]++;}
    int R=res(deg,n);
    for(int v=0;v<n;v++){ int d2[8],k=0; for(int u=0;u<n;u++) if(u!=v) d2[k++]=deg[u]-A[u][v];
      int Rv=res(d2,n-1); if(R>Rv+1) f1++; if(Rv>R) f1b++; }
    for(int b=0;b<ne;b++) if(m>>b&1){ deg[pu[b]]--;deg[pv[b]]--; int Re=res(deg,n); if(R>Re) f2++; if(Re>R+1) f2b++; deg[pu[b]]++;deg[pv[b]]++; }
  }
  printf("n=%d  L1 fails(R(G)>R(G-v)+1)=%lld  L1b fails(R(G-v)>R(G))=%lld  L2 fails(R(G)>R(G-e))=%lld  L2b fails(R(G-e)>R(G)+1)=%lld\n",n,f1,f1b,f2,f2b); fflush(stdout);}
}
