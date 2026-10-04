-- Catch-Up strategy certificate, N = 12, ge side, root child with key 12
-- ge root = Cert.pick 1 (Cert.all (CertList.cons k cert12ge_k ...)), keys k in [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], gap 1
-- definition: cert12ge_12
-- position: l = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11], g = 11
-- checker: chkGe
-- nodes: 123
-- (claim: chkGe [2, 3, 4, 5, 6, 7, 8, 9, 10, 11] 11 cert12ge_12 = true)
def cert12ge_12 : Cert :=
   (Cert.pick 2 (Cert.pick 3 (Cert.pick 4 (Cert.pick 5 (Cert.all (CertList.cons 6 (Cert.pick 7 (Cert.all
  (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11
  (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 10
  (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10
  Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  7 (Cert.pick 6 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 8 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9
  (Cert.pick 8 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 8 (Cert.pick 6 (Cert.all (CertList.cons
  7 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10
  Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 10
  Cert.leaf CertList.nil)))) (CertList.cons 10 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 9
  Cert.leaf CertList.nil)))) (CertList.cons 11 (Cert.pick 9 (Cert.pick 10 Cert.leaf)) CertList.nil))))))
  (CertList.cons 9 (Cert.pick 7 (Cert.all (CertList.cons 6 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 8 (Cert.pick
  6 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))) (CertList.cons 10 (Cert.pick
  8 (Cert.pick 11 Cert.leaf)) (CertList.cons 11 (Cert.pick 8 (Cert.pick 10 Cert.leaf)) CertList.nil))))))
  (CertList.cons 10 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 8
  (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil))) (CertList.cons 8 (Cert.all
  (CertList.cons 7 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 7 Cert.leaf) CertList.nil))) (CertList.cons
  9 (Cert.all (CertList.cons 7 (Cert.pick 8 Cert.leaf) (CertList.cons 8 (Cert.pick 7 Cert.leaf) CertList.nil)))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil))) (CertList.cons
  8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil)))))))))))
