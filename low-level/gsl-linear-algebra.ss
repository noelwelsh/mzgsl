#lang scheme/base

(require scheme/foreign
         "gsl-matrix.ss"
         "gsl-util.ss")

(define-gsl (gsl_linalg_cholesky_decomp _gsl_matrix-pointer))
(define-gsl (gsl_linalg_cholesky_invert _gsl_matrix-pointer))

(provide gsl_linalg_cholesky_decomp
         gsl_linalg_cholesky_invert)