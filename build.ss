#lang scheme/base

(require (planet schematics/sake:1))

(define-task compile
  ()
  (action:compile "all-tests.ss"))

(define-task test
  (compile)
  (action:test "all-tests.ss" 'all-tests))

(define-task stress-test
  (compile)
  (action:test "stress-tests.ss" 'stress-tests))

(define-task all
  (test compile))
  
(define-task default
  (all))


