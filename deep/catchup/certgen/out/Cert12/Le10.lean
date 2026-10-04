-- Catch-Up strategy certificate, N = 12, le side, root child with key 10
-- le root = Cert.all (CertList.cons k cert12le_k ...), keys k = 1..12, gap 0
-- definition: cert12le_10
-- position: l = [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12], g = 10
-- checker: chkGe
-- nodes: 187
-- (claim: chkGe [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12] 10 cert12le_10 = true)
def cert12le_10 : Cert :=
   (Cert.pick 1 (Cert.pick 2 (Cert.pick 3 (Cert.pick 4 (Cert.all (CertList.cons 5 (Cert.pick 8 (Cert.all
  (CertList.cons 6 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 9 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) CertList.nil)))))
  (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 6 (Cert.pick 12 (Cert.all (CertList.cons 11
  Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 6 Cert.leaf CertList.nil)))
  (CertList.cons 12 (Cert.pick 6 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.pick
  11 (Cert.all (CertList.cons 6 (Cert.pick 12 Cert.leaf) (CertList.cons 7 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 6 (Cert.pick 7 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick
  7 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9 Cert.leaf) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 9 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 6 (Cert.pick 5 (Cert.pick
  7 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 11
  Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  7 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick
  8 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9
  (Cert.pick 8 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 8
  (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil)))) CertList.nil)))))))
  (CertList.cons 8 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  9 (Cert.pick 7 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 7 (Cert.pick 12 Cert.leaf)) (CertList.cons
  12 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))) CertList.nil)))))))
  (CertList.cons 9 (Cert.pick 5 (Cert.pick 6 (Cert.all (CertList.cons 7 (Cert.pick 8 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil)))) (CertList.cons
  8 (Cert.pick 7 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 7 (Cert.pick 12 Cert.leaf)) (CertList.cons
  12 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil))))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick
  7 (Cert.all (CertList.cons 5 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons 8 (Cert.pick 5 (Cert.pick 12 Cert.leaf))
  (CertList.cons 9 (Cert.pick 5 (Cert.pick 12 Cert.leaf)) (CertList.cons 12 (Cert.pick 8 (Cert.pick 9
  Cert.leaf)) CertList.nil))))))) (CertList.cons 12 (Cert.pick 5 (Cert.pick 6 (Cert.pick 11 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 8 (Cert.pick 9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf)
  CertList.nil))) (CertList.cons 8 (Cert.all (CertList.cons 7 (Cert.pick 9 Cert.leaf) (CertList.cons
  9 (Cert.pick 7 Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.all (CertList.cons 7 (Cert.pick 8
  Cert.leaf) (CertList.cons 8 (Cert.pick 7 Cert.leaf) CertList.nil))) CertList.nil))))))) CertList.nil))))))))))))
