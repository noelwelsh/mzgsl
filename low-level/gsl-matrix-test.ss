#lang scheme/base

(require scheme/contract
         (planet schematics/schemeunit:3/test)
         "gsl-matrix.ss")

;; For testing the contracts
(define/contract (matrix-of-length l)
  (->d ([l integer?]) () [_ (-> (gsl_matrix-of-length/c l) any)]) 
  (lambda (m) m))

(define/contract (matrix-of-dimensions r c)
  (->d ([r integer?] [c integer?]) () [_ (-> (gsl_matrix-of-dimensions/c r c) any)])
  (lambda (m) m))

(define/provide-test-suite gsl-matrix-tests

  (test-case
   "gsl-matrix set and get"
   (let ([m (gsl_matrix_calloc 4 4)])
     (after
      (check-equal? (gsl_matrix_get m 2 2) 0.0)
      (gsl_matrix_set m 2 2 10.0)
      (check-equal? (gsl_matrix_get m 2 2) 10.0)

      (gsl_matrix_free m))))

  (test-case
   "gsl_matrix-unsafe-ref"
   (let ([m (gsl_matrix_calloc 4 4)])
     (after
      (check-equal? (gsl_matrix-unsafe-ref m 10) 0.0)
      (gsl_matrix_set m 2 2 10.0)
      (check-equal? (gsl_matrix-unsafe-ref m 10) 10.0)

      (gsl_matrix_free m))))

  (test-case
   "gsl_matrix-of-length/c"
   (let ([m (gsl_matrix_alloc 2 4)])
     (check-exn exn:fail:contract?
                (lambda ()
                  ((matrix-of-length 10) m)))
     (check-not-exn
      (lambda () ((matrix-of-length 8) m)))
     (gsl_matrix_free m)))

  (test-case
   "gsl_matrix-of-dimensions/c"
   (let ([m (gsl_matrix_alloc 2 4)])
     (check-exn exn:fail:contract?
                (lambda ()
                  ((matrix-of-dimensions 4 2) m)))
     (check-not-exn
      (lambda () ((matrix-of-dimensions 2 4) m)))
     (gsl_matrix_free m)))

  (test-case
   "gsl-matrix stores data block correctly"
   (define m (gsl_matrix-malloc 4 4))
   (gsl_matrix_set m 1 1 3.0)
   (check-= (gsl_matrix_get m 1 1) 3.0 0.0)
   ;; Do work forcing a GC
   (for ([i (in-range 10000)])
        (make-vector i))
   (check-= (gsl_matrix_get m 1 1) 3.0 0.0))

  )