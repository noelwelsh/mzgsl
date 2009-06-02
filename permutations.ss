#lang scheme/base

(require "low-level/gsl-permutations.ss")

;;; API

(define make-permutation gsl_permutation-malloc)


(provide
 make-permutation)