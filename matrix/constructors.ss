#lang scheme/base

(require "base.ss"
         "comprehensions.ss")

;; v->m : integer integer vector [boolean] -> matrix
;;
;; Creating a matrix by repeating vector rows times in the
;; rows dimension and cols time in the column dimension
;;
;; Assumes the vector is a column vector unless the final
;; optional argument is false
(define (v->m rows cols vector [col? #t])
  (let ([length (vlength vector)])
    (if col?
        (for/fold/matrix () ([r length] [c cols]
                             [elt (in-f64vector vector)])
          elt)
        (for/fold/matrix () ([r rows] [c (* length cols)]
                             [elt (in-f64vector vector)])
          elt))))
