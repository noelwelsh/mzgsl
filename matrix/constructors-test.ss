#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "base.ss"
         "constructors.ss")

(define/provide-test-suite constructors-tests
  (test-case
   "vector->matrix creates correct matrices"
   (check matrix=
          (vector->matrix 2 3 (v 1 2 3))
          (matrix 6 3
                  1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3))
   (check matrix= (vector->matrix 1 3 (v 1.7 2.6 3.1))
          (matrix 3 3
                  1.7 2.6 3.1 1.7 2.6 3.1 1.7 2.6 3.1))
   (check matrix=
          (vector->matrix 3 2 (v 1 2 3) #f)
          (matrix 3 6
                  1 1 1 2 2 2 3 3 3 1 1 1 2 2 2 3 3 3)))
  
  )
