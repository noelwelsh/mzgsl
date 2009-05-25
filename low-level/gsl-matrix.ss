#lang scheme/base

(require (only-in scheme/contract flat-named-contract)
         scheme/foreign
         "gsl-lib.ss"
         "gsl-util.ss")


;;; Type definitions

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

;;; Useful functions

(define (gsl_matrix-malloc r c)
  (define ptr (malloc _double (* r c)))
  (define m (make-gsl_matrix r c c ptr #f 0))
  m)

;; gsl_matrix-unsafe-ref : gsl_matrix natural -> number
;;
;; Treat the matrix as a continuous vector of elements. This
;; works for any matrices we create, as we always create
;; continous matrices (i.e. tda = rows) but in general this
;; can be incorrect. We don't do any range checking either.
(define (gsl_matrix-unsafe-ref m offset)
  (ptr-ref (gsl_matrix-data m) _double offset))


;;; Contracts

(define (gsl_matrix-of-length/c l)
  (flat-named-contract
   (format "<matrix of length ~a>" l)
   (lambda (obj)
     (and (gsl_matrix? obj)
          (= (* (gsl_matrix-cols obj) (gsl_matrix-rows obj)) l)))))

(define (gsl_matrix-of-dimensions/c r c)
  (flat-named-contract
   (format "<~a by ~a matrix>" r c)
   (lambda (obj)
     (and (gsl_matrix? obj)
          (= (gsl_matrix-rows obj) r)
          (= (gsl_matrix-cols obj) c)))))

;;; GSL API

(unsafe!)

;; Constructors

(define-gsl-unchecked (gsl_matrix_alloc _size_t _size_t -> _gsl_matrix-pointer))

(define-gsl-unchecked (gsl_matrix_calloc _size_t _size_t -> _gsl_matrix-pointer))

(define-gsl-unchecked (gsl_matrix_free _gsl_matrix-pointer -> _void))

;; Accessors and mutators

(define-gsl-unchecked (gsl_matrix_get _gsl_matrix-pointer _size_t _size_t -> _double))

(define-gsl-unchecked (gsl_matrix_set _gsl_matrix-pointer _size_t _size_t _double* -> _void))

;; Initialisers

(define-gsl-unchecked (gsl_matrix_set_all _gsl_matrix-pointer _double* -> _void))

(define-gsl-unchecked (gsl_matrix_set_zero _gsl_matrix-pointer -> _void))

(define-gsl-unchecked (gsl_matrix_set_identity _gsl_matrix-pointer -> _void))

;; Reading and writing
;; TODO

;; Matrix views
;; TODO

;; Row and column views
;; TODO

;; Copying

(define-gsl (gsl_matrix_memcpy _gsl_matrix-pointer _gsl_matrix-pointer))
  ;; dest src -> error-code


(define-gsl (gsl_matrix_swap _gsl_matrix-pointer _gsl_matrix-pointer))

;; Copying rows and columns
;; TODO

;; Exchanging rows and columns 
;; TODO

;; Matrix operations

;; a = a + b
(define-gsl (gsl_matrix_add _gsl_matrix-pointer _gsl_matrix-pointer))

;; a = a - b
(define-gsl (gsl_matrix_sub _gsl_matrix-pointer _gsl_matrix-pointer))

;; a = a * b (element-wise)
(define-gsl (gsl_matrix_mul_elements _gsl_matrix-pointer _gsl_matrix-pointer))

;; a = a / b (element-wise)
(define-gsl (gsl_matrix_div_elements _gsl_matrix-pointer _gsl_matrix-pointer))

;; a = s * a
(define-gsl (gsl_matrix_scale _gsl_matrix-pointer _double*))

;; a = x + a
(define-gsl (gsl_matrix_add_constant _gsl_matrix-pointer _double*))


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

 gsl_matrix-malloc
 gsl_matrix-unsafe-ref
 
 gsl_matrix-of-length/c
 gsl_matrix-of-dimensions/c
 
 gsl_matrix_alloc
 gsl_matrix_calloc
 gsl_matrix_free

 gsl_matrix_set_all
 gsl_matrix_set_zero
 gsl_matrix_set_identity
 
 gsl_matrix_get
 gsl_matrix_set

 gsl_matrix_memcpy
 gsl_matrix_swap

 gsl_matrix_add
 gsl_matrix_sub
 gsl_matrix_mul_elements
 gsl_matrix_div_elements
 gsl_matrix_scale
 gsl_matrix_add_constant)