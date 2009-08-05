#lang scheme

#|  gsl-rng.ss: Wraps gsl random number generators.
    Copyright (C) 2008 Will M. Farr <farr@mit.edu>

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
         "gsl-lib.ss")


(define-cstruct _gsl-function
  ((function (_fun _double _pointer -> _double))
   (params _pointer)))

(define-cstruct _gsl-function-fdf
  ((f (_fun _double* _pointer -> _double*))
   (df (_fun _double* _pointer -> _double*))
   (f-df (_fun _double* _pointer _pointer _pointer -> _void))
   (params _pointer)))


(provide (all-defined-out))