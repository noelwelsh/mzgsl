#lang scheme/base

#| 
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


(require (planet schematics/schemeunit:3/test)
         "linear-least-squares.ss"
         "matrix.ss"
         "gslvector.ss")

(define e 0.00001)

(define/provide-test-suite linear-least-squares-tests
  (test-case
   "least-squares-multiparameter fits line exactly"
   ;; Points are (1, -1) (4, 11) (-1, -9) (-2, -13)
   ;; which exactly fit the line y = 4x -5
   (define x (matrix 4 2  1 1  4 1  -1 1  -2 1))
   (define y (gslvector -1 11 -9 -13))
   (define-values (c cov chi) (least-squares-multiparameter x y))
   (check-equal? (gslvector-length c) 2)
   (check-= (gslvector-ref c 0) 4 e)
   (check-= (gslvector-ref c 1) -5 e))

  (test-case
   "solve fits line exactly"
   (define x (matrix 4 2  1 1  4 1  -1 1  -2 1))
   (define y (vector -1 11 -9 -13))
   (define c (solve x y))
   (check-= (vector-ref c 0) 4 e)
   (check-= (vector-ref c 1) -5 e))
   
  )