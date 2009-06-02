#lang scheme/base

(require "low-level/gsl-linear-algebra.ss"
         "matrix.ss")

;;; API

(define matrix-cholesky! gsl_linalg_cholesky_decomp)
(define matrix-cholesky-invert! gsl_linalg_cholesky_invert)

(define (matrix-cholesky m)
  (define m2 (matrix-copy m))
  (matrix-cholesky! m2)
  m2)

(define (matrix-cholesky-invert m)
  (define m2 (matrix-copy m))
  (matrix-cholesky-invert! m2)
  m2)

;; (matrix -> number)
;;
;; Calculate the determinant of a (symmetric positive
;; definite) matrix given its Cholesky decomposition
(define (matrix-cholesky-determinant m)
  (define l (matrix-rows m))
  (define product
    (for/fold ([prod 1])
        ([i (in-range l)])
      (* prod (matrix-ref m i i))))
  (* product product))


(define matrix-lu! gsl_linalg_LU_decomp)
  

(provide
 matrix-cholesky!
 matrix-cholesky-invert!

 matrix-cholesky
 matrix-cholesky-invert
 
 matrix-cholesky-determinant

 matrix-lu!)