#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "matrix-test.ss"
         "linear-algebra-test.ss"
         (prefix-in ll: "low-level/all-tests.ss"))

(define/provide-test-suite all-tests
  matrix-tests
  linear-algebra-tests
  ll:all-tests
  )