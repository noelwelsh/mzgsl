#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "linear-algebra-test.ss"
         "gslvector-test.ss"
         "linear-least-squares-test.ss"
         (prefix-in ll: "low-level/all-tests.ss")
         (prefix-in m: "matrix/all-tests.ss"))

(define/provide-test-suite all-tests
  linear-algebra-tests
  gslvector-tests
  linear-least-squares-tests
  ll:all-tests
  m:all-tests
  )