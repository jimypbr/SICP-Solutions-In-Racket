#lang racket

;; Exercise 3.04 -- make account with password protection and a police siren!

(define (make-account balance password)
  (define password-attempts 0)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (check-password p)
    (let ((valid (eq? password p)))
      (if valid
          (set! password-attempts 0)
          (set! password-attempts (+ password-attempts 1)))
      valid))
  (define (call-the-cops . _)
    (lambda (_) "Calling the cops on you!"))
  (define (dispatch p m)
    (if (check-password p)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "unknown request: MAKE-ACCOUNT"
                           m)))
        (if (< password-attempts 7)
            (lambda (_) "Incorrect password")
            (call-the-cops))))
  dispatch)

(module+ test
  (require rackunit)
  (define acc (make-account 100 'secret-password))
  (check-equal? ((acc 'secret-password 'withdraw) 50) 50)
  (check-equal? ((acc 'asdf 'withdraw) 1000000) "Incorrect password")
  ((acc 'asff 'withdraw) 1000)
  ((acc 'asff 'withdraw) 1000)
  ((acc 'asff 'withdraw) 1000)
  ((acc 'asff 'withdraw) 1000)
  ((acc 'asff 'withdraw) 1000)
  (check-equal? ((acc 'asdf 'withdraw) 1000000) "Calling the cops on you!"))
