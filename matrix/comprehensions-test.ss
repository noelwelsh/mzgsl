#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "base.ss"
         "comprehensions.ss")

(define/provide-test-suite comprehensions-tests

  (test-case
   "for/fold/matrix"
   (check
    matrix=
    (for/fold/matrix () ([(r c) 3 2]) 1)
    (make-matrix 3 2 1))

   (check
    matrix=
    (for/fold/matrix () ([(r c) 3 2] [i (in-range 6)]) i)
    (matrix 3 2 0 1 2 3 4 5))

   (let-values (([lst m]
                 (for/fold/matrix ([lst null])
                                  ([(r c) 3 2] [i (in-range 6)])
                   (values (cons i lst)
                           i))))
     (check-equal? lst (list 5 4 3 2 1 0))
     (check matrix= m (matrix 3 2 0 1 2 3 4 5))))

  (test-case
   "in-matrix"
   (check-equal? (for/list ([v (in-matrix (make-matrix 3 2))]) v)
                 (list 0. 0. 0. 0. 0. 0.))
   (check-equal? (for/list ([v (in-matrix (matrix 3 2 0 1 2 3 4 5))]) v)
                 (list 0. 1. 2. 3. 4. 5.))
   (check-equal? (for/list ([(r c v) (in-matrix (matrix 3 2 0 1 2 3 4 5))])
                           (+ r c))
                 (list 0 1 1 2 2 3)))
                 
;;   (test-case
;;    "for/fold/matrix-colsi"
;;    (check matrix=
;;           (for/fold/matrix-colsi
;;            (5 4) (c (in-range 3 -1 -1)) () ()
;;            (vector 0 1 2 3 4))
;;           (matrix 5 4
;;                   0 1 2 3 4
;;                   0 1 2 3 4
;;                   0 1 2 3 4
;;                   0 1 2 3 4)
;;              0.00001)
;;    (check matrix=
;;           (for/fold/matrix-colsi
;;            (5 4) (x (in-range 3 -1 -1)) ([a 0]) ([c (in-range 4)])
;;            (values
;;             (vector (+ c a) (+ c a 1) (+ c a 2) (+ c a 3) (+ c a 4))
;;             (add1 a)))
;;           (matrix 5 4
;;                   6 7 8 9 10
;;                   4 5 6 7 8
;;                   2 3 4 5 6                     
;;                   0 1 2 3 4)
;;           0.00001))

;;   (test-case
;;    "for/fold/matrix-rows"
;;    (check matrix=
;;           (for/fold/matrix-rows (5 4) () ()
;;                                 (v 0 1 2 3))
;;              (matrix 5 4
;;                      0 0 0 0 0
;;                      1 1 1 1 1
;;                      2 2 2 2 2
;;                      3 3 3 3 3)
;;              0.00001)
;;    (check matrix=
;;           (for/fold/matrxi-rows (5 4) ([a 0]) ([r (in-range 5)])
;;                                 (values
;;                                  (vector (+ r a) (+ r a 1) (+ r a 2) (+ r a 3))
;;                                  (add1 a)))
;;           (m 5 4
;;              0 2 4 6 8
;;              1 3 5 7 9
;;              2 4 6 8 10
;;              3 5 7 9 11)
;;           0.00001))
  )
