#lang scheme/base

(require "low-level/gsl-linear-algebra.ss")

;;; API

(define matrix-cholesky! gsl_linalg_cholesky_decomp)

(provide
 matrix-cholesky!)