#lang scheme

#|  gsl-lib.ss: Finds the library file for the gsl.
    Copyright (C) Will M. Farr <farr@mit.edu>

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


(require (lib "foreign.ss")
         (lib "etc.ss"))

(unsafe!)

(provide libgsl libgslcblas)

(define try-paths
  (case (system-type)
    ((macosx)
     (list "/usr/local/lib"
           "/opt/local/lib"
           "/sw/local/lib"))
    (else '())))

(define cblaslibname
  (path-replace-suffix "libgslcblas.xxx" (system-type 'so-suffix)))

(define cblaslibpath
  (or (ormap (lambda (path)
               (let ((full-path (build-path path cblaslibname)))
                 (and (file-exists? full-path)
                      full-path)))
             try-paths)
      cblaslibname))

(define gsllibname
  (path-replace-suffix "libgsl.xxx" (system-type 'so-suffix)))

(define gsllibpath
  (or (ormap (lambda (path)
               (let ((full-path (build-path path gsllibname)))
                 (and (file-exists? full-path)
                      full-path)))
             try-paths)
      gsllibname))

(define libgslcblas (ffi-lib cblaslibpath))
(define libgsl (ffi-lib gsllibpath))