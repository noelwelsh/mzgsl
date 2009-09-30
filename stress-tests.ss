#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "matrix.ss"
         "gslvector.ss")

;; These tests are too time consuming to run all the time

(define/provide-test-suite stress-tests

  (test-case
   "pointer integrity test -- matrices"
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
   "memory stress test -- matrices"
   ;; Allocate a million 1M element arrays -- sufficient to trigger
   ;; GC and thereby ensure they are being collected
   ;; correctly
   (for ([i (in-range 100000)])
        (when (zero? (modulo i 10000))
            (printf "Iteration ~a\n" i)
            (collect-garbage))
        (make-vector 1000000)
        (make-matrix 1000 1000)))

  
  (test-case
   "pointer integrity test -- vectors"
   ;; Allocate lots of differnet lengths of vector with
   ;; random sizes. Check we don't segfault trying to access
   ;; elements
   (for ([i (in-range 100000)])
        (let* ([l (add1 (random 399))]
               [v (make-gslvector l 0.0)])
          (for ([i (in-range l)])
               (check-pred zero? (gslvector-ref v i))
               (gslvector-set! v i i)
                (check-= (gslvector-ref v i) i 0.00001))))
   )
  
  (test-case
   "memory stress test -- vectors"
   ;; Allocate a million 1M element vector -- sufficient to trigger
   ;; GC and thereby ensure they are being collected
   ;; correctly
   (for ([i (in-range 100000)])
        (when (zero? (modulo i 10000))
            (printf "Iteration ~a\n" i)
            (collect-garbage))
        (make-vector 1000000)
        (make-gslvector 1000000)))
  )