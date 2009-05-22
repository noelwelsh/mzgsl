#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         srfi/26/cut
         "matrix.ss")

(define e 0.00001)

(define/provide-test-suite matrix-tests

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
          (m 2 2 1    2    3    4)
          (m 2 2 1.09 1.91 2.99 4.05)))

  (test-case
   "vector->matrix creates correct matrices"
   (check matrix=
          (vector->matrix 2 3 (v 1 2 3))
          (matrix 6 3
                  1 2 3 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3))
   (check matrix= (vector->matrix 1 3 (v 1.7 2.6 3.1))
          (matrix 3 3
                  1.7 2.6 3.1 1.7 2.6 3.1 1.7 2.6 3.1))
   (check matrix=
          (vector->matrix 3 2 (v 1 2 3) #f)
          (matrix 3 6
                  1 1 1 2 2 2 3 3 3 1 1 1 2 2 2 3 3 3)))


  (test-case
   "for/fold/matrix-colsi"
   (check matrix=
          (for/fold/matrix-colsi
           (5 4) (c (in-range 3 -1 -1)) () ()
           (vector 0 1 2 3 4))
          (matrix 5 4
                  0 1 2 3 4
                  0 1 2 3 4
                  0 1 2 3 4
                  0 1 2 3 4)
             0.00001)
   (check matrix=
          (for/fold/matrix-colsi
           (5 4) (x (in-range 3 -1 -1)) ([a 0]) ([c (in-range 4)])
           (values
            (vector (+ c a) (+ c a 1) (+ c a 2) (+ c a 3) (+ c a 4))
            (add1 a)))
          (matrix 5 4
                  6 7 8 9 10
                  4 5 6 7 8
                  2 3 4 5 6                     
                  0 1 2 3 4)
          0.00001))

  (test-case
   "for/fold/matrix-rows"
   (check matrix=
          (for/fold/matrix-rows (5 4) () ()
                                (v 0 1 2 3))
             (matrix 5 4
                     0 0 0 0 0
                     1 1 1 1 1
                     2 2 2 2 2
                     3 3 3 3 3)
             0.00001)
   (check matrix=
          (for/fold/matrxi-rows (5 4) ([a 0]) ([r (in-range 5)])
                                (values
                                 (vector (+ r a) (+ r a 1) (+ r a 2) (+ r a 3))
                                 (add1 a)))
          (m 5 4
             0 2 4 6 8
             1 3 5 7 9
             2 4 6 8 10
             3 5 7 9 11)
          0.00001))
  
  )