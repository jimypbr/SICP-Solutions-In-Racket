#lang racket

;; Exercise 3.03 -- make account with password protection!

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (check-password p)
    (eq? password p))
  (define (dispatch p m)
    (if (check-password p)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "unknown request: MAKE-ACCOUNT"
                           m)))
        (lambda (_) "Incorrect password")))
  dispatch)

(module+ test
  (require rackunit)
  (define acc (make-account 100 'secret-password))
  (check-equal? ((acc 'secret-password 'withdraw) 50) 50)
  (check-equal? ((acc 'asdf 'withdraw) 1000000) "Incorrect password"))
