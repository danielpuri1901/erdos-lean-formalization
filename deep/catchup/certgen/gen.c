/* Catch-Up minimal strategy certificates.  usage: gen N [outdir]  */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <sys/stat.h>

static int N, G;
static uint8_t *V;            /* 0=L 1=D 2=W */
static uint32_t *SGE, *SLE;
static uint16_t *SUM;
#define INF 0xFFFFFFFFu
#define CAP 0x80000000u
#define IDX(R,g) ((size_t)(R)*G+(size_t)(g))

static uint32_t add(uint32_t a, uint32_t b){
  if(a==INF||b==INF) return INF;
  uint64_t s=(uint64_t)a+b; return s>=CAP?CAP:(uint32_t)s; }

static void solve(void){
  uint32_t M=1u<<N;
  for(uint32_t R=0;R<M;R++){
    if(R){ int i=__builtin_ctz(R); SUM[R]=SUM[R&(R-1)]+i+1; } else SUM[R]=0;
    for(int g=0;g<=N;g++){
      size_t id=IDX(R,g);
      if(R==0){ V[id]= g>0?0:1; SGE[id]= g==0?1:INF; SLE[id]=1; continue; }
      if(SUM[R]<g){ V[id]=0; SGE[id]=INF; SLE[id]=1; continue; }
      int best=0; uint32_t bge=INF, lesum=1;
      for(uint32_t T=R;T;T&=T-1){
        int i=__builtin_ctz(T), x=i+1; uint32_t R2=R&~(1u<<i);
        int c,val; uint32_t gc,lc;
        if(x>=g){ size_t j=IDX(R2,x-g); c=V[j]; val=2-c; gc= c<=1?SLE[j]:INF; lc= c>=1?SGE[j]:INF; }
        else    { size_t j=IDX(R2,g-x); c=V[j]; val=c;   gc= c>=1?SGE[j]:INF; lc= c<=1?SLE[j]:INF; }
        if(val>best) best=val;
        if(gc<bge) bge=gc;
        lesum=add(lesum,lc);
      }
      V[id]=best; SGE[id]= best>=1?add(1,bge):INF; SLE[id]= best<=1?lesum:INF;
    }
  }
}

/* ---------- emission ---------- */
static FILE *out; static int col; static uint64_t nCert,nList; static int depth,maxdepth;
static void raw(const char*s){ fputs(s,out); col+=strlen(s); }
static void word(const char*s){ if(col>=100){ fputs("\n  ",out); col=2; } else { fputc(' ',out); col++; } raw(s); }
static void open_(const char*s){ char b[64]; snprintf(b,64,"(%s",s); word(b); depth++; if(depth>maxdepth)maxdepth=depth; }
static void close_(void){ raw(")"); depth--; }
static void num(int x){ char b[16]; snprintf(b,16,"%d",x); word(b); }
static void emit_le(uint32_t R,int g);
static void emit_ge(uint32_t R,int g){
  if(SGE[IDX(R,g)]==INF){ fprintf(stderr,"emit_ge on bad position\n"); exit(1); }
  if(R==0){ word("Cert.leaf"); nCert++; return; }
  int bx=-1; uint32_t bs=INF;
  for(uint32_t T=R;T;T&=T-1){ int i=__builtin_ctz(T),x=i+1; uint32_t R2=R&~(1u<<i); uint32_t s;
    if(x>=g){ size_t j=IDX(R2,x-g); s= V[j]<=1?SLE[j]:INF; } else { size_t j=IDX(R2,g-x); s= V[j]>=1?SGE[j]:INF; }
    if(s<bs){ bs=s; bx=x; } }
  uint32_t R2=R&~(1u<<(bx-1));
  open_("Cert.pick"); nCert++; num(bx);
  if(bx>=g) emit_le(R2,bx-g); else emit_ge(R2,g-bx);
  close_();
}
static void emit_child_of_all(uint32_t R,int g,int x){
  uint32_t R2=R&~(1u<<(x-1));
  if(x>=g) emit_ge(R2,x-g); else emit_le(R2,g-x);
}
static void emit_le(uint32_t R,int g){
  if(SLE[IDX(R,g)]==INF){ fprintf(stderr,"emit_le on bad position\n"); exit(1); }
  if(R==0||SUM[R]<g){ word("Cert.leaf"); nCert++; return; }
  open_("Cert.all"); nCert++; int k=0;
  for(uint32_t T=R;T;T&=T-1){ int x=__builtin_ctz(T)+1; open_("CertList.cons"); nList++; k++; num(x); emit_child_of_all(R,g,x); }
  word("CertList.nil"); nList++;
  for(int i=0;i<k;i++) close_();
  close_();
}
static void listR(char*b,uint32_t R){ char*p=b; p+=sprintf(p,"["); int first=1;
  for(uint32_t T=R;T;T&=T-1){ p+=sprintf(p,first?"%d":", %d",__builtin_ctz(T)+1); first=0; } sprintf(p,"]"); }

