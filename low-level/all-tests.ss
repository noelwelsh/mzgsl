#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "gsl-matrix-test.ss"
         "gsl-linear-algebra-test.ss"
         "ffi-types-test.ss")

(define/provide-test-suite all-tests
  gsl-matrix-tests
  gsl-linear-algebra-tests
  ffi-types-tests
  )