#lang scheme/base

(require (for-syntax scheme/base)
         scheme/foreign
         "gsl-lib.ss")

(unsafe!)

;; (define-gsl name type ... -> type)
;;
;; Define a GSL function that does not have its return value
;; (if any) checked for possible error
(define-syntax (define-gsl-unchecked stx)
  (syntax-case* stx (->) free-identifier=?
    [(define-gsl-unchecked (name type ... -> return-type))
     #'(define name
         (get-ffi-obj
          (symbol->string (quote name))
          libgsl
          (_fun type ... -> return-type)))]))


;; (define-gsl name type ...)
;;
;; Define a normal GSL function returning an _int error code
;; which we check for an error
(define-syntax (define-gsl stx)
  (syntax-case stx ()
    [(define-gsl (name type ...))
     (with-syntax ([(param ...) (generate-temporaries #'(type ...))])
       #'(define (name param ...)
           (define unchecked-name
             (get-ffi-obj
              (symbol->string (quote name))
              libgsl
              (_fun type ... -> _int)))
             (define result (unchecked-name param ...))
             (unless (zero? result)
               (let ([reason (bytes->string/utf-8 (gsl_strerror result))])
                 (raise
                  (make-exn:fail
                   reason
                   (current-continuation-marks)))))))]))


(define-gsl-unchecked (gsl_strerror _int -> _bytes))
(define-gsl-unchecked (gsl_set_error_handler_off -> _pointer))

;; We do our own error handling, either via contracts or by
;; checking the return values of all functions. Thus we
;; don't need error handling and turn it off (as recommended
;; by the GSL documentation). We need this to occur globally
;; before any GSL functions are called, so we do it here.
(gsl_set_error_handler_off)

(provide define-gsl-unchecked
         define-gsl)