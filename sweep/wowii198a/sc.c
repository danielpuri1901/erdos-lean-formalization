// Random search: self-centered graphs with diameter D>=3; report min b-D. Uses check.c helpers.
#define main main_unused
#include "check.c"
#undef main
int main(int argc,char**argv){ n=atoi(argv[1]); int p=atoi(argv[2]); long c=atol(argv[3]); rs=atoi(argv[4])|1;
  long hist[40]={0}; long found=0;
  for(long it=0;it<c;it++){ memset(adj,0,sizeof adj);
    for(int i=0;i<n;i++)for(int j=i+1;j<n;j++) if((int)(rnd()%100)<p){adj[i]|=1u<<j;adj[j]|=1u<<i;}
    if(!connected()) continue; int e[32],D=0,sc=1; u32 L[32]; int nl;
    for(int v=0;v<n;v++){e[v]=ecc(v,L,&nl); if(e[v]>D)D=e[v];}
    for(int v=0;v<n;v++) if(e[v]!=D) sc=0;
    if(!sc||D<3) continue; found++;
    // b >= D+3 ?
    int ok = hasK(0,D+3); if(ok){hist[3]++; continue;}
    int bb=bval(); hist[bb-D]++; printg("SC_SMALL_B"); printf("D=%d b=%d\n",D,bb);
  }
  printf("n=%d p=%d samples=%ld selfcentered_D>=3=%ld ; count with b-D>=3: %ld ; others:",n,p,c,found,hist[3]);
  for(int k=0;k<3;k++) printf(" b-D=%d:%ld",k,hist[k]); printf("\n"); return 0; }
