#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "base.ss"
         "general.ss")

(define/provide-test-suite general-tests
  (test-case
   "matrix-square?"
   (check-true (matrix-square? (make-matrix 3 3)))
   (check-false (matrix-square? (make-matrix 4 2))))
  
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

  (test-case
   "non-square matrix-transpose"
   (let ([m (matrix 4 2  1 2 3 4 5 6 7 8)])
     (check matrix= (matrix-transpose (matrix-transpose m)) m)
     (check matrix= (matrix-transpose m) (matrix 2 4  1 3 5 7 2 4 6 8))))

;;; Element wise operations
  
  (test-case
   "matrix+!"
   (let ([m1 (matrix 3 3  1 2 3 4 5 6 7 8 9)]
         [m2 (matrix 3 3  9 8 7 6 5 4 3 2 1)])
     (matrix+! m1 m2)
     (check matrix= m1 (matrix 3 3  10 10 10 10 10 10 10 10 10))))

  (test-case
   "matrix+"
   (let ([m1 (matrix 3 3  1 2 3 4 5 6 7 8 9)]
         [m2 (matrix 3 3  9 8 7 6 5 4 3 2 1)])
     (check matrix= (matrix+ m1 m2) (matrix 3 3  10 10 10 10 10 10 10 10 10))))

  (test-case
   "matrix-!"
   (let ([m1 (matrix 3 3  1 2 3 4 5 6 7 8 9)]
         [m2 (matrix 3 3  9 8 7 6 5 4 3 2 1)])
     (matrix-! m1 m2)
     (check matrix= m1 (matrix 3 3  -8 -6 -4 -2 0 2 4 6 8))))

  (test-case
   "matrix-"
   (let ([m1 (matrix 3 3  1 2 3 4 5 6 7 8 9)]
         [m2 (matrix 3 3  9 8 7 6 5 4 3 2 1)])
     (check matrix= (matrix- m1 m2) (matrix 3 3  -8 -6 -4 -2 0 2 4 6 8))))

  (test-case
   "matrix*!"
   (let ([m1 (matrix 3 3  1 2 3 4 5 6 7 8 9)]
         [m2 (matrix 3 3  2 2 2 2 2 2 2 2 2)])
     (matrix*! m1 m2)
     (check matrix= m1 (matrix 3 3  2 4 6 8 10 12 14 16 18))))

  (test-case
   "matrix*"
   (let ([m1 (matrix 3 3  1 2 3 4 5 6 7 8 9)]
         [m2 (matrix 3 3  2 2 2 2 2 2 2 2 2)])
     (check matrix= (matrix* m1 m2) (matrix 3 3  2 4 6 8 10 12 14 16 18))))

  (test-case
   "matrix/!"
   (let ([m1 (matrix 3 3  2 4 6 8 10 12 14 16 18)]
         [m2 (matrix 3 3  2 2 2 2  2  2  2  2  2)])
     (matrix/! m1 m2)
     (check matrix= m1 (matrix 3 3  1 2 3 4 5 6 7 8 9))))

  (test-case
   "matrix/"
   (let ([m1 (matrix 3 3  2 4 6 8 10 12 14 16 18)]
         [m2 (matrix 3 3  2 2 2 2  2  2  2  2  2)])
     (check matrix= (matrix/ m1 m2) (matrix 3 3  1 2 3 4 5 6 7 8 9))))

;;; Matrix/scalar operations

  (test-case
   "matrix+s!"
   (let ([m (matrix 3 3  1 2 3 4 5 6 7 8 9)])
     (matrix+s! m 1)
     (check matrix= m (matrix 3 3  2 3 4 5 6 7 8 9 10))))

  (test-case
   "matrix+s"
   (let ([m (matrix 3 3  1 2 3 4 5 6 7 8 9)])
     (check matrix= (matrix+s m 1) (matrix 3 3  2 3 4 5 6 7 8 9 10))
     (check matrix= m (matrix 3 3  1 2 3 4 5 6 7 8 9))))

  (test-case
   "matrix-s!"
   (let ([m (matrix 3 3  1 2 3 4 5 6 7 8 9)])
     (matrix-s! m 1)
     (check matrix= m (matrix 3 3  0 1 2 3 4 5 6 7 8))))

  (test-case
   "matrix-s"
   (let ([m (matrix 3 3  1 2 3 4 5 6 7 8 9)])
     (check matrix= (matrix-s m 1) (matrix 3 3  0 1 2 3 4 5 6 7 8))
     (check matrix= m (matrix 3 3  1 2 3 4 5 6 7 8 9))))
  
  (test-case
   "matrix*s!"
   (let ([m (matrix 3 3  1 2 3 4 5 6 7 8 9)])
     (matrix*s! m 2)
     (check matrix= m (matrix 3 3  2 4 6 8 10 12 14 16 18))))

  (test-case
   "matrix*s"
   (let ([m (matrix 3 3  1 2 3 4 5 6 7 8 9)])
     (check matrix= (matrix*s m 2) (matrix 3 3  2 4 6 8 10 12 14 16 18))
     (check matrix= m (matrix 3 3  1 2 3 4 5 6 7 8 9))))

  (test-case
   "matrix/s!"
   (let ([m (matrix 3 3  1 2 3 4 5 6 7 8 9)])
     (matrix/s! m 2)
     (check matrix= m (matrix 3 3  1/2 1 3/2 2 5/2 3 7/2 4 9/2))))

  (test-case
   "matrix/s"
   (let ([m (matrix 3 3  1 2 3 4 5 6 7 8 9)])
     (check matrix= (matrix/s m 2) (matrix 3 3  1/2 1 3/2 2 5/2 3 7/2 4 9/2))
     (check matrix= m (matrix 3 3  1 2 3 4 5 6 7 8 9))))

  )