#lang scheme/base

#|  linear-least-squares.ss: High level least squares solver interface

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
|#

(require "low-level/gsl-multifit.ss"
         "gslvector.ss"
         "matrix.ss")

;; matrix vector -> vector
(define (solve x y)
  (define-values (c cov chi)
    (least-squares-multiparameter x (vector->gslvector y)))
  (gslvector->vector c))

;; matrix gslvector -> (values gslvector matrix number) 
(define (least-squares-multiparameter x y)
  (define n (matrix-rows x))
  (define p (matrix-cols x))
  (define work (gsl_multifit_linear_alloc n p))
  (define c (make-gslvector p))
  (define cov (make-matrix p p))
  (define chi (box 0.0))

  (gsl_multifit_linear x y c cov chi work)

  (gsl_multifit_linear_free work)
  (values c cov (unbox chi)))


(provide
 least-squares-multiparameter
 solve)