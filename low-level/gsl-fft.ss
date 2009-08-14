#lang scheme/base

#|  gsl-fft.ss: Fast fourier transforms

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

(require "gsl-util.ss")

;; _pointers below must be pointers to double. They are
;; defined as just _pointer so the functions can be used
;; with a variety of different data representations.
;;
;; The next two parameters are stride and size
;;
;; Stride the number of double words separating successive
;; elements. It should be 1 for a dense vector
;;
;; Size is the number of elements in the vector

(define-gsl (gsl_fft_real_radix2_transform _pointer _size_t _size_t))
(define-gsl (gsl_fft_halfcomplex_radix2_inverse _pointer _size_t _size_t))
(define-gsl (gsl_fft_halfcomplex_radix2_backward _pointer _size_t _size_t n))

(provide
 gsl_fft_real_radix2_transform
 gsl_fft_halfcomplex_radix2_inverse
 gsl_fft_halfcomplex_radix2_backward)