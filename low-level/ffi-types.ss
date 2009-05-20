#lang scheme/base

(require scheme/foreign
         "gsl-matrix.ss")

(unsafe!)

;; These types and functions are designed for interoperability with C
;; libraries that take pointers to double (*double) when we
;; want to supply a gsl_vector or gsl_matrix

;; gsl_matrix -> _pointer
;;
;; Convert a gsl_matrix to a _pointer to its data
(define gsl_matrix->_pointer gsl_matrix-data)

;; gsl_matrix -> (cvectorof _double)
;;
;; Convert a gsl_matrix to a cvector of _double
(define (gsl_matrix->cvector m)
  (make-cvector* (gsl_matrix->_pointer m)
                 _double
                 (* (gsl_matrix-rows m) (gsl_matrix-cols m))))

;; (cvectorof double) natural natural -> gsl_matrix
(define (cvector->gsl_matrix v r c)
  (make-gsl_matrix
   r c r
   (cvector-ptr v)
   #f
   0))

(provide gsl_matrix->_pointer
         gsl_matrix->cvector
         cvector->gsl_matrix)