#lang racket

;; Exercise 3.1 - make an accumulator procedure.

;; example function
(define (square x)
  (* x x))

(define (make-accumulator acc)
  (lambda (x)
    (begin (set! acc (+ acc x))
           acc)))

(module+ test
 (require rackunit) 
 (define A (make-accumulator 5))
 (check-equal? (square 3) 9 "square test")
 (check-equal? (A 10) 15)
 (check-equal? (A 10) 25))




