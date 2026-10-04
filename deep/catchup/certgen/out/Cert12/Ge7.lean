-- Catch-Up strategy certificate, N = 12, ge side, root child with key 7
-- ge root = Cert.pick 1 (Cert.all (CertList.cons k cert12ge_k ...)), keys k in [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], gap 1
-- definition: cert12ge_7
-- position: l = [2, 3, 4, 5, 6, 8, 9, 10, 11, 12], g = 6
-- checker: chkGe
-- nodes: 259
-- (claim: chkGe [2, 3, 4, 5, 6, 8, 9, 10, 11, 12] 6 cert12ge_7 = true)
def cert12ge_7 : Cert :=
   (Cert.pick 2 (Cert.pick 3 (Cert.pick 4 (Cert.all (CertList.cons 5 (Cert.pick 8 (Cert.all (CertList.cons
  6 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  9 (Cert.pick 12 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 10 Cert.leaf) CertList.nil))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons
  6 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick
  12 (Cert.all (CertList.cons 6 Cert.leaf CertList.nil))) (CertList.cons 12 (Cert.pick 6 (Cert.pick 11
  Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 6 (Cert.pick
  12 Cert.leaf) (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 6 (Cert.pick 9
  Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 6 (Cert.pick
  11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons
  6 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick 6 (Cert.pick 9 Cert.leaf)) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 6 (Cert.pick 8 (Cert.all (CertList.cons 5 (Cert.pick 10 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 9 (Cert.pick
  12 (Cert.all (CertList.cons 5 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11
  (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 10 Cert.leaf) CertList.nil))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons
  5 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick
  5 (Cert.pick 12 Cert.leaf)) (CertList.cons 12 (Cert.pick 5 (Cert.pick 11 Cert.leaf)) CertList.nil)))))
  (CertList.cons 11 (Cert.pick 5 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 10 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 5 (Cert.pick 9 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 5 (Cert.pick 10 (Cert.all
  (CertList.cons 6 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  11 Cert.leaf) CertList.nil))))) (CertList.cons 6 (Cert.pick 10 (Cert.all (CertList.cons 5 (Cert.all
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))
  (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))))
  (CertList.cons 10 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))))) (CertList.cons 11 (Cert.pick 5 (Cert.pick 6 (Cert.all
  (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 10 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 9 (Cert.pick 5 (Cert.pick
  6 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 8 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10
  Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  10 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick
  8 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9
  (Cert.pick 8 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 8
  (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil)))) CertList.nil)))))))
  (CertList.cons 11 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons
  9 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10
  Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 9
  Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 8
  (Cert.pick 10 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))) CertList.nil))))))) (CertList.cons
  12 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick
  8 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9
  (Cert.pick 8 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil)))) CertList.nil))))))) CertList.nil)))))))))))
