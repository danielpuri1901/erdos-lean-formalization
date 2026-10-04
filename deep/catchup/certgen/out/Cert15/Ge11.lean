-- Catch-Up strategy certificate, N = 15, ge side, root child with key 11
-- ge root = Cert.pick 1 (Cert.all (CertList.cons k cert15ge_k ...)), keys k in [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], gap 1
-- definition: cert15ge_11
-- position: l = [2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15], g = 10
-- checker: chkGe
-- nodes: 1884
-- (claim: chkGe [2, 3, 4, 5, 6, 7, 8, 9, 10, 12, 13, 14, 15] 10 cert15ge_11 = true)
def cert15ge_11 : Cert :=
   (Cert.pick 2 (Cert.pick 3 (Cert.pick 4 (Cert.pick 5 (Cert.all (CertList.cons 6 (Cert.pick 9 (Cert.all
  (CertList.cons 7 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick
  12 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 8 (Cert.all
  (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf)
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf))
  CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13
  Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 12 (Cert.pick 8 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 10
  (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 10 (Cert.pick 14 (Cert.all (CertList.cons
  7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  12 Cert.leaf) CertList.nil))))) (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 8 (Cert.all
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 10 (Cert.all
  (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 8 (Cert.pick
  12 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick
  8 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 8 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil))))))))) (CertList.cons
  7 (Cert.pick 8 (Cert.all (CertList.cons 6 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))) (CertList.cons 10 (Cert.all
  (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 13 (Cert.all (CertList.cons 12
  Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 12 (Cert.all (CertList.cons 9 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.pick
  14 Cert.leaf)) (CertList.cons 14 (Cert.pick 10 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons
  13 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick 14 (Cert.all (CertList.cons
  9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil))))) CertList.nil))))))) (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 6 (Cert.pick 13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 9 (Cert.all
  (CertList.cons 6 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  6 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick
  9 (Cert.all (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  13 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick
  6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  CertList.nil))))))) CertList.nil))))))))) (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons 6
  (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 14 (Cert.all (CertList.cons 13
  Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 14 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  (CertList.cons 14 (Cert.pick 7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) CertList.nil))))))) (CertList.cons
  7 (Cert.pick 9 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil))))) (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons
  6 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 14 (Cert.pick 12 (Cert.all (CertList.cons 6 (Cert.pick 15 Cert.leaf) (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 6 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 9 (Cert.pick 7 (Cert.all
  (CertList.cons 6 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  6 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 7 (Cert.all
  (CertList.cons 6 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick 14
  Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 9 (Cert.pick 6 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  6 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 6 (Cert.pick
  7 (Cert.all (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.pick 12
  Cert.leaf) (CertList.cons 12 (Cert.pick 9 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  14 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  9 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 9 (Cert.pick 13 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick
  7 (Cert.all (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 14 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9
  Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 13 (Cert.all (CertList.cons 12
  Cert.leaf CertList.nil)))) CertList.nil))))))) CertList.nil))))))))) (CertList.cons 9 (Cert.pick 8
  (Cert.all (CertList.cons 6 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil))) (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 12 (Cert.pick 15 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick
  13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick
  15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))) (CertList.cons 14 (Cert.pick 7 (Cert.pick
  15 Cert.leaf)) (CertList.cons 15 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) CertList.nil))))) (CertList.cons
  14 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 12 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 Cert.leaf)) CertList.nil))))) (CertList.cons
  15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 7 (Cert.pick 10 (Cert.all
  (CertList.cons 6 (Cert.pick 13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))) (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 6 (Cert.pick
  7 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  12 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) CertList.nil))))))) (CertList.cons
  13 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))))
  (CertList.cons 14 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil))))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick
  7 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 Cert.leaf))
  CertList.nil))))))) CertList.nil))))))))) (CertList.cons 10 (Cert.pick 8 (Cert.all (CertList.cons 6
  (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 14 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf)
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 13 Cert.leaf))
  CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick
  7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13
  Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 6 (Cert.pick 15 (Cert.all (CertList.cons 12
  (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick 13 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 9 (Cert.pick 6 (Cert.pick
  7 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  12 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil)))
  CertList.nil)))) (CertList.cons 7 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 6 (Cert.pick 13 Cert.leaf)) CertList.nil)))) (CertList.cons
  13 (Cert.all (CertList.cons 6 (Cert.pick 14 Cert.leaf) (CertList.cons 7 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 6 (Cert.pick 7 Cert.leaf)) CertList.nil)))) (CertList.cons 14 (Cert.pick 6 (Cert.all
  (CertList.cons 7 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 7 Cert.leaf) CertList.nil))))
  CertList.nil))))))) (CertList.cons 13 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 9 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf
  CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf)) CertList.nil))))))) (CertList.cons
  14 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  9 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick
  9 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 13 Cert.leaf)) CertList.nil))))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 12 (Cert.all
  (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 7 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 7 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 7 (Cert.pick 13 Cert.leaf))
  CertList.nil))))))) CertList.nil))))))))) (CertList.cons 12 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  6 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 9 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 13 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick
  8 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13
  Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 9 (Cert.all (CertList.cons 13
  (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))
  (CertList.cons 8 (Cert.all (CertList.cons 6 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 9 (Cert.pick 6 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  6 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil))))) (CertList.cons 14 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))) (CertList.cons 9 (Cert.pick 6 (Cert.all
  (CertList.cons 8 (Cert.pick 13 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 8 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 15 (Cert.all (CertList.cons 8 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 8
  Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 14 (Cert.all (CertList.cons 13
  Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 6 (Cert.all (CertList.cons
  8 (Cert.pick 9 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14
  Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 14 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick
  8 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) CertList.nil))))))
  (CertList.cons 14 (Cert.pick 9 (Cert.all (CertList.cons 6 (Cert.pick 8 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  8 (Cert.pick 6 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 6 (Cert.pick 15 Cert.leaf)) (CertList.cons
  15 (Cert.pick 8 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick 8 (Cert.all
  (CertList.cons 6 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14
  (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 6 (Cert.pick 14 (Cert.all (CertList.cons
  13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick 9 (Cert.pick 14 Cert.leaf)) (CertList.cons
  14 (Cert.pick 9 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) CertList.nil))))))))) (CertList.cons 13
  (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons 7 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 14 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 9 (Cert.pick 7 (Cert.all
  (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons
  14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons
  14 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 7 (Cert.all
  (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 14 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 15 (Cert.all
  (CertList.cons 14 Cert.leaf CertList.nil)))) (CertList.cons 14 (Cert.pick 9 (Cert.pick 15 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 14 Cert.leaf))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons 7 (Cert.pick 10 (Cert.all
  (CertList.cons 14 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 14 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 7 (Cert.pick 15 (Cert.all (CertList.cons 14 Cert.leaf CertList.nil))))
  (CertList.cons 14 (Cert.pick 10 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 10 (Cert.pick
  14 Cert.leaf)) CertList.nil)))))) (CertList.cons 14 (Cert.pick 7 (Cert.pick 15 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil)))
  (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  9 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf)
  (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  9 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 12 (Cert.all (CertList.cons 7 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))))
  (CertList.cons 14 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf
  CertList.nil)))) CertList.nil)))))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.pick
  15 Cert.leaf)) (CertList.cons 15 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons
  10 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  9 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))) (CertList.cons 13 (Cert.pick
  9 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons 12 (Cert.pick 8 (Cert.pick 15 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 9 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons
  9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick 9 Cert.leaf) CertList.nil))) CertList.nil))))))
  (CertList.cons 13 (Cert.pick 8 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10
  (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons
  10 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.all (CertList.cons 9 (Cert.pick 10 Cert.leaf) (CertList.cons 10 (Cert.pick
  9 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick 9 (Cert.pick 13 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  10 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 7 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf)
  (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 14 (Cert.all
  (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))))
  (CertList.cons 14 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))))
  (CertList.cons 13 (Cert.pick 10 (Cert.pick 14 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))))
  (CertList.cons 14 (Cert.pick 12 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons
  14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons
  13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 8 (Cert.pick 14 Cert.leaf)) (CertList.cons 14 (Cert.pick 8 (Cert.pick 13 Cert.leaf))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 14 Cert.leaf) (CertList.cons 14 (Cert.pick 13 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.pick 14 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9
  Cert.leaf) CertList.nil))) (CertList.cons 9 (Cert.all (CertList.cons 8 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 8 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 8 (Cert.pick
  9 Cert.leaf) (CertList.cons 9 (Cert.pick 8 Cert.leaf) CertList.nil))) CertList.nil)))))) (CertList.cons
  14 (Cert.pick 9 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 10 (Cert.pick 12
  Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 10 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil))))))))) CertList.nil))))))))))))))
