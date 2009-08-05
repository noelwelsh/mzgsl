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


(require (lib "foreign.ss")
         "gsl-lib.ss")

(unsafe!)

(provide gsl-rng-type? gsl-rng? _gsl-rng-type-pointer _gsl-rng-pointer _gsl-rng-state-pointer
         gsl-rng-state? gsl-rng-state-set!)

(define *gsl-rng-state-tag* (gensym 'gsl-rng-state-tag))
(define _gsl-rng-state-pointer (_cpointer *gsl-rng-state-tag*))
(define (gsl-rng-state? obj)
  (and (cpointer? obj)
       (cpointer-has-tag? obj *gsl-rng-state-tag*)))

(define-cstruct _gsl-rng-type
  ((name _string*/utf-8)
   (max _ulong)
   (min _ulong)
   (size _ulong)
   (set _fpointer)
   (get _fpointer)
   (get-double _fpointer)))

(define-cstruct _gsl-rng
  ((type _gsl-rng-type-pointer)
   (struct-state _gsl-rng-state-pointer)))

(define-syntax define-gsl-rng
  (syntax-rules ()
    ((define-gsl-rng name type)
     (begin (provide name)
            (define name
              (get-ffi-obj (regexp-replaces 'name '((#rx"-" "_") (#rx"!" "")))
                           libgsl type))))))

(define-gsl-rng gsl-rng-borosh13 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-coveyou _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-cmrg _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-fishman18 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-fishman20 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-fishman2x _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-gfsr4 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-knuthran _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-knuthran2 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-knuthran2002 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-lecuyer21 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-minstd _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-mrg _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-mt19937 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-mt19937-1999 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-mt19937-1998 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-r250 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ran0 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ran1 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ran2 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ran3 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-rand _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-rand48 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random128-bsd _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random128-glibc2 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random128-libc5 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random256-bsd _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random256-glibc2 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random256-libc5 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random32-bsd _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random32-glibc2 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random32-libc5 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random64-bsd _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random64-glibc2 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random64-libc5 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random8-bsd _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random8-glibc2 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random8-libc5 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random-bsd _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random-glibc2 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-random-libc5 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-randu _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ranf _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ranlux _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ranlux389 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ranlxd1 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ranlxd2 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ranlxs0 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ranlxs1 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ranlxs2 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-ranmar _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-slatec _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-taus _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-taus2 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-taus113 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-transputer _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-tt800 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-uni _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-uni32 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-vax _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-waterman14 _gsl-rng-type-pointer)
(define-gsl-rng gsl-rng-zuf _gsl-rng-type-pointer)

; Defined specially so it won't be exported!  
; We don't want people fucking up the memory management.
(define gsl-rng-free
  (get-ffi-obj 'gsl_rng_free libgsl
               (_fun _gsl-rng-pointer -> _void)))

(define-gsl-rng gsl-rng-alloc (_fun _gsl-rng-type-pointer -> (rng : _gsl-rng-pointer)
                                    -> (begin (register-finalizer rng gsl-rng-free)
                                              rng)))
(define-gsl-rng gsl-rng-memcpy (_fun _gsl-rng-pointer _gsl-rng-pointer -> _int))
(define-gsl-rng gsl-rng-clone (_fun _gsl-rng-pointer -> (rng : _gsl-rng-pointer)
                                    -> (begin (register-finalizer rng gsl-rng-free)
                                              rng)))

(define-gsl-rng gsl-rng-set! (_fun _gsl-rng-pointer _ulong -> _void))
(define (gsl-rng-state-set! rng state)
  (set-gsl-rng-struct-state! rng state))
(define-gsl-rng gsl-rng-max (_fun _gsl-rng-pointer -> _ulong))
(define-gsl-rng gsl-rng-min (_fun _gsl-rng-pointer -> _ulong))
(define-gsl-rng gsl-rng-name (_fun _gsl-rng-pointer -> _string*/utf-8))

(define-gsl-rng gsl-rng-size (_fun _gsl-rng-pointer -> _ulong))
(define-gsl-rng gsl-rng-state (_fun _gsl-rng-pointer -> _gsl-rng-state-pointer))

(define-gsl-rng gsl-rng-get (_fun _gsl-rng-pointer -> _ulong))
(define-gsl-rng gsl-rng-uniform (_fun _gsl-rng-pointer -> _double))
(define-gsl-rng gsl-rng-uniform-pos (_fun _gsl-rng-pointer -> _double))
(define-gsl-rng gsl-rng-uniform-int (_fun _gsl-rng-pointer _ulong -> _ulong))