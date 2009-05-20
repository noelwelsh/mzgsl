#lang scheme/base

(require scheme/foreign
         "low-level/gsl-matrix.ss")


(unsafe!)

(define (make-matrix rows cols)
  (define ptr (malloc _double (* rows cols)))
  (memset ptr 0 (* rows cols) _double)
  (make-gsl_matrix
   rows cols rows
   ptr
   #f 0))

;;; API

(define matrix-rows gsl_matrix-rows)
(define matrix-cols gsl_matrix-cols)

(define (matrix-ref m r c)
  (gsl_matrix_get m r c))

(define (matrix-set! m r c v)
  (gsl_matrix_set m r c (exact->inexact v)))

(define (matrix-set-upper-triangle! m v)
  (define r (matrix-rows m))
  (define c (matrix-cols m))
  (for* ([i (in-range r)]
         [j (in-range (add1 i) c)])
        (matrix-set! m i j v)))
        

(provide
 make-matrix
 matrix-rows
 matrix-cols
 matrix-ref
 matrix-set!

 matrix-set-upper-triangle!)