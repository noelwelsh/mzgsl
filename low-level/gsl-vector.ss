#lang scheme/base

#|  gsl-vector.ss: Wrapper around GSL vector data type

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


(require scheme/foreign
         "gsl-util.ss")

(unsafe!)

;;; Type definitions

(define-cstruct _gsl_vector
  ([size   _size_t]
   [stride _size_t]
   [data   _pointer]
   [block  _pointer]
   [owner  _int]))

;;; Useful functions

(define (gsl_vector-malloc n)
  (define ptr (malloc _double n))
  (define m (make-gsl_vector n 1 ptr #f 0))
  m)

;;; GSL API

;; Constructors

(define-gsl-unchecked (gsl_vector_alloc _size_t -> _gsl_vector-pointer))

(define-gsl-unchecked (gsl_vector_calloc _size_t -> _gsl_vector-pointer))

(define-gsl-unchecked (gsl_vector_free _gsl_vector-pointer -> _void))

;; Accessors and mutators

(define-gsl-unchecked (gsl_vector_get _gsl_vector-pointer _size_t -> _double))

(define-gsl-unchecked (gsl_vector_set _gsl_vector-pointer _size_t _double* -> _void))

(define-gsl-unchecked (gsl_vector_set_all _gsl_vector-pointer _double* -> _void))

(define-gsl-unchecked (gsl_vector_set_zero _gsl_vector-pointer -> _void))

(define-gsl (gsl_vector_set_basis _gsl_vector-pointer _size_t))

;; Copying

(define-gsl (gsl_vector_memcpy _gsl_vector-pointer _gsl_vector-pointer))

(define-gsl (gsl_vector_swap _gsl_vector-pointer _gsl_vector-pointer))

;; Exchanging

(define-gsl (gsl_vector_swap_elements _gsl_vector-pointer _size_t _size_t))

(define-gsl (gsl_vector_reverse _gsl_vector-pointer))

;; Vector operations

(define-gsl (gsl_vector_add _gsl_vector-pointer _gsl_vector-pointer))

(define-gsl (gsl_vector_sub _gsl_vector-pointer _gsl_vector-pointer))

(define-gsl (gsl_vector_mul _gsl_vector-pointer _gsl_vector-pointer))

(define-gsl (gsl_vector_div _gsl_vector-pointer _gsl_vector-pointer))

(define-gsl (gsl_vector_scale _gsl_vector-pointer _double*))

(define-gsl (gsl_vector_add_constant _gsl_vector-pointer _double*))

;; TODO
;; Reading and writing
;; Finding min and max elements
;; Vector properties

(provide
  _gsl_vector
  _gsl_vector-pointer
  _gsl_vector-pointer/null
  gsl_vector-tag
  make-gsl_vector
  gsl_vector?
  gsl_vector-size
  gsl_vector-stride
  gsl_vector-data
  gsl_vector-block
  gsl_vector-owner

  gsl_vector-malloc
  
  gsl_vector_alloc
  gsl_vector_calloc
  gsl_vector_free

  gsl_vector_get
  gsl_vector_set

  gsl_vector_set_all
  gsl_vector_set_zero
  gsl_vector_set_basis

  gsl_vector_memcpy
  gsl_vector_swap

  gsl_vector_swap_elements
  gsl_vector_reverse

  gsl_vector_add
  gsl_vector_sub
  gsl_vector_mul
  gsl_vector_div
  gsl_vector_scale
  gsl_vector_add_constant)
  
 

