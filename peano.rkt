#lang racket
(require redex)

(define-language Peano
  (e ::= Z (S e)))

(define-judgment-form Peano
  #:contract (is-nat e)
  [---------- "Z-nat"
   (is-nat Z)]

  [(is-nat e)
   -------------- "S-nat"
   (is-nat (S e))])

(define Z-is-nat
  (derivation
  '(is-nat Z)
  "Z-nat"
  '()))

(define SZ-is-nat
  (derivation
  '(is-nat (S Z))
  "S-nat"
  `(,Z-is-nat)))

(test-judgment-holds is-nat Z-is-nat)
(test-judgment-holds is-nat SZ-is-nat)