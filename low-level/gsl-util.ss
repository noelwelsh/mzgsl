#lang scheme/base

(require scheme/foreign
         "gsl-lib.ss")

(unsafe!)

(define-syntax define-gsl
  (syntax-rules ()
    [(define-gsl name type)
     (define name
       (get-ffi-obj
        (symbol->string (quote name))
        libgsl
        type))]))

(provide define-gsl)