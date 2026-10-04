// Translation-invariant models over a group H (table from stdin): x*y = x f(x^-1 y), f a permutation.
// 677 <=> for all x: f(z) = x where u=f(x), w=u f(u^-1), z = x f(x^-1 w).
// 255 <=> a=f(e), b=a f(a^-1), c=b f(b^-1), c==e.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAXN 64
int n, M[MAXN][MAXN], inv[MAXN], e;
int f[MAXN], used[MAXN], trail[MAXN*4], tl;
long long nodes, models, bad;
int setf(int x,int v){ if(f[x]>=0) return f[x]==v; if(used[v]) return 0; f[x]=v; used[v]=1; trail[tl++]=x; return 1; }
void undo(int to){ while(tl>to){int x=trail[--tl]; used[f[x]]=0; f[x]=-1;} }
int prop(){ int ch=1; while(ch){ ch=0;
  for(int x=0;x<n;x++){ int u=f[x]; if(u<0) continue; int fu=f[inv[u]]; if(fu<0) continue; int w=M[u][fu];
    int g=f[M[inv[x]][w]]; if(g<0) continue; int z=M[x][g]; int fz=f[z];
    if(fz<0){ if(!setf(z,x)) return 0; ch=1; } else if(fz!=x) return 0; } }
  return 1; }
void rec(){ nodes++; int s=tl; if(!prop()){undo(s);return;}
  int bx=-1; for(int x=0;x<n;x++) if(f[x]<0){bx=x;break;}
  if(bx<0){ models++; int a=f[e], b=M[a][f[inv[a]]], c=M[b][f[inv[b]]];
    if(c!=e){ bad++; if(bad<=3){ printf("COUNTEREXAMPLE f:"); for(int x=0;x<n;x++) printf(" %d",f[x]); printf("\n");} }
    undo(s); return; }
  for(int v=0;v<n;v++){ if(used[v]) continue; int t=tl; if(setf(bx,v)) rec(); undo(t); }
  undo(s); }
int main(){ if(scanf("%d",&n)!=1) return 1; for(int i=0;i<n;i++) for(int j=0;j<n;j++) scanf("%d",&M[i][j]);
  for(int i=0;i<n;i++){ int ok=1; for(int j=0;j<n;j++) if(M[i][j]!=j) ok=0; if(ok) e=i; }
  for(int i=0;i<n;i++) for(int j=0;j<n;j++) if(M[i][j]==e) inv[i]=j;
  memset(f,-1,sizeof f); rec();
  printf("n=%d nodes=%lld models=%lld fail255=%lld\n",n,nodes,models,bad); }
