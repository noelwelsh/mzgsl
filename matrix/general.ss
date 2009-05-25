#lang scheme/base

(require "../low-level/gsl-matrix.ss"
         "base.ss"
         "constructors.ss")

(define matrix-transpose! gsl_matrix_transpose)

(define (matrix-transpose m)
  (define m2 (matrix-copy m))
  (matrix-transpose! m2)
  m2)

(provide matrix-transpose!
         matrix-transpose)