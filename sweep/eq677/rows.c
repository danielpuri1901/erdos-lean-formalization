// Magmas whose rows L_x are drawn from a given permutation list G (stdin: n m, then m perms).
// Backtrack rows in order 0..n-1; after each assignment check every 677 instance whose chain is
// fully determined; check 255 at the end. argv[1]: max models to print.
#include <stdio.h>
#include <stdlib.h>
int n,m; int (*G)[64]; int row[64]; int asg[64]; long long nodes,models,bad;
int ok(int upto){ // check all (x,y) with chain determined
  for(int y=0;y<n;y++){ if(!asg[y]) continue;
    for(int x=0;x<n;x++){ int s1=G[row[y]][x]; if(!asg[s1]) continue; int s2=G[row[s1]][y];
      if(!asg[x]) continue; int s3=G[row[x]][s2]; if(G[row[y]][s3]!=x) return 0; } }
  return 1; }
void rec(int r){ nodes++;
  if(r==n){ models++; for(int x=0;x<n;x++){ int a=G[row[x]][x]; int b=G[row[a]][x]; int c=G[row[b]][x];
      if(c!=x){ bad++; if(bad<=3){ printf("COUNTEREXAMPLE rows:"); for(int i=0;i<n;i++) printf(" %d",row[i]); printf("\n"); } break; } }
    return; }
  for(int g=0;g<m;g++){ row[r]=g; asg[r]=1; if(ok(r)) rec(r+1); asg[r]=0; } }
int main(){ if(scanf("%d %d",&n,&m)!=2) return 1; G=malloc(sizeof(int[64])*m);
  for(int i=0;i<m;i++) for(int j=0;j<n;j++) if(scanf("%d",&G[i][j])!=1) return 1;
  rec(0); printf("n=%d |G|=%d nodes=%lld models=%lld fail255=%lld\n",n,m,nodes,models,bad); }
