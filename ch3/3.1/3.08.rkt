#lang racket

;; Exercise 3.08: concerning order of evalulation and the assignment operator

;; design function f such that:
;; (+ (f 0) (f 1)) => 0 if left->right eval
;; (+ (f 0) (f 1)) => 1 if right->left eval

(define y -1)

(define (f x)
  (if (= y -1)
      (begin (set! y x)
             y)
      0))

(+ (f 0) (f 1))
