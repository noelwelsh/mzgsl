#lang scheme/base

(require scheme/foreign
         "gsl-permutations.ss"
         "gsl-matrix.ss"
         "gsl-util.ss")

(define-gsl (gsl_linalg_cholesky_decomp _gsl_matrix-pointer))
(define-gsl (gsl_linalg_cholesky_invert _gsl_matrix-pointer))

(define-gsl (gsl_linalg_LU_decomp _gsl_matrix-pointer _gsl_permutation-pointer (_box _int)))
(define-gsl (gsl_linalg_LU_invert _gsl_matrix-pointer _gsl_permutation-pointer _gsl_matrix-pointer))
(define-gsl-unchecked (gsl_linalg_LU_det _gsl_matrix-pointer _int -> _double))

(provide gsl_linalg_cholesky_decomp
         gsl_linalg_cholesky_invert

         gsl_linalg_LU_decomp
         gsl_linalg_LU_invert
         gsl_linalg_LU_det)