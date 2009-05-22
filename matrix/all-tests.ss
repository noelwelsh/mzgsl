#lang scheme/base

(require (planet schematics/schemeunit:3/test)
         "base-test.ss"
         "comprehensions-test.ss")

(define/provide-test-suite all-tests
  base-tests
  comprehensions-tests)
