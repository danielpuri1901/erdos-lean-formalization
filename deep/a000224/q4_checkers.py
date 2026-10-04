# Mirror of the planned Lean Bool checkers for Q4 (file Solution/A224/P4QCheck.lean), with exact Nat
# semantics (truncated subtraction, truncated division), over ALL odd p >= 3 (not only primes).
import sys
def sub(a,b): return a-b if a>=b else 0
def q4c(p,e): return p+2 if e%2==0 else 2*p+1
def q4A(p,e): return (p*p**e + q4c(p,e))//(2*(p+1))
def q4N(e,k,w): return k*w*sub(w,1)+1 if e%2==0 else k*w*sub(w,2)+4
def q4E(p,e,k,w):
    X=p**e; A=q4A(p,e)
    return sub(4*X*X, k*A*A)*w*w + sub(X*X,1) == sub(4*X*X, k*A)*w
# small: k <= 15, w <= 15, e in 4..23, odd p >= 3 with p | N_e
bad=[]; cnt=0
for k in range(16):
    for w in range(16):
        for p in range(k*w*sub(w,1)+5):
            if p<3 or p%2==0: continue
            if (k*w*sub(w,1)+1)%p!=0 and (k*w*sub(w,2)+4)%p!=0: continue
            for e in range(24):
                if e<4 or q4N(e,k,w)%p!=0: continue
                cnt+=1
                if q4E(p,e,k,w): bad.append((p,e,k,w))
print("small: evaluations", cnt, "solutions", bad)
# k16: p odd 3..25 (p < 27), e in 5..14, w in 2..(p+5)/2
bad=[]; cnt=0
for p in range(27):
    if p<3 or p%2==0: continue
    for e in range(5,15):
        for w in range(2,(p+5)//2+1):
            cnt+=1
            if q4E(p,e,16,w): bad.append((p,e,w))
print("k16: evaluations", cnt, "solutions", bad)
# large: p odd 3..31 (p < 33), e in 4..29, k in 17..28, w in 2..B/delta
bad=[]; cnt=0; maxw=0
for p in range(33):
    if p<3 or p%2==0: continue
    for e in range(4,30):
        X=p**e; A=q4A(p,e)
        for k in range(17,29):
            if 4*X*X <= k*A*A: continue
            d=4*X*X-k*A*A; B=sub(4*X*X,k*A)
            maxw=max(maxw,B//d)
            for w in range(2,B//d+1):
                cnt+=1
                if q4E(p,e,k,w): bad.append((p,e,k,w))
print("large: evaluations", cnt, "max B/delta", maxw, "solutions", bad)
