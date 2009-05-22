#lang scheme/base

(require scheme/contract
         "low-level/gsl-matrix.ss")


;;; API

(define (make-matrix r c [fill 0])
  (define m (gsl_matrix-malloc r c))
  (matrix-fill! m fill)
  m)

(define matrix? gsl_matrix?)
(define matrix-rows gsl_matrix-rows)
(define matrix-cols gsl_matrix-cols)

(define matrix-of-dimensions/c gsl_matrix-of-dimensions/c)

(define matrix-ref gsl_matrix_get)
(define matrix-set! gsl_matrix_set)

(define matrix-fill! gsl_matrix_set_all)
(define matrix-zero! gsl_matrix_set_zero)
(define matrix-identity! gsl_matrix_set_identity)

(define (matrix-set-upper-triangle! m v)
  (define r (matrix-rows m))
  (define c (matrix-cols m))
  (for* ([i (in-range r)]
         [j (in-range (add1 i) c)])
        (matrix-set! m i j v)))
        

(provide
 make-matrix
 matrix?
 matrix-rows
 matrix-cols

 matrix-fill!
 matrix-identity!
 matrix-zero!
 
 matrix-set-upper-triangle!)

(provide/contract
 [matrix-ref (->d ([m matrix?]
                   [i (and/c natural-number/c
                             (</c (matrix-rows m)))]
                   [j (and/c natural-number/c
                             (</c (matrix-cols m)))])
                  ()
                  any)]
 [matrix-set! (->d ([m matrix?]
                    [i (and/c natural-number/c
                              (</c (matrix-rows m)))]
                    [j (and/c natural-number/c
                              (</c (matrix-cols m)))]
                    [x any/c])
                   ()
                   any)])
