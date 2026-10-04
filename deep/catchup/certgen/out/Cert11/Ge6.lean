-- Catch-Up strategy certificate, N = 11, ge side, root child with key 6
-- ge root = Cert.pick 1 (Cert.all (CertList.cons k cert11ge_k ...)), keys k in [2, 3, 4, 5, 6, 7, 8, 9, 10, 11], gap 1
-- definition: cert11ge_6
-- position: l = [2, 3, 4, 5, 7, 8, 9, 10, 11], g = 5
-- checker: chkGe
-- nodes: 172
-- (claim: chkGe [2, 3, 4, 5, 7, 8, 9, 10, 11] 5 cert11ge_6 = true)
def cert11ge_6 : Cert :=
   (Cert.pick 2 (Cert.pick 3 (Cert.all (CertList.cons 4 (Cert.pick 7 (Cert.all (CertList.cons 5 (Cert.pick
  11 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10
  (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10
  (Cert.pick 9 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  8 (Cert.pick 10 (Cert.all (CertList.cons 5 (Cert.pick 11 Cert.leaf) (CertList.cons 9 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 5 (Cert.pick 9 Cert.leaf)) CertList.nil))))) (CertList.cons
  9 (Cert.pick 5 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11
  (Cert.pick 10 Cert.leaf) CertList.nil))))) (CertList.cons 10 (Cert.pick 5 (Cert.pick 8 (Cert.all (CertList.cons
  9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil))))) (CertList.cons
  11 (Cert.pick 5 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10
  (Cert.pick 9 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 5 (Cert.pick 4 (Cert.pick
  7 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10
  Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  7 (Cert.pick 4 (Cert.pick 5 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick
  8 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9
  (Cert.pick 8 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil)))) CertList.nil))))))) (CertList.cons 8 (Cert.pick 4 (Cert.pick 5 (Cert.all
  (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11
  (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil)))) (CertList.cons 10 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 10 Cert.leaf)) CertList.nil)))))))
  (CertList.cons 9 (Cert.pick 4 (Cert.pick 5 (Cert.all (CertList.cons 7 (Cert.pick 8 (Cert.all (CertList.cons
  10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons
  8 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))) (CertList.cons
  10 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) (CertList.cons 11 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons
  7 Cert.leaf CertList.nil)))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 4 (Cert.pick 5 (Cert.pick
  11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick
  8 Cert.leaf) CertList.nil))) (CertList.cons 8 (Cert.all (CertList.cons 7 (Cert.pick 9 Cert.leaf) (CertList.cons
  9 (Cert.pick 7 Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.all (CertList.cons 7 (Cert.pick 8
  Cert.leaf) (CertList.cons 8 (Cert.pick 7 Cert.leaf) CertList.nil))) CertList.nil))))))) (CertList.cons
  11 (Cert.pick 4 (Cert.pick 5 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 8 (Cert.pick
  9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil))) (CertList.cons 8 (Cert.pick 9
  Cert.leaf) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) CertList.nil)))))))
  CertList.nil))))))))))
