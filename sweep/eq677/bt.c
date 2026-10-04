// Backtracking search for magmas of order n satisfying 677: x = y*(x*((y*x)*y)).
// Rows are permutations (L_y bijective in finite 677 magmas). Propagation: if the
// chain is determined up to the last product y*t3, force it to x.
// Symmetry breaking: none (labeled count), except optional fixing nothing.
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAXN 12
int n; int T[MAXN][MAXN]; // -1 unknown
int used[MAXN][MAXN]; // used[y][v]=1 if v appears in row y
int trail[MAXN*MAXN*4], tl;
long long nodes, models, bad255;
int set(int y,int x,int v){ // returns 0 on conflict
  if(T[y][x]>=0) return T[y][x]==v;
  if(used[y][v]) return 0;
  T[y][x]=v; used[y][v]=1; trail[tl++]=y*MAXN+x; return 1;
}
void undo(int to){ while(tl>to){int c=trail[--tl]; int y=c/MAXN,x=c%MAXN; used[y][T[y][x]]=0; T[y][x]=-1;} }
int propagate(){
  int changed=1;
  while(changed){ changed=0;
    for(int y=0;y<n;y++) for(int x=0;x<n;x++){
      int t1=T[y][x]; if(t1<0) continue;
      int t2=T[t1][y]; if(t2<0) continue;
      int t3=T[x][t2]; if(t3<0) continue;
      int t4=T[y][t3];
      if(t4<0){ if(!set(y,t3,x)) return 0; changed=1; }
      else if(t4!=x) return 0;
    }
    // row completion
    for(int y=0;y<n;y++){ int cnt=0,ux=-1; for(int x=0;x<n;x++) if(T[y][x]<0){cnt++;ux=x;}
      if(cnt==1){ int v; for(v=0;v<n;v++) if(!used[y][v]) break; if(!set(y,ux,v)) return 0; changed=1; } }
  }
  return 1;
}
void rec(){
  nodes++;
  int tlsave=tl;
  if(!propagate()){ undo(tlsave); return; }
  int by=-1,bx=-1;
  for(int y=0;y<n&&by<0;y++) for(int x=0;x<n;x++) if(T[y][x]<0){by=y;bx=x;break;}
  if(by<0){ models++;
    for(int x=0;x<n;x++){ if(T[T[T[x][x]][x]][x]!=x){ bad255++;
      printf("COUNTEREXAMPLE n=%d\n",n); for(int a=0;a<n;a++){for(int b=0;b<n;b++)printf("%d ",T[a][b]);printf("\n");} break;} }
    undo(tlsave); return; }
  for(int v=0;v<n;v++){ if(used[by][v]) continue; int t2=tl; if(set(by,bx,v)) rec(); undo(t2); }
  undo(tlsave);
}
int main(int argc,char**argv){ n=atoi(argv[1]);
  memset(T,-1,sizeof T); memset(used,0,sizeof used); tl=0;
  rec();
  printf("n=%d nodes=%lld models(labeled)=%lld fail255=%lld\n",n,nodes,models,bad255);
}
