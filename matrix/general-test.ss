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
  )