#lang scheme

(require scheme/foreign
         (planet schematics/schemeunit:3)
         "gsl-roots.ss"
         "gsl-function.ss")

(unsafe!)

(define/provide-test-suite gsl-roots-tests
  (test-case
   "newton-solve sqrt(2)"
   (let ((solver (gsl-root-fdfsolver-alloc gsl-root-fdfsolver-newton))
         (fun (make-gsl-function-fdf
               (lambda (x void) (- (* x x) 2))
               (lambda (x void) (* 2 x))
               (lambda (x void f df)
                 (ptr-set! f _double* (- (* x x) 2))
                 (ptr-set! df _double* (* 2 x))
                 0)
               #f))
         (guess 1))
     (gsl-root-fdfsolver-set! solver fun guess)
     (let ((root (let loop ((last-root guess))
                   (gsl-root-fdfsolver-iterate! solver)
                   (let ((x (gsl-root-fdfsolver-root solver)))
                     (if (gsl-root-test-delta x last-root 1e-8 1e-8)
                         x
                         (loop x))))))
       (check-true (< (abs (- (* root root) 2)) 1e-8)))))
  )