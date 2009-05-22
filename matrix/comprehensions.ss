#lang scheme/base

(require (for-syntax scheme/base)
         "base.ss"
         "../low-level/gsl-matrix.ss")

(define-syntax (for/fold/matrix stx)
  (syntax-case stx ()
    [(for/fold/matrix
      ([accum-id init-expr] ...)
      ([(r-idx c-idx) rows cols] for-clause ...)
      body ...)

     (syntax
      (let*-values (([m-id] (make-matrix rows cols))
                    ([r-idx] 0)
                    ([c-idx] 0)
                    ([r-limit] rows)
                    ([c-limit] cols)
                    ([accum-id ...]
                     (for/fold/derived stx
                         ([accum-id init-expr] ...)
                         ([_ (in-range (* rows cols))]
                          for-clause ...)
                         
                         (let-values (([accum-id ... matrix-val]
                                       (begin body ...)))
                           (matrix-set! m-id r-idx c-idx matrix-val)
                           (set! c-idx (add1 c-idx))
                           (when (eq? c-idx c-limit)
                             (set! c-idx 0)
                             (set! r-idx (add1 r-idx)))
                           (values accum-id ...)))))
            (values accum-id ... m-id)))]))

(define for/fold/matrix-cols #f)
(define for/fold/matrix-rows #f)
(define for/fold/matrix-colsi #f)
(define for/fold/matrix-rowsi #f)


(define (*in-matrix m)
  (define limit (* (matrix-rows m) (matrix-cols m)))
  (make-do-sequence
   (lambda ()
     (values 
      (lambda (offset) (gsl_matrix-unsafe-ref m offset))
      add1
      0
      (lambda (k) (< k limit))
      (lambda (elt) #t)
      (lambda (k elt) #t)))))

(define-sequence-syntax in-matrix
  (lambda () (syntax *in-matrix))
  (lambda (stx)
    (syntax-case stx ()
      (((id) (_ matrix-expr))
       (syntax/loc stx
         ((i j id) (in-matrix matrix-expr))))
      (((i-id j-id elt-id) (_ matrix-expr))
       (syntax/loc stx
         ((i-id j-id elt-id)
          (:do-in 
           (((m) matrix-expr)) ;Outer bindings.
           #t ; Outer check
           ((i-id 0) (j-id 0) (rows (matrix-rows m)) (cols (matrix-cols m))) ;Loop id
           (< i-id rows) ; Pos-guard
           (((ip1) (add1 i-id)) ((jp1) (add1 j-id)) ((elt-id) (matrix-ref m i-id j-id))) ; Inner-id.
           #t ; Pre-guard
           #t ; Post-guard
           ((if (>= jp1 cols) ip1 i-id) (if (>= jp1 cols) 0 jp1) rows cols))))))))


(provide
 for/fold/matrix
 for/fold/matrix-cols
 for/fold/matrix-rows
 for/fold/matrix-colsi
 for/fold/matrix-rowsi
 in-matrix)

