#lang scheme/base

(require (planet schematics/schemeunit:3/test))
(require "gsl-linear-algebra.ss"
         "gsl-matrix.ss")

(define e 0.00001)

(define m (gsl_matrix_alloc 3 3))

;; This matrix is pre-calculated to be
;;
;; 1         1 2 3
;; 2 4    x    4 5 
;; 3 5 6         6 
(define (initialise-m!)
  (gsl_matrix_set m 0 0 1.0)
  (gsl_matrix_set m 0 1 2.0)
  (gsl_matrix_set m 0 2 3.0)
  
  (gsl_matrix_set m 1 0 2.0)
  (gsl_matrix_set m 1 1 20.0)
  (gsl_matrix_set m 1 2 26.0)
  
  (gsl_matrix_set m 2 0 3.0)
  (gsl_matrix_set m 2 1 26.0)
  (gsl_matrix_set m 2 2 70.0))


(define/provide-test-suite gsl-linear-algebra-tests
  (test-case
   "gsl_linalg_cholesky_decomp"
   (initialise-m!)
   (gsl_linalg_cholesky_decomp m)
   
   (check-= (gsl_matrix_get m 0 0) 1 e)
   (check-= (gsl_matrix_get m 0 1) 2 e)
   (check-= (gsl_matrix_get m 0 2) 3 e)
   
   (check-= (gsl_matrix_get m 1 0) 2 e)
   (check-= (gsl_matrix_get m 1 1) 4 e)
   (check-= (gsl_matrix_get m 1 2) 5 e)
   
   (check-= (gsl_matrix_get m 2 0) 3 e)
   (check-= (gsl_matrix_get m 2 1) 5 e)
   (check-= (gsl_matrix_get m 2 2) 6 e))

  (test-case
   "gsl_linalg_cholesky_invert"
   (initialise-m!)
   (gsl_linalg_cholesky_decomp m)
   (gsl_linalg_cholesky_invert m)
   ;; (define a (matrix-copy m))
   ;; (initialise-m!)
   ;; (check matrix= (matrix-multiply m a) (matrix-identity 3 3))
   ;; For this I need CBLAS binding
   (fail "Not implemented"))
  )