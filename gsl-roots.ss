#lang scheme

(require "gsl-lib.ss"
         "gsl-function.ss"
         scheme/foreign)

(unsafe!)

(define-syntax define-gsl-root-struct
  (syntax-rules ()
    ((define-gsl-root-struct _name-pointer name?)
     (begin
       (define tag (gensym '_name-pointer))
       (define _name-pointer (_cpointer tag))
       (define (name? obj)
         (and (cpointer? obj)
              (cpointer-has-tag? obj tag)))))))

(define-gsl-root-struct _gsl-root-fsolver-type-pointer gsl-root-fsolver-type?)
(define-gsl-root-struct _gsl-root-fsolver-pointer gsl-root-fsolver?)
(define-gsl-root-struct _gsl-root-fdfsolver-type-pointer gsl-root-fdfsolver-type?)
(define-gsl-root-struct _gsl-root-fdfsolver-pointer gsl-root-fdfsolver?)

(define gsl-root-fsolver-free
  (get-ffi-obj 'gsl_root_fsolver_free libgsl
               (_fun _gsl-root-fsolver-pointer -> _void)))
(define gsl-root-fdfsolver-free
  (get-ffi-obj 'gsl_root_fdfsolver_free libgsl
               (_fun _gsl-root-fdfsolver-pointer -> _void)))

(define-syntax define-gsl-roots
  (syntax-rules ()
    ((define-gsl-roots name type)
     (begin
       (provide name)
       (define name
         (get-ffi-obj (regexp-replaces 'name '((#rx"-" "_") (#rx"!" "")))
                      libgsl
                      type))))))

(define-gsl-roots gsl-root-fsolver-alloc
  (_fun _gsl-root-fsolver-type-pointer ->
        (res : _gsl-root-fsolver-pointer) ->
        (begin
          (register-finalizer res gsl-root-fsolver-free)
          res)))
(define-gsl-roots gsl-root-fdfsolver-alloc
  (_fun _gsl-root-fdfsolver-type-pointer ->
        (res : _gsl-root-fdfsolver-pointer) ->
        (begin
          (register-finalizer res gsl-root-fdfsolver-free)
          res)))

(define-gsl-roots gsl-root-fsolver-bisection _gsl-root-fsolver-type-pointer)
(define-gsl-roots gsl-root-fsolver-brent _gsl-root-fsolver-type-pointer)
(define-gsl-roots gsl-root-fsolver-falsepos _gsl-root-fsolver-type-pointer)
(define-gsl-roots gsl-root-fdfsolver-newton _gsl-root-fdfsolver-type-pointer)
(define-gsl-roots gsl-root-fdfsolver-secant _gsl-root-fdfsolver-type-pointer)
(define-gsl-roots gsl-root-fdfsolver-steffenson _gsl-root-fdfsolver-type-pointer)

(define-gsl-roots gsl-root-fsolver-set!
  (_fun _gsl-root-fsolver-pointer _gsl-function-pointer _double* _double* -> _int))
(define-gsl-roots gsl-root-fsolver-iterate!
  (_fun _gsl-root-fsolver-pointer -> _int))
(define-gsl-roots gsl-root-fsolver-name
  (_fun _gsl-root-fsolver-pointer -> _string))
(define-gsl-roots gsl-root-fsolver-x-lower
  (_fun _gsl-root-fsolver-pointer -> _double))
(define-gsl-roots gsl-root-fsolver-x-upper
  (_fun _gsl-root-fsolver-pointer -> _double))

(define-gsl-roots gsl-root-fdfsolver-set!
  (_fun _gsl-root-fdfsolver-pointer _gsl-function-fdf-pointer _double* -> _int))
(define-gsl-roots gsl-root-fdfsolver-iterate!
  (_fun _gsl-root-fdfsolver-pointer -> _int))
(define-gsl-roots gsl-root-fdfsolver-root
  (_fun _gsl-root-fdfsolver-pointer -> _double))

(define-gsl-roots gsl-root-test-interval
  (_fun _double* _double* _double* _double* -> _bool))
(define-gsl-roots gsl-root-test-residual
  (_fun _double* _double* -> _bool))
(define-gsl-roots gsl-root-test-delta
  (_fun _double* _double* _double* _double* -> _bool))
