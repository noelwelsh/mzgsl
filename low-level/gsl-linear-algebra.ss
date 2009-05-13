#lang scheme/base

(require scheme/foreign
         "gsl-matrix.ss"
         "gsl-util.ss")

(define-gsl gsl_linalg_cholesky_decomp
  (_fun _gsl_matrix-pointer -> _int))


(provide gsl_linalg_cholesky_decomp)