#lang scheme/base

(require scheme/foreign
         "gsl-lib.ss"
         "gsl-util.ss")


;;; Type definitions

(define _size_t _int)

(define-cstruct _gsl_block
  ([size _size_t]
   [data (_f64vector i)]))

(define-cstruct _gsl_vector
  ([size   _size_t]
   [stride _size_t]
   [data   _pointer]
   [block  _pointer]
   [owner  _int]))

(define-cstruct _gsl_matrix
  ([rows  _size_t]
   [cols  _size_t]
   [tda   _size_t]
   [data  _pointer]
   [block _pointer]
   [owner _int]))


;;; GSL API


(unsafe!)

;; Constructors

(define-gsl gsl_matrix_alloc
  (_fun _size_t _size_t -> _gsl_matrix-pointer))

(define-gsl gsl_matrix_calloc
  (_fun _size_t _size_t -> _gsl_matrix-pointer))

(define-gsl gsl_matrix_free
  (_fun _gsl_matrix-pointer -> _void))



;; Accessors and mutators

(define-gsl gsl_matrix_get
  (_fun _gsl_matrix-pointer _size_t _size_t -> _double))

(define-gsl gsl_matrix_set
  (_fun _gsl_matrix-pointer _size_t _size_t _double -> _void))

;; etc...


(provide
 _gsl_block
 _gsl_block-pointer
 _gsl_block-pointer/null
 gsl_block-tag
 make-gsl_block
 gsl_block?
 gsl_block-size
 
 
 _gsl_vector
 _gsl_vector-pointer
 _gsl_vector-pointer/null
 gsl_vector-tag
 make-gsl_vector
 gsl_vector?
 gsl_vector-size
 gsl_vector-stride
 gsl_vector-data
 gsl_vector-block
 gsl_vector-owner
  
 
 _gsl_matrix
 _gsl_matrix-pointer
 _gsl_matrix-pointer/null
 gsl_matrix-tag
 make-gsl_matrix
 gsl_matrix?
 gsl_matrix-rows
 gsl_matrix-cols
 gsl_matrix-tda
 gsl_matrix-data
 gsl_matrix-block
 gsl_matrix-owner
 
 gsl_matrix_alloc
 gsl_matrix_calloc
 gsl_matrix_free

 gsl_matrix_get
 gsl_matrix_set)