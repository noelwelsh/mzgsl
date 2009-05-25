#lang scheme/base

(require (planet schematics/schemeunit:3)
         "base.ss")

(define-check (check-matrix= m1 m2 e)
  (with-check-info
   (['message (format "Matrix rows ~a and ~a" (matrix-rows m1) (matrix-rows m2))])
   (check-eq? (matrix-rows m1) (matrix-rows m2)))
  (with-check-info
   (['message (format "Matrix cols ~a and ~a" (matrix-cols m1) (matrix-cols m2))])
   (check-eq? (matrix-cols m1) (matrix-cols m2)))

  (for ([i (in-range (matrix-rows m1))]
        [j (in-range (matrix-rows m2))])
    (let ([x1 (matrix-ref m1 i j)]
          [x2 (matrix-ref m2 i j)])
      (with-check-info
       (['message
         (format
          "Elements at <~a,~a> ~a and ~a not within ~a" i j x1 x2 e)])
       (check-= x1 x2 e)))))

(provide check-matrix=)