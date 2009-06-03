#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "matrix.ss"
         "permutations.ss"
         "linear-algebra.ss")

(define e 0.00001)

(define m (make-matrix 3 3))

;; This matrix is pre-calculated to be
;;
;; 1         1 2 3
;; 2 4    x    4 5 
;; 3 5 6         6 
(define (initialise-m!)
  (matrix-set! m 0 0 1.0)
  (matrix-set! m 0 1 2.0)
  (matrix-set! m 0 2 3.0)

  (matrix-set! m 1 0 2.0)
  (matrix-set! m 1 1 20.0)
  (matrix-set! m 1 2 26.0)
  
  (matrix-set! m 2 0 3.0)
  (matrix-set! m 2 1 26.0)
  (matrix-set! m 2 2 70.0))


(define/provide-test-suite linear-algebra-tests
  (test-case
   "matrix-cholesky!"
   (initialise-m!)
   (matrix-cholesky! m)
   
   (check-= (matrix-ref m 0 0) 1 e)
   (check-= (matrix-ref m 0 1) 2 e)
   (check-= (matrix-ref m 0 2) 3 e)
   
   (check-= (matrix-ref m 1 0) 2 e)
   (check-= (matrix-ref m 1 1) 4 e)
   (check-= (matrix-ref m 1 2) 5 e)
   
   (check-= (matrix-ref m 2 0) 3 e)
   (check-= (matrix-ref m 2 1) 5 e)
   (check-= (matrix-ref m 2 2) 6 e))

  (test-case
   "matrix-cholesky! checks for square matrix"
   (let ([m (make-matrix 2 4)])
     (check-exn exn:fail:contract?
                (lambda () (matrix-cholesky! m)))))

  (test-case
   "matrix-cholesky-invert!"
   (initialise-m!)
   (let ([m2 (matrix-copy m)]
         [id (make-matrix 3 3)])
     (matrix-identity! id)
     (matrix-cholesky! m2)
     (matrix-cholesky-invert! m2)
     (check-matrix= (matrix-product m2 m) id e)))

  (test-case
   "matrix-cholesky and matrix-cholesky-invert"
   (initialise-m!)
   (let* ([ch (matrix-cholesky m)]
          [id (make-matrix 3 3)]
          [inv (matrix-cholesky-invert ch)])
     (matrix-identity! id)
     (check-matrix= (matrix-product inv m) id e)))

  (test-case
   "matrix-cholesky-determinant"
   (initialise-m!)
   (matrix-cholesky! m)
   (check-= (matrix-cholesky-determinant m) (* 1 4 6 1 4 6) e))

  (test-case
   "matrix-lu!"
   (define p (make-permutation (matrix-rows m)))
   (define s (box 0))
   (initialise-m!)
   (matrix-lu! m p s)
   (check-eq? (unbox s) 1)
   ;; Comparing against output from Matlab
   (check-= (matrix-ref m 0 0) 3 e)
   (check-= (matrix-ref m 0 1) 26 e)
   (check-= (matrix-ref m 0 2) 70 e)
   
   (check-= (matrix-ref m 1 0) 1/3 e)
   (check-= (matrix-ref m 1 1) -20/3 e)
   (check-= (matrix-ref m 1 2) -61/3 e)
   
   (check-= (matrix-ref m 2 0) 2/3 e)
   (check-= (matrix-ref m 2 1) -4/10 e)
   (check-= (matrix-ref m 2 2) -28.8 e))

  (test-case
   "matrix-lu-invert!"
   (define p (make-permutation (matrix-rows m)))
   (define s (box 0))
   (define i (make-matrix (matrix-rows m) (matrix-rows m)))
   (define id (make-matrix (matrix-rows m) (matrix-rows m)))
   (matrix-identity! id)
   (initialise-m!)
   (matrix-lu! m p s)
   (matrix-lu-invert! m p i)
   (initialise-m!)
   (check-matrix= (matrix-product i m) id e))

  (test-case
   "matrix-lu and matrix-lu-invert"
   (initialise-m!)
   (let*-values (([id] (make-matrix (matrix-rows m) (matrix-rows m)))
                 ([lu p s] (matrix-lu m))
                 ([i] (matrix-lu-invert lu p)))
     (check-eq? s 1)
     (matrix-identity! id)
     (check-matrix= (matrix-product i m) id e)))

  (test-case
   "matrix-lu-determinant"
   (initialise-m!)
   (let-values (([lu p s] (matrix-lu m)))
     (check-= (matrix-lu-determinant lu s) (* 1 4 6 1 4 6) e)))

  (test-case
   "matrix-invert"
   (initialise-m!)
   (let ([id (make-matrix (matrix-rows m) (matrix-rows m))]
         [i (matrix-invert m)])
     (matrix-identity! id)
     (check-matrix= (matrix-product i m) id e)))
  )