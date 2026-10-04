-- Catch-Up strategy certificate, N = 11, le side, root child with key 7
-- le root = Cert.all (CertList.cons k cert11le_k ...), keys k = 1..11, gap 0
-- definition: cert11le_7
-- position: l = [1, 2, 3, 4, 5, 6, 8, 9, 10, 11], g = 7
-- checker: chkGe
-- nodes: 113
-- (claim: chkGe [1, 2, 3, 4, 5, 6, 8, 9, 10, 11] 7 cert11le_7 = true)
def cert11le_7 : Cert :=
   (Cert.pick 1 (Cert.pick 2 (Cert.pick 3 (Cert.pick 4 (Cert.all (CertList.cons 5 (Cert.pick 6 (Cert.all
  (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11
  (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 10
  (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons
  10 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10
  Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  6 (Cert.pick 5 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf)
  (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 8 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9
  (Cert.pick 8 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons
  5 (Cert.pick 6 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10
  Cert.leaf) CertList.nil)))) (CertList.cons 6 (Cert.pick 5 (Cert.all (CertList.cons 10 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick
  5 (Cert.pick 11 Cert.leaf)) (CertList.cons 11 (Cert.pick 5 (Cert.pick 10 Cert.leaf)) CertList.nil))))))
  (CertList.cons 9 (Cert.pick 5 (Cert.pick 8 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 6 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 10 (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons 5 (Cert.all
  (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 5
  Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick 10 (Cert.all
  (CertList.cons 5 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf)
  CertList.nil))) (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil))))))
  CertList.nil)))))))))))
