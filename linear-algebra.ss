#lang scheme/base

(require "low-level/gsl-linear-algebra.ss")

;;; API

(define matrix-cholesky! gsl_linalg_cholesky_decomp)
(define matrix-cholesky-invert! gsl_linalg_cholesky_invert)

(provide
 matrix-cholesky!
 matrix-cholesky-invert!)