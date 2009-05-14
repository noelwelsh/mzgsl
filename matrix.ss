#lang scheme/base

(require scheme/foreign
         "low-level/gsl-matrix.ss")


(unsafe!)

(define (make-matrix rows cols)
  (make-gsl_matrix
   rows cols 0
   (malloc _double (* rows cols))
   #f 0))

(provide
 make-matrix)