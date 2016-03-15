#lang racket
(require sicp)

;; Exercise 3.17 -- count pairs properly

(define (count-pairs x)
  (define pairs '())
  (define (iter y)
    (if (pair? y)
        (begin
          (if (not (memq y pairs))
              (set! pairs (cons y pairs)))
          (iter (car y))
          (iter (cdr y)))))
  (iter x)
  (length pairs))


;; Test cases. Should all be 3
(count-pairs (list 1 2 3))

(define foo (cons 'a 'b))
(define bar (cons 'a 'b))
(define baz (cons foo bar))
(set-car! foo bar)
(count-pairs baz)

(define foo1 (cons 'a 'b))
(define bar1 (cons foo1 foo1))
(define baz1 (cons bar1 bar1))
(count-pairs baz1)
