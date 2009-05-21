#lang scheme/base

(require scheme/foreign
         "low-level/gsl-matrix.ss")


(unsafe!)

(define (make-matrix rows cols [fill 0])
  (define ptr (malloc _double (* rows cols)))
  (define m (make-gsl_matrix
             rows cols rows
             ptr
             #f 0))
  (matrix-fill! m fill)
  m)

;;; API

(define matrix-rows gsl_matrix-rows)
(define matrix-cols gsl_matrix-cols)

(define (matrix-ref m r c)
  (gsl_matrix_get m r c))

(define (matrix-set! m r c v)
  (gsl_matrix_set m r c (exact->inexact v)))

(define matrix-fill! gsl_matrix_set_all)
(define matrix-zero! gsl_matrix_set_zero)
(define matrix-identity! gsl_matrix_set_identity)

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

 matrix-fill!
 matrix-identity!
 matrix-zero!
 
 matrix-set-upper-triangle!)