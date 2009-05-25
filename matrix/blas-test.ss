#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "blas.ss"
         "base.ss")

(define/provide-test-suite blas-tests
  (test-case
   "matrix-product"
   (let* ([m1 (matrix 2 3  1 2 3 1 2 3)]
          [m2 (matrix 3 4  1 2 3 4 1 2 3 4 1 2 3 4)]
          [m3 (matrix-product m1 m2)])
     (check matrix=
            m3
            (matrix 2 4  6 12 18 24 6 12 18 24))))
  )