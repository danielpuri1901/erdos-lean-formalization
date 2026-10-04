import Solution.Cert

namespace CatchUpDeep

-- Catch-Up strategy certificate, N = 16, ge side, root child with key 14
-- ge root = Cert.pick 1 (Cert.all (CertList.cons k cert16ge_k ...)), keys k in [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16], gap 1
-- definition: cert16ge_14
-- position: l = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 16], g = 13
-- checker: chkGe
-- nodes: 3287
-- (claim: chkGe [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 16] 13 cert16ge_14 = true)
set_option maxRecDepth 100000 in
noncomputable def cert16ge_14 : Cert :=
   (Cert.pick 2 (Cert.pick 3 (Cert.pick 4 (Cert.pick 5 (Cert.all (CertList.cons 6 (Cert.pick 7 (Cert.all
  (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12
  (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15
  Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  16 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 11 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick
  15 Cert.leaf)) CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf
  CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick
  12 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all (CertList.cons 11 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) CertList.nil))))))
  (CertList.cons 16 (Cert.pick 10 (Cert.pick 15 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil)))))))) (CertList.cons 9 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick
  15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  10 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  10 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 11 (Cert.pick
  13 (Cert.all (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  11 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 12 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all
  (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  11 (Cert.pick 9 (Cert.all (CertList.cons 8 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13
  (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 10 (Cert.pick
  13 (Cert.all (CertList.cons 8 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 8 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 16 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 Cert.leaf))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))))
  (CertList.cons 13 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 15
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick
  16 Cert.leaf) (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 8 (Cert.pick
  13 Cert.leaf)) CertList.nil)))))) (CertList.cons 16 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons
  8 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 13
  Cert.leaf)) CertList.nil)))))) CertList.nil)))))))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 10 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 8 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons 16 (Cert.pick
  8 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons
  8 (Cert.pick 16 Cert.leaf) (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons
  8 (Cert.pick 15 Cert.leaf) (CertList.cons 11 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick
  10 (Cert.all (CertList.cons 8 (Cert.pick 12 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 15
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) (CertList.cons 16 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 16 Cert.leaf) (CertList.cons
  11 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 11
  Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  (CertList.cons 15 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons
  15 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 16 (Cert.all (CertList.cons 11
  (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  9 (Cert.pick 16 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick
  16 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))) (CertList.cons 16 (Cert.pick 9 (Cert.pick 13
  Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.pick
  16 Cert.leaf) (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 9 (Cert.pick
  11 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 9 (Cert.pick
  16 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick 16 (Cert.all
  (CertList.cons 9 Cert.leaf CertList.nil))) (CertList.cons 16 (Cert.pick 9 (Cert.pick 11 Cert.leaf))
  CertList.nil))))) (CertList.cons 16 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))) (CertList.cons
  16 (Cert.pick 9 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 11
  (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  8 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 13
  Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.pick
  15 Cert.leaf) (CertList.cons 11 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 8 (Cert.pick
  11 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick
  15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick 15 (Cert.all
  (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 11 Cert.leaf))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))) CertList.nil))))))))))
  (CertList.cons 7 (Cert.pick 6 (Cert.all (CertList.cons 8 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick
  15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  10 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil)))))))) (CertList.cons
  9 (Cert.pick 8 (Cert.pick 13 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12
  (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 11 (Cert.all
  (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 11 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons 11 (Cert.all (CertList.cons 10 (Cert.pick
  12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.all
  (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))
  CertList.nil))))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 Cert.leaf) CertList.nil))) (CertList.cons
  11 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil)))))))) (CertList.cons 10 (Cert.pick 9 (Cert.pick 11 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  15 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 16 Cert.leaf) (CertList.cons 13 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 8 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons
  16 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 13 Cert.leaf CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons
  15 (Cert.pick 8 (Cert.pick 13 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons 11
  (Cert.pick 9 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 13 (Cert.all (CertList.cons 12 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 12 (Cert.pick 16 (Cert.all (CertList.cons
  8 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 16 (Cert.all (CertList.cons 15
  Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  (CertList.cons 16 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick
  13 (Cert.all (CertList.cons 8 (Cert.pick 16 Cert.leaf) (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 8 (Cert.pick 12 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 13 (Cert.all
  (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) (CertList.cons
  12 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick
  8 (Cert.pick 12 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons 12 (Cert.pick 9 (Cert.pick
  13 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 15
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 11 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.pick 11 (Cert.all
  (CertList.cons 8 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons
  8 (Cert.pick 16 Cert.leaf) (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 11 (Cert.all (CertList.cons
  8 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  8 (Cert.pick 10 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons 13 (Cert.pick 9 (Cert.pick
  12 (Cert.all (CertList.cons 8 (Cert.pick 11 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 15
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) (CertList.cons 16 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.pick 16 Cert.leaf) (CertList.cons
  10 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 8 (Cert.pick 10 Cert.leaf)) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 10
  Cert.leaf CertList.nil))) (CertList.cons 10 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil)))
  (CertList.cons 15 (Cert.pick 8 (Cert.pick 10 Cert.leaf)) CertList.nil))))) CertList.nil)))))))) (CertList.cons
  15 (Cert.pick 9 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 16 (Cert.all (CertList.cons 11
  (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 13 (Cert.all (CertList.cons
  8 (Cert.pick 16 Cert.leaf) (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  8 (Cert.pick 12 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  8 (Cert.pick 16 Cert.leaf) (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.pick 8 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 8 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))) (CertList.cons 16 (Cert.pick 9 (Cert.pick
  11 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12
  (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.pick 15 (Cert.all
  (CertList.cons 13 Cert.leaf CertList.nil))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons
  8 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 13 Cert.leaf)) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 8 (Cert.pick 15 Cert.leaf) (CertList.cons
  10 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 8 (Cert.pick 10 Cert.leaf)) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 8 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 8 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  CertList.nil)))))))) CertList.nil)))))))))) (CertList.cons 8 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))))
  CertList.nil)))))) (CertList.cons 12 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 13 (Cert.pick 11 (Cert.pick 12 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 15 (Cert.pick
  10 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  16 (Cert.pick 11 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 16 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 12 (Cert.all (CertList.cons
  7 (Cert.pick 16 Cert.leaf) (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  7 (Cert.pick 13 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 13 (Cert.all (CertList.cons
  7 (Cert.pick 15 Cert.leaf) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 12 Cert.leaf)) CertList.nil))))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 10 (Cert.all
  (CertList.cons 7 (Cert.pick 13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 16 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))
  (CertList.cons 15 (Cert.pick 7 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 7 (Cert.pick
  15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  16 (Cert.pick 7 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 7 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick
  11 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))))
  (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons
  15 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 16 Cert.leaf) (CertList.cons 11 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons
  16 (Cert.pick 11 (Cert.all (CertList.cons 7 (Cert.pick 15 Cert.leaf) (CertList.cons 10 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 7 (Cert.pick 10 Cert.leaf)) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 7 (Cert.pick 11 (Cert.all (CertList.cons 10
  (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons
  10 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons
  7 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 7 (Cert.pick 15 Cert.leaf))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all
  (CertList.cons 15 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 7 (Cert.pick 16 Cert.leaf))
  (CertList.cons 16 (Cert.pick 7 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick
  7 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 11
  Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick 10 (Cert.all (CertList.cons
  11 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 11 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 7 (Cert.pick 16 (Cert.all (CertList.cons 11
  (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick 7 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 12 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 7 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 7 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 16 (Cert.pick 7 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) CertList.nil))))))))))
  (CertList.cons 9 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 10 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 12 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))))
  (CertList.cons 15 (Cert.pick 13 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick
  15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick
  10 (Cert.pick 13 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  11 Cert.leaf CertList.nil))) CertList.nil)))))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick
  12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))) CertList.nil)))))) CertList.nil))))))) (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all
  (CertList.cons 6 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 16 (Cert.all (CertList.cons 6 (Cert.all
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 6 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 6 (Cert.pick 13 (Cert.all
  (CertList.cons 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 12 (Cert.pick
  16 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 6 (Cert.pick 12 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 6 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 6 (Cert.pick 13 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))))) (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons 6 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 10 (Cert.all
  (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 11 (Cert.all
  (CertList.cons 6 (Cert.pick 12 (Cert.all (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 10 (Cert.pick 16 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons
  12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  12 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons
  12 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  16 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick
  10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  16 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) CertList.nil)))))))))) (CertList.cons 10 (Cert.pick 7 (Cert.pick
  8 (Cert.all (CertList.cons 6 (Cert.pick 11 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick
  13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick
  16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons
  12 (Cert.pick 13 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 12 (Cert.pick 13
  Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 6 (Cert.all
  (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 13 (Cert.pick 15 Cert.leaf))
  CertList.nil))))) (CertList.cons 12 (Cert.pick 13 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons
  13 (Cert.pick 16 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 13 (Cert.all
  (CertList.cons 6 (Cert.all (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  9 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick
  12 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) CertList.nil)))))
  (CertList.cons 9 (Cert.pick 12 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick
  9 (Cert.all (CertList.cons 6 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 6 (Cert.pick 15 Cert.leaf))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick
  6 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12
  Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons
  6 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  11 (Cert.pick 6 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 13 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons
  11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf)
  (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 16 (Cert.pick
  6 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  CertList.nil))))))) CertList.nil)))))))))) (CertList.cons 11 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons
  6 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  10 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons
  9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 9 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil)))))
  (CertList.cons 12 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 10 (Cert.pick
  9 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 13 (Cert.pick 9 (Cert.pick 15 Cert.leaf)) (CertList.cons 15 (Cert.pick 10 (Cert.pick
  13 Cert.leaf)) CertList.nil))))) (CertList.cons 13 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 10 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 15 Cert.leaf))
  (CertList.cons 15 (Cert.pick 10 (Cert.pick 12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil))))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) CertList.nil))))))) (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 6 (Cert.pick
  13 (Cert.all (CertList.cons 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  12 (Cert.pick 16 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick 6 (Cert.pick 12 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 6 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons
  9 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15
  Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 9 (Cert.pick 16 (Cert.all (CertList.cons 15
  Cert.leaf CertList.nil)))) (CertList.cons 15 (Cert.pick 12 (Cert.pick 16 Cert.leaf)) (CertList.cons
  16 (Cert.pick 12 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 9 (Cert.pick 12 (Cert.all
  (CertList.cons 6 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons 6 (Cert.pick
  16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 6 (Cert.pick
  16 Cert.leaf)) (CertList.cons 16 (Cert.pick 6 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons
  12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil)))))))
  (CertList.cons 12 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 13 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  16 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick
  6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 10 (Cert.pick
  13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))) (CertList.cons 16 (Cert.pick
  6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf)
  (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick
  13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))) CertList.nil))))))))))
  (CertList.cons 12 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 6 (Cert.pick 13 (Cert.all (CertList.cons
  9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 10 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 Cert.leaf))
  CertList.nil))))) (CertList.cons 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 9 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))) (CertList.cons
  15 (Cert.pick 11 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 11 (Cert.pick 15 Cert.leaf))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 9 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 15 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 16 Cert.leaf)
  (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 9 (Cert.pick 11 Cert.leaf))
  CertList.nil))))) (CertList.cons 16 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 15 (Cert.all
  (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons 11 (Cert.pick 15 (Cert.all (CertList.cons
  9 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick 9 (Cert.pick 11 Cert.leaf)) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 6 (Cert.pick 13 (Cert.all
  (CertList.cons 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))))) (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons 6 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))))
  (CertList.cons 13 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 10 (Cert.all
  (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))))
  (CertList.cons 16 (Cert.pick 6 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 9 (Cert.all
  (CertList.cons 6 (Cert.pick 16 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 13 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil))) (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 13 (Cert.pick
  6 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15
  Cert.leaf) CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil))))) (CertList.cons
  16 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 13 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick
  9 (Cert.all (CertList.cons 10 (Cert.pick 13 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  13 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 15
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  15 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf)
  CertList.nil)))) CertList.nil))))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  16 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf)
  CertList.nil)))) (CertList.cons 16 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil))))))) (CertList.cons
  16 (Cert.pick 6 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 13
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 13 Cert.leaf)) CertList.nil))))))) CertList.nil)))))))))) (CertList.cons 13 (Cert.pick
  7 (Cert.pick 9 (Cert.all (CertList.cons 6 (Cert.pick 10 (Cert.all (CertList.cons 8 (Cert.pick 12 (Cert.all
  (CertList.cons 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons 11 (Cert.pick
  12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) CertList.nil))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 8 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))
  (CertList.cons 15 (Cert.pick 16 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons
  16 (Cert.pick 8 (Cert.pick 15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 12 (Cert.all
  (CertList.cons 8 (Cert.pick 16 Cert.leaf) (CertList.cons 11 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) (CertList.cons 16 (Cert.pick 12 (Cert.all
  (CertList.cons 8 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil))) (CertList.cons
  11 (Cert.pick 15 (Cert.all (CertList.cons 8 Cert.leaf CertList.nil))) (CertList.cons 15 (Cert.pick
  8 (Cert.pick 11 Cert.leaf)) CertList.nil))))) CertList.nil))))))) (CertList.cons 8 (Cert.pick 10 (Cert.all
  (CertList.cons 6 (Cert.pick 12 (Cert.all (CertList.cons 11 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 11 Cert.leaf CertList.nil)))
  CertList.nil))))) (CertList.cons 11 (Cert.pick 16 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons
  12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))) (CertList.cons
  12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 6 (Cert.pick 16 (Cert.all (CertList.cons 15 Cert.leaf CertList.nil)))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 16 Cert.leaf)) (CertList.cons 16 (Cert.pick 6 (Cert.pick
  15 Cert.leaf)) CertList.nil))))) (CertList.cons 15 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons
  12 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons
  16 (Cert.pick 6 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15
  (Cert.pick 12 Cert.leaf) CertList.nil))))) CertList.nil))))))) (CertList.cons 10 (Cert.pick 11 (Cert.all
  (CertList.cons 6 (Cert.pick 12 (Cert.all (CertList.cons 8 (Cert.all (CertList.cons 15 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick
  16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 8 (Cert.pick
  12 (Cert.all (CertList.cons 6 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16
  (Cert.pick 15 Cert.leaf) CertList.nil))) (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick 8 (Cert.all
  (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 12 Cert.leaf) CertList.nil))))) (CertList.cons 16 (Cert.pick 6 (Cert.pick 8 (Cert.all
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))))
  CertList.nil))))))) (CertList.cons 11 (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick
  12 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 16 (Cert.all
  (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil))))
  (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons
  12 (Cert.pick 10 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons 12 (Cert.pick 6 (Cert.pick
  8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 15 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons
  15 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 15 Cert.leaf) CertList.nil)))) (CertList.cons
  15 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) CertList.nil))))))) (CertList.cons
  15 (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  11 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))) CertList.nil))))))) (CertList.cons
  16 (Cert.pick 6 (Cert.pick 8 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12
  (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))) CertList.nil))))))) CertList.nil))))))))))
  (CertList.cons 15 (Cert.pick 6 (Cert.pick 7 (Cert.pick 8 (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all
  (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons
  13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons
  10 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 16
  Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  11 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 16 Cert.leaf)
  (CertList.cons 16 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 12 (Cert.all
  (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons
  16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 16 (Cert.all (CertList.cons
  10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons
  16 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil)))) CertList.nil))))))
  (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 13
  (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 16 (Cert.all (CertList.cons 10 (Cert.pick
  11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf) CertList.nil)))) (CertList.cons 16 (Cert.pick
  11 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons 13 (Cert.pick 10 (Cert.all (CertList.cons
  9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 16 Cert.leaf) (CertList.cons 16 (Cert.pick 12
  Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 16 (Cert.all (CertList.cons 9 (Cert.pick 12
  Cert.leaf) (CertList.cons 12 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick
  16 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 9 Cert.leaf) CertList.nil))))
  (CertList.cons 16 (Cert.pick 11 (Cert.pick 12 Cert.leaf)) CertList.nil)))))) (CertList.cons 16 (Cert.pick
  9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.pick 13 (Cert.all
  (CertList.cons 12 Cert.leaf CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.pick 13 Cert.leaf))
  (CertList.cons 13 (Cert.pick 11 (Cert.pick 12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil))))
  CertList.nil)))))) CertList.nil)))))))))) (CertList.cons 16 (Cert.pick 6 (Cert.pick 7 (Cert.pick 8
  (Cert.all (CertList.cons 9 (Cert.pick 10 (Cert.all (CertList.cons 11 (Cert.pick 12 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick
  11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf)
  CertList.nil)))) CertList.nil)))))) (CertList.cons 10 (Cert.pick 9 (Cert.all (CertList.cons 11 (Cert.pick
  12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf)
  CertList.nil)))) (CertList.cons 12 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf)
  (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 15 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons
  13 (Cert.pick 12 Cert.leaf) CertList.nil)))) CertList.nil)))))) (CertList.cons 11 (Cert.pick 9 (Cert.all
  (CertList.cons 10 (Cert.pick 12 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons
  15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 12 (Cert.pick 10 (Cert.all (CertList.cons
  13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons
  13 (Cert.pick 15 (Cert.all (CertList.cons 10 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick
  10 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons
  12 Cert.leaf CertList.nil)))) CertList.nil)))))) (CertList.cons 12 (Cert.pick 9 (Cert.all (CertList.cons
  10 (Cert.pick 11 (Cert.all (CertList.cons 13 (Cert.pick 15 Cert.leaf) (CertList.cons 15 (Cert.pick
  13 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick 10 (Cert.all (CertList.cons 13 (Cert.pick
  15 Cert.leaf) (CertList.cons 15 (Cert.pick 13 Cert.leaf) CertList.nil)))) (CertList.cons 13 (Cert.pick
  15 (Cert.all (CertList.cons 10 (Cert.pick 11 Cert.leaf) (CertList.cons 11 (Cert.pick 10 Cert.leaf)
  CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) CertList.nil)))))) (CertList.cons
  13 (Cert.pick 10 (Cert.all (CertList.cons 9 (Cert.pick 11 (Cert.all (CertList.cons 12 (Cert.pick 15
  Cert.leaf) (CertList.cons 15 (Cert.pick 12 Cert.leaf) CertList.nil)))) (CertList.cons 11 (Cert.pick
  15 (Cert.all (CertList.cons 9 (Cert.pick 12 Cert.leaf) (CertList.cons 12 (Cert.pick 9 Cert.leaf) CertList.nil))))
  (CertList.cons 12 (Cert.pick 15 (Cert.all (CertList.cons 9 (Cert.pick 11 Cert.leaf) (CertList.cons
  11 (Cert.pick 9 Cert.leaf) CertList.nil)))) (CertList.cons 15 (Cert.pick 11 (Cert.pick 12 Cert.leaf))
  CertList.nil)))))) (CertList.cons 15 (Cert.pick 9 (Cert.all (CertList.cons 10 (Cert.pick 11 (Cert.all
  (CertList.cons 12 (Cert.pick 13 Cert.leaf) (CertList.cons 13 (Cert.pick 12 Cert.leaf) CertList.nil))))
  (CertList.cons 11 (Cert.pick 10 (Cert.pick 13 (Cert.all (CertList.cons 12 Cert.leaf CertList.nil))))
  (CertList.cons 12 (Cert.pick 11 (Cert.pick 13 Cert.leaf)) (CertList.cons 13 (Cert.pick 11 (Cert.pick
  12 (Cert.all (CertList.cons 10 Cert.leaf CertList.nil)))) CertList.nil)))))) CertList.nil))))))))))
  CertList.nil)))))))))))))))

set_option maxRecDepth 100000 in
theorem cert16ge_14_ok : chkGe (((List.range' 1 16).erase 1).erase 14) 13 cert16ge_14 = true := by decide +kernel

end CatchUpDeep
