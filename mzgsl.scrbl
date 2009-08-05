#lang scribble/doc

@(require scribble/manual
          (for-label scheme)
          (for-label "gsl-rng.ss")
          (for-label "gsl-lib.ss"))

@title{MzGSL: MzScheme Bindings to the GNU Scientific Library}

The @filepath{mzgsl.plt} PLaneT package provides bindings to the
@link["http://www.gnu.org/software/gsl/"]{GNU Scientific Library}.  It
is currently very incomplete: only the random number generators from
the GSL are bound.

You can use the bindings from @filepath{mzgsl.plt} in your programs by
issuing the command @scheme[(require (planet "all.ss" ("wmfarr"
"mzgsl.plt" 3 0)))] or, in shortened notation @scheme[(require (planet
wmfarr/mzgsl:3:0/all))].  The @filepath["all.ss"] module exports all
bindings of the @filepath{mzgsl.plt} package.

The mzgsl.plt package is released under the GPL; see the
@secref["License"] section of this document for more information.
@filepath{mzgsl.plt} is maintained by
@link["mailto:farr@mit.edu"]{Will M. Farr}; send feature requests and
bug reports to that address.

@section[#:tag "FFI-libraries"]{FFI Libraries}

@defmodule[(planet wmfarr/mzgsl:3:0/gsl-lib)]

The system makes a reasonable effort to find the libraries for the GSL
and GSL's CBLAS on your system; if it cannot, report it as a bug, and
I'll add the appropriate code to locate the GSL on your system.

@deftogether[((defthing libgsl any/c) (defthing libgslcblas any/c))]{

ffi-lib objects which point to the corresponding foreign library.

}

@section[#:tag "RNG"]{Random Number Generation}

@defmodule[(planet wmfarr/mzgsl:3:0/gsl-rng)]

The following functions are provided by @filepath["gsl-rng.ss"].  The
naming scheme follows very closely the GSL naming scheme, with
@scheme[_] replaced by @scheme[-], and an @scheme[!] inserted in
@scheme[gsl-rng-set!].  Note also that @scheme[gsl-rng-state-set!] is
provided even though that is not a function in the GSL library.

@subsection[#:tag "RNG:FFI-values"]{Basic FFI Values and Predicates}

@deftogether[
             ((defthing _gsl-rng-type-pointer any/c) 
              (defproc (gsl-rng-type? (obj any/c)) boolean?) 
              (defthing _gsl-rng-pointer any/c)
              (defproc (gsl-rng? (obj any/c)) boolean?)
              (defthing _gsl-rng-state-pointer any/c)
              (defproc (gsl-rng-state? (obj any/c)) boolean?))]{

These are the foreign types and corresponding predicates for objects
from the GSL RNG library.

}

@subsection[#:tag "RNG:types"]{RNG Types}

@deftogether[
             ((defthing gsl-rng-borosh13 gsl-rng-type?)
              (defthing gsl-rng-coveyou gsl-rng-type?)
              (defthing gsl-rng-cmrg gsl-rng-type?)
              (defthing gsl-rng-fishman18 gsl-rng-type?)
              (defthing gsl-rng-fishman20 gsl-rng-type?)
              (defthing gsl-rng-fishman2x gsl-rng-type?)
              (defthing gsl-rng-gfsr4 gsl-rng-type?)
              (defthing gsl-rng-knuthran gsl-rng-type?)
              (defthing gsl-rng-knuthran2 gsl-rng-type?)
              (defthing gsl-rng-knuthran2002 gsl-rng-type?)
              (defthing gsl-rng-lecuyer21 gsl-rng-type?)
              (defthing gsl-rng-minstd gsl-rng-type?)
              (defthing gsl-rng-mrg gsl-rng-type?)
              (defthing gsl-rng-mt19937 gsl-rng-type?)
              (defthing gsl-rng-mt19937-1999 gsl-rng-type?)
              (defthing gsl-rng-mt19937-1998 gsl-rng-type?)
              (defthing gsl-rng-r250 gsl-rng-type?)
              (defthing gsl-rng-ran0 gsl-rng-type?)
              (defthing gsl-rng-ran1 gsl-rng-type?)
              (defthing gsl-rng-ran2 gsl-rng-type?)
              (defthing gsl-rng-ran3 gsl-rng-type?)
              (defthing gsl-rng-rand gsl-rng-type?)
              (defthing gsl-rng-rand48 gsl-rng-type?)
              (defthing gsl-rng-random128-bsd gsl-rng-type?)
              (defthing gsl-rng-random128-glibc2 gsl-rng-type?)
              (defthing gsl-rng-random128-libc5 gsl-rng-type?)
              (defthing gsl-rng-random256-bsd gsl-rng-type?)
              (defthing gsl-rng-random256-glibc2 gsl-rng-type?)
              (defthing gsl-rng-random256-libc5 gsl-rng-type?)
              (defthing gsl-rng-random32-bsd gsl-rng-type?)
              (defthing gsl-rng-random32-glibc2 gsl-rng-type?)
              (defthing gsl-rng-random32-libc5 gsl-rng-type?)
              (defthing gsl-rng-random64-bsd gsl-rng-type?)
              (defthing gsl-rng-random64-glibc2 gsl-rng-type?)
              (defthing gsl-rng-random64-libc5 gsl-rng-type?)
              (defthing gsl-rng-random8-bsd gsl-rng-type?)
              (defthing gsl-rng-random8-glibc2 gsl-rng-type?)
              (defthing gsl-rng-random8-libc5 gsl-rng-type?)
              (defthing gsl-rng-random-bsd gsl-rng-type?)
              (defthing gsl-rng-random-glibc2 gsl-rng-type?)
              (defthing gsl-rng-random-libc5 gsl-rng-type?)
              (defthing gsl-rng-randu gsl-rng-type?)
              (defthing gsl-rng-ranf gsl-rng-type?)
              (defthing gsl-rng-ranlux gsl-rng-type?)
              (defthing gsl-rng-ranlux389 gsl-rng-type?)
              (defthing gsl-rng-ranlxd1 gsl-rng-type?)
              (defthing gsl-rng-ranlxd2 gsl-rng-type?)
              (defthing gsl-rng-ranlxs0 gsl-rng-type?)
              (defthing gsl-rng-ranlxs1 gsl-rng-type?)
              (defthing gsl-rng-ranlxs2 gsl-rng-type?)
              (defthing gsl-rng-ranmar gsl-rng-type?)
              (defthing gsl-rng-slatec gsl-rng-type?)
              (defthing gsl-rng-taus gsl-rng-type?)
              (defthing gsl-rng-taus2 gsl-rng-type?)
              (defthing gsl-rng-taus113 gsl-rng-type?)
              (defthing gsl-rng-transputer gsl-rng-type?)
              (defthing gsl-rng-tt800 gsl-rng-type?)
              (defthing gsl-rng-uni gsl-rng-type?)
              (defthing gsl-rng-uni32 gsl-rng-type?)
              (defthing gsl-rng-vax gsl-rng-type?)
              (defthing gsl-rng-waterman14 gsl-rng-type?)
              (defthing gsl-rng-zuf gsl-rng-type?))]{

The various types of generators provided by the GSL.  

}

@subsection[#:tag "RNG:Functions"]{RNG Functions}

@deftogether[
             ((defproc (gsl-rng-alloc (type gsl-rng-type?)) gsl-rng?)
              (defproc (gsl-rng-memcpy (target gsl-rng?) (source gsl-rng?)) any)
              (defproc (gsl-rng-clone (rng gsl-rng?)) gsl-rng?))]{

Allocating and modifying GSL RNGs.  Note that a @scheme[gsl-rng-free]
procedure is *not* provided by the library; memory management is
automatic in this library.  The alloc and clone functions
automatically register a finalizer for the allocated generator.

}

@deftogether[
             ((defproc (gsl-rng-set! (rng gsl-rng?) (seed integer?)) any)
              (defproc (gsl-rng-state-set! (rng gsl-rng?) (state gsl-rng-state?)) any))]{

Set the internal state of the generator. 

}

@deftogether[
             ((defproc (gsl-rng-max (rng gsl-rng?)) integer?)
              (defproc (gsl-rng-min (rng gsl-rng?)) integer?)
              (defproc (gsl-rng-name (rng gsl-rng?)) string?)
              (defproc (gsl-rng-size (rng gsl-rng?)) integer?))]{

Query the properties of a particular generator.

}

@defproc[(gsl-rng-state (rng gsl-rng?)) gsl-rng-state?]{

Get the internal state of the generator.

}

@deftogether[
             ((defproc (gsl-rng-get (rng gsl-rng?)) integer?)
              (defproc (gsl-rng-uniform (rng gsl-rng?)) real?)
              (defproc (gsl-rng-uniform-pos (rng gsl-rng?)) real?)
              (defproc (gsl-rng-uniform-int (rng gsl-rng) (max integer?)) integer?))]{

Get random numbers from the generator.

}

@section[#:tag "License"]{License}

The @filepath["mzgsl.plt"] package is released under the GPL, Version
3.  You can find a copy of this license in the
@link["../../gpl-3.0.txt"]{main directory} of the package, or
@link["http://www.gnu.org/licenses/gpl.html"]{here}.
