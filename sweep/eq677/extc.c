// Cocycle extension of a base 677 magma (stdin: n, table) by fiber F_p with constants al, be.
// argv: p al be seed outfile. Prints dim of cocycle space, whether any cocycle breaks 255,
// and writes a random extension table (order n*p) to outfile (if dim>0).
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
int n,p,al,be; int *T;
static long md(long x){ x%=p; return x<0?x+p:x; }
long pw(long b,long e){ long r=1; b=md(b); while(e){ if(e&1) r=r*b%p; b=b*b%p; e>>=1;} return r; }
int main(int argc,char**argv){
  p=atoi(argv[1]); al=atoi(argv[2]); be=atoi(argv[3]); srand(atoi(argv[4]));
  if(scanf("%d",&n)!=1) return 1; T=malloc(sizeof(int)*n*n);
  for(int i=0;i<n*n;i++) if(scanf("%d",&T[i])!=1) return 1;
  int N=n*n; int R=N; // rows
  uint16_t *M=calloc((size_t)R*N,sizeof(uint16_t));
  #define I(u,v) ((u)*n+(v))
  for(int x=0;x<n;x++) for(int y=0;y<n;y++){
    int s1=T[I(y,x)], s2=T[I(s1,y)], s3=T[I(x,s2)]; uint16_t *r=M+(size_t)(x*n+y)*N;
    r[I(y,x)]=md(r[I(y,x)]+(long)be*be%p*al); r[I(s1,y)]=md(r[I(s1,y)]+(long)be*be);
    r[I(x,s2)]=md(r[I(x,s2)]+be); r[I(y,s3)]=md(r[I(y,s3)]+1);
  }
  int *piv=malloc(sizeof(int)*N), *ispiv=calloc(N,sizeof(int)); int rk=0;
  for(int c=0;c<N && rk<R;c++){
    int pr=-1; for(int i=rk;i<R;i++) if(M[(size_t)i*N+c]){pr=i;break;}
    if(pr<0) continue;
    if(pr!=rk) for(int j=0;j<N;j++){ uint16_t t=M[(size_t)pr*N+j]; M[(size_t)pr*N+j]=M[(size_t)rk*N+j]; M[(size_t)rk*N+j]=t; }
    uint16_t *rr=M+(size_t)rk*N; long iv=pw(rr[c],p-2); for(int j=0;j<N;j++) rr[j]=rr[j]*iv%p;
    for(int i=0;i<R;i++){ if(i==rk) continue; uint16_t *ri=M+(size_t)i*N; long f=ri[c]; if(!f) continue;
      for(int j=0;j<N;j++) if(rr[j]) ri[j]=md(ri[j]-f*rr[j]); }
    piv[rk]=c; ispiv[c]=1; rk++;
  }
  int dim=N-rk; printf("n=%d p=%d al=%d be=%d rank=%d cocycle_dim=%d\n",n,p,al,be,rk,dim);
  // nullspace basis vectors one per free column; check 255 functional on each
  long *v=malloc(sizeof(long)*N); long *rnd=calloc(N,sizeof(long)); int bad=0;
  for(int fc=0;fc<N;fc++){ if(ispiv[fc]) continue;
    memset(v,0,sizeof(long)*N); v[fc]=1; for(int i=0;i<rk;i++) v[piv[i]]=md(-(long)M[(size_t)i*N+fc]);
    long cf=rand()%p; for(int j=0;j<N;j++) rnd[j]=md(rnd[j]+cf*v[j]);
    for(int x=0;x<n;x++){ int t1=T[I(x,x)], t2=T[I(t1,x)];
      long g=md((long)al*al%p*v[I(x,x)] + (long)al*v[I(t1,x)] + v[I(t2,x)]);
      if(g){ bad++; printf("COUNTEREXAMPLE free col %d x=%d\n",fc,x); break; } }
  }
  printf("basis vectors breaking 255: %d\n",bad);
  if(argc>5 && dim>0){ FILE*f=fopen(argv[5],"w"); int m=n*p; fprintf(f,"%d\n",m);
    for(int a=0;a<m;a++){ for(int b=0;b<m;b++){ int x=a/p,fa=a%p,y=b/p,fb=b%p;
      int z=T[I(x,y)]; long fz=md((long)al*fa+(long)be*fb+rnd[I(x,y)]); fprintf(f,"%d ",z*p+(int)fz);} fprintf(f,"\n"); }
    fclose(f); }
  return 0; }
