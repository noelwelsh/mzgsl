#lang scheme/base

(require "base.ss"
         "comprehensions.ss"
         "../low-level/gsl-matrix.ss")

;; vector->matrix : integer integer vector [boolean] -> matrix
;;
;; Creating a matrix by repeating vector rows times in the
;; rows dimension and cols time in the column dimension
;;
;; Assumes the vector is a column vector unless the final
;; optional argument is false
(define (vector->matrix rows cols v [col? #t])
  (define l (vector-length v))
  (if col?
      (for/fold/matrix ()
                       ([(r c) (* l rows) cols])
        (vector-ref v (modulo r l)))
      (for/fold/matrix ()
                       ([(r c) rows (* l cols)])
        (vector-ref v (modulo c l)))))

(define matrix-copy! gsl_matrix_memcpy)

(define (matrix-copy m)
  (define dest (make-matrix (matrix-rows m) (matrix-cols m)))
  (matrix-copy! dest m)
  dest)

(provide vector->matrix
         matrix-copy!
         matrix-copy)