#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "matrix.ss")

;; These tests are too time consuming to run all the time

(define/provide-test-suite stress-tests

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