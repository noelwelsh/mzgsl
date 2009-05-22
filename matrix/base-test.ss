#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         srfi/26/cut
         "base.ss")

(define e 0.00001)

(define/provide-test-suite base-tests

  (test-case
   "matrix-ref raises contract error when r or c outside domain"
   (let ([m (make-matrix 4 3)])
     (check-exn exn:fail:contract?
                (lambda () (matrix-ref m 3 4)))
     (check-exn exn:fail:contract?
                (lambda () (matrix-ref m 5 2)))))

  (test-case
   "matrix-set! raises contract error when r or c outside domain"
   (let ([m (make-matrix 4 3)])
     (check-exn exn:fail:contract?
                (lambda () (matrix-set! m 3 4 0.0)))
     (check-exn exn:fail:contract?
                (lambda () (matrix-set! m 5 2 0.0)))))

  (test-case
   "matrix-set! raises contract error when value outside domain"
   (let ([m (make-matrix 4 3)])
     (check-exn exn:fail:contract?
                (lambda () (matrix-set! m 3 4 #f)))))
  
  (test-case
   "matrix-set-upper-triangle!"
   (let ([m (make-matrix 10 10)])
     (matrix-set-upper-triangle! m 5)
     ;; Check upper triangle is 5
     (for* ([i (in-range 10)]
            [j (in-range (add1 i) 10)])
           (check-= (matrix-ref m i j) 5.0 e))
     ;; Check lower triangle and diagonal are not 5
     (for* ([i (in-range 10)]
            [j (in-range 0 i)])
           (with-check-info
            (['message (format "Element at <~a,~a>" i j)])
            (check-pred (lambda (x) (not (= x 5.0))) (matrix-ref m i j))))))

  (test-case
   "matrix= with epsilon"
   (check (cut matrix= <> <> 0.1)
          (matrix 2 2 1    2    3    4)
          (matrix 2 2 1.09 1.91 2.99 4.05)))

  (test-case
   "matrix="
   (check matrix= (matrix 2 2 1 2 3 4) (matrix 2 2 1 2 3 4))
   (check-false (matrix= (matrix 2 2 1 2 3 4) (matrix 2 2 0 2 3 4)))
   (check-false (matrix= (matrix 2 2 1 2 3 4) (matrix 2 2 1 0 3 4)))
   (check-false (matrix= (matrix 2 2 1 2 3 4) (matrix 2 2 1 2 0 4)))
   (check-false (matrix= (matrix 2 2 1 2 3 4) (matrix 2 2 1 2 3 0))))



  )