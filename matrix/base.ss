#lang scheme/base

(require scheme/contract
         "../low-level/gsl-matrix.ss")


;;; API

(define (make-matrix r c [fill 0])
  (define m (gsl_matrix-malloc r c))
  (matrix-fill! m fill)
  m)

(define (matrix r c . elts)
  (define l (length elts))
  (unless (= l (* r c))
    (raise-mismatch-error
     'matrix
     (format "Expected ~a elements, but given ~a elements to construct matrix: " (* r c) l)
     elts))
  (let ([m (make-matrix r c)])
    (for*/fold ([elts elts])
               ([i (in-range r)]
                [j (in-range c)])
      (matrix-set! m i j (car elts))
      (cdr elts))
    m))

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

(define (matrix= m1 m2 [e 0.0])
  (define is=
    (if (zero? e)
        =
        (lambda (a b) (<= (abs (- a b)) e))))
  (and (= (matrix-rows m1) (matrix-rows m2))
       (= (matrix-cols m1) (matrix-cols m2))
       (for*/and ([r (in-range (matrix-rows m1))]
                  [c (in-range (matrix-cols m2))])
         (is= (matrix-ref m1 r c)
              (matrix-ref m2 r c)))))

(define (display-matrix m)
  (display "#matrix(")
  (printf "~a ~a " (matrix-rows m) (matrix-cols m))
  (for* ([r (in-range (matrix-rows m))]
         [c (in-range (matrix-cols m))])
       (display " ") (display (matrix-ref m r c)))
  (display ")"))

;; API to implement

;; matrix-map

;; vector->matrix v
;; matrix- m1 m2
;; matrix+ m1 m2
;; matrix* m1 m2
;; matrix/ m1 m2
;; matrix/s m s
;; matrix-s m s
;; matrix+s m s
;; matrix*s m s

;; matrix*v
;; matrix-cols-v
;; matrix-cols*v
;; matrix-cols+v
;; matrix-cols/v

;; matrix-rows*v
;; matrix-rows+v
;; matrix-rows/v
;; matrix-rows-v

;; matrix-sum
;; matrix-rows-sum
;; matrix-cols-sum

;; matrix-row
;; matrix-col
;; matrix-set-col!
;; matrix-set-row!


(provide
 make-matrix
 matrix
 matrix?
 matrix-rows
 matrix-cols
 display-matrix
 
 matrix=
 
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
