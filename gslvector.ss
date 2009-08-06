#lang scheme/base

#|  gslvector.ss: High-level GSL vector wrapper

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

(require "low-level/gsl-vector.ss")

(define (make-gslvector l [fill 0])
  (define v (gsl_vector-malloc l))
  (gslvector-fill! v fill)
  v)

(define (gslvector . elts)
  (define l (length elts))
  (define v (make-gslvector l))
  (for ([x (in-list elts)]
        [i (in-naturals)])
       (gslvector-set! v i x))
  v)

(define gslvector? gsl_vector?)
(define gslvector-length gsl_vector-size)

(define gslvector-ref gsl_vector_get)
(define gslvector-set! gsl_vector_set)

(define gslvector-fill! gsl_vector_set_all)

(provide
 make-gslvector
 gslvector
 gslvector?
 gslvector-length

 gslvector-ref
 gslvector-set!

 gslvector-fill!)