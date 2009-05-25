#lang scheme/base

(require "base.ss"
         "../low-level/gsl-cblas.ss")

(define (matrix-product m1 m2)
  (define dest (make-matrix (matrix-rows m1) (matrix-cols m2)))
  (gsl_blas_dgemm 'CblasNoTrans 'CblasNoTrans 1.0 m1 m2 0.0 dest)
  dest)

(provide matrix-product)