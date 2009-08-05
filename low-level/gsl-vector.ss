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

;; Accessors

(define-gsl-unchecked (gsl_vector_get _gsl_vector-pointer _size_t -> _double))

(define-gsl-unchecked (gsl_vector_set _gsl_vector-pointer _size_t _double* -> _void))


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

  gsl_vector_alloc
  gsl_vector_calloc
  gsl_vector_free

  gsl_vector_get
  gsl_vector_set)
  
 

