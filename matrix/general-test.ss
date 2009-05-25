#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "base.ss"
         "general.ss")

(define/provide-test-suite general-tests
  (test-case
   "matrix-transpose!"
   (let ([m (matrix 3 3  1 2 3 4 5 6 7 8 9)])
     (matrix-transpose! m)
     (check matrix= m (matrix 3 3  1 4 7 2 5 8 3 6 9))))

  (test-case
   "matrix-transpose"
   (let ([m (matrix 3 3  1 2 3 4 5 6 7 8 9)])
     (check matrix= (matrix-transpose m) (matrix 3 3  1 4 7 2 5 8 3 6 9))
     (check matrix= m (matrix 3 3  1 2 3 4 5 6 7 8 9))))
  )