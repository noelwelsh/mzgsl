#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "gsl-matrix-test.ss"
         "gsl-linear-algebra-test.ss"
         "gsl-roots-test.ss"
         "ffi-types-test.ss")

(define/provide-test-suite all-tests
  gsl-matrix-tests
  gsl-linear-algebra-tests
  gsl-roots-tests
  ffi-types-tests
  )