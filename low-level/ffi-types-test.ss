#lang scheme/base

(require scheme/foreign
         (planet schematics/schemeunit:3/test)
         "gsl-matrix.ss"
         "ffi-types.ss")

(define/provide-test-suite ffi-types-tests
  (test-case
   "gsl_matrix->cvector"
   (let* ([m (gsl_matrix_alloc 10 10)]
          [v (gsl_matrix->cvector m)])
     (check-pred cvector? v)
     (check-equal? (cvector-length v) 100)
     (check-equal? (cvector-type v) _double)
     (cvector-set! v 0 100.0)
     (check-equal? (gsl_matrix_get m 0 0) 100.0)))
  )