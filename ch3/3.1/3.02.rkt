#lang racket

;; Exercise 3.2 -- monitor number of calls to a function

(define (make-monitored fn)
  (define count 0)
  (define (number-of-calls)
    count)
  (define (call-fn . args)
    (begin (set! count (+ count 1))
           (apply fn args)))
  (define (reset-count)
    (set! count 0))
  (define (dispatch m)
    (cond ((eq? m 'how-many-calls?) (number-of-calls))
          ((eq? m 'reset-count) (reset-count))
          (else (call-fn m))))
  dispatch)

(define (square x)
  (* x x))

(module+ test
  (require rackunit)
  (define s (make-monitored square))
  (check-equal? (s 100) (square 100))
  (s 2)
  (s 1)
  (check-equal? (s 'how-many-calls?) 3)
  (s 'reset-count)
  (check-equal? (s 'how-many-calls?) 0))
