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
         "gslvector.ss")

(define e 0.00001)

(define/provide-test-suite gslvector-tests
  (test-case
   "make-gslvector uses zero fill if none provided"
   (define v (make-gslvector 10))
   (for ([i (in-range 10)])
        (check-pred zero? (gslvector-ref v i))))

  (test-case
   "make-gslvector uses provided fill"
   (define v (make-gslvector 10 5.2))
   (for ([i (in-range 10)])
        (check-= (gslvector-ref v i) 5.2 e)))

  (test-case
   "make-gslvector creates vector of correct size"
   (check-equal? (gslvector-length (make-gslvector 15)) 15)
   (check-equal? (gslvector-length (make-gslvector 10)) 10)
   (check-equal? (gslvector-length (make-gslvector 5)) 5))

  (test-case
   "gslvector constructs correct vector"
   (define v (gslvector 0 1 2 3 4 3 2 1))
   (check-equal? (gslvector-length v) 8)
   (check-equal?
    (for/list ([i (in-range 8)])
              (gslvector-ref v i))
    (list 0. 1. 2. 3. 4. 3. 2. 1.)))

  (test-case
   "gslvector-set! mutates correct element"
   (define v (make-gslvector 3))
   (gslvector-set! v 1 5)
   (check-equal?
    (for/list ([i (in-range 3)])
              (gslvector-ref v i))
    (list 0. 5. 0.)))
  )