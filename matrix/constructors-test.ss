#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "base.ss"
         "constructors.ss")

(define/provide-test-suite constructors-tests
  (test-case
   "vector->matrix creates correct matrices"
   (check matrix=
          (vector->matrix 2 3 (vector 1 2 3))
          (matrix 6 3
                  1 1 1 2 2 2 3 3 3 1 1 1 2 2 2 3 3 3))
   (check matrix=
          (vector->matrix 2 3 (vector 1 2 3) #f)
          (matrix 2 9
                  1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3))
   (check matrix=
          (vector->matrix 1 3 (vector 1.7 2.6 3.1) #f)
          (matrix 1 9
                  1.7 2.6 3.1 1.7 2.6 3.1 1.7 2.6 3.1)))

  (test-case
   "matrix-copy!"
   (let* ([a (matrix 3 3  1 2 3 4 5 6 7 8 9)]
          [b (make-matrix 3 3)])
     (check-false (matrix= a b))
     (matrix-copy! b a)
     (check matrix= a b)
     (matrix-set! b 0 0 10)
     (check-false (matrix= a b))))
  
  (test-case
   "matrix-copy"
   (let* ([a (matrix 3 3  1 2 3 4 5 6 7 8 9)]
          [b (matrix-copy a)])
     (check matrix= a b)
     (matrix-set! b 0 0 10)
     (check-false (matrix= a b))))
  
  )
