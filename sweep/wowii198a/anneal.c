// Simulated annealing: look for self-centered graphs of diameter TD with b <= TD+2.
#define main main_unused
#include "check.c"
#undef main
#include <math.h>
static int alphaS(u32 S){ // max independent subset of S (S small)
  if(!S) return 0; int v=__builtin_ctz(S); u32 R=S&~(1u<<v);
  int a=alphaS(R); // exclude v
  int b2=1+alphaS(R&~adj[v]); return a>b2?a:b2; }
static int TD;
static double score(int *bout){
  *bout=-1; if(!connected()) return 1000;
  int e[32],D=0; u32 L[32]; int nl; int maxls=0;
  for(int v=0;v<n;v++){e[v]=ecc(v,L,&nl); if(e[v]>D)D=e[v]; int s=0; for(int j=0;j<nl;j++) s+=alphaS(L[j]); if(s>maxls) maxls=s;}
  double sc=0; for(int v=0;v<n;v++) sc+=D-e[v];
  sc+=3*abs(D-TD);
  int ex=maxls-(TD+2); if(ex>0) sc+=ex;
  if(sc==0){ int big=hasK(0,TD+3); if(big) sc+=0.5; else *bout=bval(); }
  return sc; }
int main(int argc,char**argv){ n=atoi(argv[1]); TD=atoi(argv[2]); long iters=atol(argv[3]); rs=atoi(argv[4])|1;
  memset(adj,0,sizeof adj); for(int i=0;i<n;i++){int j=(i+1)%n; adj[i]|=1u<<j; adj[j]|=1u<<i;} // start: cycle
  int bb; double cur=score(&bb), best=cur; double T=1.0;
  for(long it=0;it<iters;it++){ int i=rnd()%n,j=rnd()%n; if(i==j) continue;
    adj[i]^=1u<<j; adj[j]^=1u<<i; double s=score(&bb);
    if(s<=cur || exp((cur-s)/T) > (rnd()%100000)/100000.0){ cur=s; if(s<best){best=s;} if(s==0){printg("FOUND"); printf("D=%d b=%d hamPath=%d\n",TD,bb,hampath()); return 0;} }
    else { adj[i]^=1u<<j; adj[j]^=1u<<i; }
    T*=0.99995; if(T<0.05) T=0.05; }
  printf("n=%d TD=%d best=%.2f\n",n,TD,best); return 0; }
