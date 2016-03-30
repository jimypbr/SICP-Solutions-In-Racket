#lang racket
(require sicp)

;; Exercise 3.18 -- detect cycles in a list

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(define (cyclic? x)
  (define pairs '())
  (define (detect y)
    (cond
      ((not (pair? y)) false)
      ((memq y pairs) true)
      (else (set! pairs (cons y pairs))
            (or (detect (car y))
                (detect (cdr y))))))
  (detect x))

(module+ testing
  (require rackunit)
  (let ((xs (make-cycle '(a b c d))))
    (check-equal? #t (cyclic? xs)))
  (let ((xs '(a b c d)))
    (check-equal? #f (cyclic? xs)))
  (check-equal? #f (cyclic? '()))
  (let ((xs (list 'a (make-cycle '(b c d)) 'e)))
    (check-equal? #t (cyclic? xs))))



