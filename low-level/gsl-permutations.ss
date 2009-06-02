#lang scheme/base

(require scheme/foreign
         "gsl-util.ss")


;;; Type definitions

(define-cstruct _gsl_permutation
  ([size _size_t]
   [data _pointer]))


;;; Utility functions

(unsafe!)

(define (gsl_permutation-malloc size)
  (define ptr (malloc _size_t size))
  (define p (make-gsl_permutation size ptr))
  p)


;;; GSL API

(define-gsl-unchecked (gsl_permutation_alloc _size_t -> _gsl_permutation-pointer))
(define-gsl-unchecked (gsl_permutation_calloc _size_t -> _gsl_permutation-pointer))

(define-gsl-unchecked (gsl_permutation_init _gsl_permutation-pointer -> _void))

(define-gsl-unchecked (gsl_permutation_free _gsl_permutation-pointer -> _void))


(provide
 _gsl_permutation
 _gsl_permutation-pointer
 _gsl_permutation-pointer/null
 gsl_permutation-size
 gsl_permutation-data
 make-gsl_permutation
 gsl_permutation?
 
 gsl_permutation-malloc
 gsl_permutation_alloc
 gsl_permutation_calloc
 gsl_permutation_init
 gsl_permutation_free)