/* write one child definition; position (R,g), checker isge */
static void write_child(const char*dir,const char*side,int key,uint32_t R,int g,int isge,FILE*man,const char*rootdesc){
  char path[512],name[64],lst[256];
  snprintf(name,64,"cert%d%s_%d",N,side,key);
  snprintf(path,512,"%s/%s%d.lean",dir,side[0]=='g'?"Ge":"Le",key);
  listR(lst,R);
  uint32_t expect= isge?SGE[IDX(R,g)]:SLE[IDX(R,g)];
  out=fopen(path,"w"); if(!out){perror(path);exit(1);}
  fprintf(out,"-- Catch-Up strategy certificate, N = %d, %s side, root child with key %d\n",N,side,key);
  fprintf(out,"-- %s\n",rootdesc);
  fprintf(out,"-- definition: %s\n-- position: l = %s, g = %d\n-- checker: %s\n-- nodes: %u\n",name,lst,g,isge?"chkGe":"chkLe",expect);
  fprintf(out,"-- (claim: %s %s %d %s = true)\n",isge?"chkGe":"chkLe",lst,g,name);
  fprintf(out,"def %s : Cert :=\n  ",name); col=2;
  nCert=0;nList=0;depth=0;maxdepth=0;
  /* first token without leading space: emulate by temporarily setting col so word() prints a space; strip by writing manually */
  long pos0=ftell(out);
  if(isge) emit_ge(R,g); else emit_le(R,g);
  fputc('\n',out); fclose(out);
  (void)pos0;
  if(nCert!=expect){ fprintf(stderr,"node count mismatch %s: %llu vs %u\n",name,(unsigned long long)nCert,expect); exit(1); }
  fprintf(man,"%s | file %s%d.lean | checker %s | l = %s | g = %d | nodes %llu | certlist_nodes %llu | max_paren_depth %d\n",
          name,side[0]=='g'?"Ge":"Le",key,isge?"chkGe":"chkLe",lst,g,(unsigned long long)nCert,(unsigned long long)nList,maxdepth);
}

