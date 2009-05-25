#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "matrix.ss")

;; These tests are too time consuming to run all the time

(define/provide-test-suite stress-tests

  (test-case
   "pointer integrity test"
   ;; Allocate lots of differnet shapes of matrix with
   ;; random sizes. Check we don't segfault trying to access
   ;; elements
   (for ([i (in-range 1000)])
        (let* ([r (add1 (random 19))]
               [c (add1 (random 19))]
               [m (make-matrix r c 0.0)])
          (for* ([i (in-range r)]
                 [j (in-range c)])
                (check-pred zero? (matrix-ref m i j))
                (matrix-set! m i j (* i j))
                (check-= (matrix-ref m i j) (* i j) 0.00001))))
   )
  
  (test-case
   "memory stress test"
   ;; Allocate a million 1M element arrays -- sufficient to trigger
   ;; GC and thereby ensure they are being collected
   ;; correctly
   (for ([i (in-range 1000000)])
        (when (zero? (modulo i 10000))
            (printf "Iteration ~a\n" i))
        (make-matrix 1000 1000)))
  )