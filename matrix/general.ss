#lang scheme/base

(require "../low-level/gsl-matrix.ss"
         "base.ss"
         "constructors.ss")

(define matrix-transpose! gsl_matrix_transpose)
(define (matrix-transpose m)
  (define m2 (matrix-copy m))
  (matrix-transpose! m2)
  m2)

;;; Matrix-matrix elementwise

(define matrix+! gsl_matrix_add)
(define (matrix+ m1 m2)
  (define m3 (matrix-copy m1))
  (matrix+! m3 m2)
  m3)

(define matrix-! gsl_matrix_sub)
(define (matrix- m1 m2)
  (define m3 (matrix-copy m1))
  (matrix-! m3 m2)
  m3)

(define matrix*! gsl_matrix_mul_elements)
(define (matrix* m1 m2)
  (define m3 (matrix-copy m1))
  (matrix*! m3 m2)
  m3)

(define matrix/! gsl_matrix_div_elements)
(define (matrix/ m1 m2)
  (define m3 (matrix-copy m1))
  (matrix/! m3 m2)
  m3)

;;; Matrix-scalar

(define matrix+s! gsl_matrix_add_constant)
(define (matrix+s m s)
  (define m1 (matrix-copy m))
  (matrix+s! m1 s)
  m1)

(define (matrix-s! m s)
  (matrix+s! m (- s)))
(define (matrix-s m s)
  (define m1 (matrix-copy m))
  (matrix-s! m1 s)
  m1)

(define matrix*s! gsl_matrix_scale)
(define (matrix*s m s)
  (define m1 (matrix-copy m))
  (matrix*s! m1 s)
  m1)

(define (matrix/s! m s)
  (matrix*s! m (/ s)))
(define (matrix/s m s)
  (define m1 (matrix-copy m))
  (matrix/s! m1 s)
  m1)

(provide matrix-transpose!
         matrix-transpose

         matrix+!
         matrix+

         matrix-!
         matrix-

         matrix*!
         matrix*

         matrix/!
         matrix/

         matrix+s!
         matrix+s

         matrix-s!
         matrix-s

         matrix*s!
         matrix*s

         matrix/s!
         matrix/s)