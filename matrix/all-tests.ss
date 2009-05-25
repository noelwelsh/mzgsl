#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "base-test.ss"
         "comprehensions-test.ss"
         "constructors-test.ss"
         "blas-test.ss"
         "general-test.ss")

(define/provide-test-suite all-tests
  base-tests
  comprehensions-tests
  constructors-tests
  blas-tests
  general-tests)
