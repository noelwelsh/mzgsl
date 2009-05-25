#lang scheme/base

(require scheme/foreign
         "gsl-matrix.ss"
         "gsl-util.ss")

(define _CBLAS_INDEX _size_t)

(define _CBLAS_ORDER
  (_enum '(CblasRowMajor = 101
           CblasColMajor = 102)))

(define _CBLAS_TRANSPOSE
  (_enum '(CblasNoTrans   = 111
           CblasTrans     = 112
           CblasConjTrans = 113)))
(define _CBLAS_UPLO
  (_enum '(CblasUpper = 121
           CblasLower = 122)))

(define _CBLAS_DIAG
  (_enum '(CblasNonUnit = 131
           CblasUnit    = 132)))

(define _CBLAS_SIDE
  (_enum '(CblasLeft  = 141
           CblasRight = 142)))

;; C = alpha A B + beta C
(define-gsl (gsl_blas_dgemm _CBLAS_TRANSPOSE _CBLAS_TRANSPOSE
                            _double* ;; alpha
                            _gsl_matrix-pointer _gsl_matrix-pointer ;; A B
                            _double* ;; beta
                            _gsl_matrix-pointer))

(provide
 _CBLAS_INDEX
 _CBLAS_ORDER
 _CBLAS_TRANSPOSE
 _CBLAS_UPLO
 _CBLAS_DIAG
 _CBLAS_SIDE

 gsl_blas_dgemm)