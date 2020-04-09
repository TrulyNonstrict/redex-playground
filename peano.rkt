#lang racket
(require redex)

(define-language Peano
  (m n ::= Z (S n)))

(define-judgment-form Peano
  #:contract (is-nat n)
  [---------- "Z-nat"
   (is-nat Z)]

  [(is-nat n)
   -------------- "S-nat"
   (is-nat (S n))])

(define-judgment-form Peano
  #:contract (equals n n)
  #:mode (equals I O)
  [------------ "Z-eq"
   (equals Z Z)]

  [(equals m n)
   -------------------- "S-eq"
   (equals (S m) (S n))])

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

(test-judgment-holds (equals Z Z))
(test-judgment-holds (equals (S Z) (S Z)))