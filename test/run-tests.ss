#lang scheme

(require (planet schematics/schemeunit:3)
         (planet schematics/schemeunit:3/text-ui)
         (prefix-in gsl-roots: "gsl-roots-test.ss"))

(define tests
  (test-suite
   "all mzgsl tests"
   gsl-roots:tests))

(run-tests tests)