#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "matrix.ss"
         "linear-algebra.ss")

(define e 0.00001)

(define/provide-test-suite linear-algebra-tests
  (test-case
   "matrix-cholesky!"
   (let ([m (make-matrix 3 3)])
     ;; This matrix is pre-calculated to be
     ;;
     ;; 1         1 2 3
     ;; 2 4    x    4 5 
     ;; 3 5 6         6 

     (matrix-set! m 0 0 1.0)
     (matrix-set! m 0 1 2.0)
     (matrix-set! m 0 2 3.0)

     (matrix-set! m 1 0 2.0)
     (matrix-set! m 1 1 20.0)
     (matrix-set! m 1 2 26.0)

     (matrix-set! m 2 0 3.0)
     (matrix-set! m 2 1 26.0)
     (matrix-set! m 2 2 70.0)

     (matrix-cholesky! m)

     (check-= (matrix-ref m 0 0) 1 e)
     (check-= (matrix-ref m 0 1) 2 e)
     (check-= (matrix-ref m 0 2) 3 e)
     
     (check-= (matrix-ref m 1 0) 2 e)
     (check-= (matrix-ref m 1 1) 4 e)
     (check-= (matrix-ref m 1 2) 5 e)

     (check-= (matrix-ref m 2 0) 3 e)
     (check-= (matrix-ref m 2 1) 5 e)
     (check-= (matrix-ref m 2 2) 6 e)))

  (test-case
   "matrix-cholesky! checks for square matrix"
   (let ([m (make-matrix 2 4)])
     (check-exn exn:fail:contract?
                (lambda () (matrix-cholesky! m)))))
  )