int main(int argc,char**argv){
  N=atoi(argv[1]); G=N+1; uint32_t M=1u<<N;
  V=malloc((size_t)M*G); SGE=malloc((size_t)M*G*4); SLE=malloc((size_t)M*G*4); SUM=malloc((size_t)M*2);
  if(!V||!SGE||!SLE||!SUM){fprintf(stderr,"oom\n");return 1;}
  solve();
  uint32_t F=M-1; size_t r=IDX(F,0);
  printf("N=%d value=%c sge=%u sle=%u\n",N,"LDW"[V[r]],SGE[r],SLE[r]);
  for(int n=0;n<=N;n++){ uint32_t Fn=(1u<<n)-1; size_t q=IDX(Fn,0); printf("  n=%d v=%c sge=%u sle=%u\n",n,"LDW"[V[q]],SGE[q],SLE[q]); }
  fflush(stdout);
  if(argc<3) return 0;
  char dir[400]; snprintf(dir,400,"%s/Cert%d",argv[2],N); mkdir(argv[2],0755); mkdir(dir,0755);
  char mp[512]; snprintf(mp,512,"%s/manifest.txt",dir); FILE*man=fopen(mp,"w");
  char rp[512]; snprintf(rp,512,"%s/root.txt",dir); FILE*rt=fopen(rp,"w");
  if(V[r]!=1){ fprintf(stderr,"root not a draw\n"); return 1; }
  /* ge root: pick x0 */
  int x0=-1; uint32_t bs=INF;
  for(int x=1;x<=N;x++){ uint32_t R2=F&~(1u<<(x-1)); size_t j=IDX(R2,x); uint32_t s=V[j]<=1?SLE[j]:INF; if(s<bs){bs=s;x0=x;} }
  uint32_t A=F&~(1u<<(x0-1));
  if(A==0||SUM[A]<x0){ fprintf(stderr,"ge root child is a leaf; unexpected\n"); return 1; }
  char lst[256],desc[512]; listR(lst,A);
  fprintf(man,"# N = %d; position ([1..%d], 0) is a draw\n# ge root: Cert.pick %d (Cert.all cs), total nodes %u; the all-node certifies chkLe %s %d; keys of cs = ",N,N,x0,SGE[r],lst,x0);
  for(uint32_t T=A;T;T&=T-1) fprintf(man,"%d ",__builtin_ctz(T)+1);
  fprintf(man,"\n# le root: Cert.all cs, total nodes %u; keys of cs = ",SLE[r]);
  for(int x=1;x<=N;x++) fprintf(man,"%d ",x);
  fprintf(man,"\n# format: name | file | checker | l | g | nodes (Cert constructors) | certlist_nodes (CertList constructors) | max_paren_depth\n");
  snprintf(desc,512,"ge root = Cert.pick %d (Cert.all (CertList.cons k cert%dge_k ...)), keys k in %s, gap %d",x0,N,lst,x0);
  for(uint32_t T=A;T;T&=T-1){ int x=__builtin_ctz(T)+1; uint32_t R2=A&~(1u<<(x-1));
    if(x>=x0) write_child(dir,"ge",x,R2,x-x0,1,man,desc); else write_child(dir,"ge",x,R2,x0-x,0,man,desc); }
  snprintf(desc,512,"le root = Cert.all (CertList.cons k cert%dle_k ...), keys k = 1..%d, gap 0",N,N);
  for(int x=1;x<=N;x++){ uint32_t R2=F&~(1u<<(x-1)); write_child(dir,"le",x,R2,x,1,man,desc); }
  fclose(man);
  /* root.txt */
  fprintf(rt,"Catch-Up, N = %d. Both roots certify the position l = [1, ..., %d], gap g = 0 (a draw).\n\n",N,N);
  fprintf(rt,"GE ROOT (chkGe [1..%d] 0 rootGe = true; %u Cert constructors in total):\n",N,SGE[r]);
  fprintf(rt,"  The mover picks x0 = %d; the opponent then faces l = %s, g = %d, certified by chkLe with an all-node over the keys",x0,lst,x0);
  for(uint32_t T=A;T;T&=T-1) fprintf(rt," %d",__builtin_ctz(T)+1);
  fprintf(rt,".\n  rootGe := Cert.pick %d (Cert.all\n",x0);
  int k=0; for(uint32_t T=A;T;T&=T-1){ int x=__builtin_ctz(T)+1; fprintf(rt,"    (CertList.cons %d cert%dge_%d\n",x,N,x); k++; }
  fprintf(rt,"    CertList.nil"); for(int i=0;i<k;i++) fputc(')',rt); fprintf(rt,")\n");
  fprintf(rt,"  i.e. keys in increasing order, each key k paired with the definition cert%dge_k from file Ge<k>.lean.\n\n",N);
  fprintf(rt,"LE ROOT (chkLe [1..%d] 0 rootLe = true; %u Cert constructors in total):\n",N,SLE[r]);
  fprintf(rt,"  rootLe := Cert.all\n"); for(int x=1;x<=N;x++) fprintf(rt,"    (CertList.cons %d cert%dle_%d\n",x,N,x);
  fprintf(rt,"    CertList.nil"); for(int x=1;x<=N;x++) fputc(')',rt); fprintf(rt,"\n");
  fprintf(rt,"  i.e. keys 1..%d in increasing order, each key k paired with cert%dle_k from file Le<k>.lean (checked by chkGe on l = [1..%d] minus k, g = k).\n",N,N,N);
  fclose(rt);
  printf("emitted to %s (x0=%d)\n",dir,x0);
  return 0;
}
