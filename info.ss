#lang setup/infotab

#|  info.ss: Info file for mzgsl collection.
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

(define name "mzgsl")
(define blurb
  (list "Bindings to the GNU Scientific Library for MzScheme.  See the Science collection for native MzScheme libraries which implement much of this functionality."))

(define primary-file "main.ss")
(define scribblings '(("mzgsl.scrbl" ())))

(define release-notes '((p "Initial version of library, including Will Farr's mzgsl bindings")))

(define categories '(scientific datastructures))
(define can-be-loaded-with 'all)
(define repositories '("4.x"))