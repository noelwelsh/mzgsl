#lang scheme/base

#|  gsl-multifit.ss: Wraps gsl least squares multi-parameter fitting

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
         "gsl-util.ss"
         "gsl-matrix.ss"
         "gsl-vector.ss")

(define _gsl_multifit_linear_workspace _pointer)

;; Allocate working memory for model n observations and p parameters
(define-gsl-unchecked
  (gsl_multifit_linear_alloc _size_t _size_t -> _gsl_multifit_linear_workspace))

(define-gsl-unchecked
  (gsl_multifit_linear_free _gsl_multifit_linear_workspace -> _void))


(define-gsl (gsl_multifit_linear _gsl_matrix-pointer _gsl_vector-pointer _gsl_vector-pointer _gsl_matrix-pointer (_box _double) _gsl_multifit_linear_workspace))

(define-gsl (gsl_multifit_linear_svd _gsl_matrix-pointer _gsl_vector-pointer _double* (_box _size_t) _gsl_vector-pointer _gsl_matrix-pointer (_box _double) _gsl_multifit_linear_workspace))


(provide
 _gsl_multifit_linear_workspace
 gsl_multifit_linear_alloc
 gsl_multifit_linear_free

 gsl_multifit_linear
 gsl_multifit_linear_svd)