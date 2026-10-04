exec(open("numfield.py").read().split("sl=s_of(l)")[0])
def ev(coeffs,x):  # coeffs low->high integers
    r=[F(0)]*3
    for c in reversed(coeffs): r=add(mul(r,x),sc(F(c),one))
    return r
o=[1,1,1,0,1,0,2,0,1]   # b^8+2b^6+b^4+b^2+b+1
q=[-1,-1,0,1]
for nm,val in [("o(l)",ev(o,l)),("o(m)",ev(o,m)),("q(m)",ev(q,m)),("l^2+1",add(mul(l,l),one)),("m^2+1",add(mul(m,m),one)),("l-m",add(l,sc(-1,m)))]:
    print(nm,"norm =",norm(val))
