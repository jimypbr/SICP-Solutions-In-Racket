#lang racket
(require sicp)

;; Section 3.3 - Modeling with Mutable Data
;; Exercise 3.12 

(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (append! x y)
  (if (null? x)
      (error "x cannot be empty: APPEND!")
      (set-cdr! (last-pair x) y)))

(module+ test
  (require rackunit)
  (let ((x '(1 2 3 4))
        (y '(5 6 7 8)))
    (append! x y)
    (check-equal? x '(1 2 3 4 5 6 7 8)))
  (let ((x '(1 2 3 4))
        (y '()))
    (append! x y)
    (check-equal? x '(1 2 3 4)))
  (let ((x '())
        (y '(5 6 7 8)))
    (check-exn exn:fail? (λ () (append! x y))))
  (let ((x (list 'a 'b))
        (y (list 'c 'd)))
    (define z (append x y))
    (check-equal? z '(a b c d))
    ;; response 1
    (check-equal? (cdr x) '(b))
    (define w (append! x y))
    ;; response 2
    (check-equal? (cdr x) '(b c d))))

;; Explanation
;; start:
;; x => [a | .] -> [b | /]
;; y => [c | .] -> [d | /]
;; append...
;; z => [a | .] -> [b | .] -> [c | .] -> [d | /]
;; append!...
;; w => [a | .] -> [b | .] -> [c | .] -> [d | /]
;; x => [a | .] -> [b | .] -> [c | .] -> [d | /]
