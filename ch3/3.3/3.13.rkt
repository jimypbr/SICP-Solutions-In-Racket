#lang racket
(require sicp)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (append! x y)
  (if (null? x)
      (error "x cannot be empty: APPEND!")
      (set-cdr! (last-pair x) y)))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)

(make-cycle '(1 2))

;; executing last-pair on a cyclic list will result in an infinite loop
;; Box model of make-cycle
;; z => [a | .] -> [b | .] -> [c | .]
;;       |<------------------------|

