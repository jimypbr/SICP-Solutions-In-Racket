#lang racket
(require sicp)

;; Define an or-gate as a primitive function box.
;; This code is hypothetical and so won't run

(define (logical-or x y)
  (cond ((= x 1) 1)
        ((= y 1) 1)
        ((and (= y 0) (= x 0)) 0)
        (else (error "Invalid signals " x y))))

(define (or-gate o1 o2 output)
  (define (or-action-procedure)
    (let ((new-value
           (logical-or (get-signal o1) (get-signal o2))))
      (after-delay
       or-gate-delay
       (lambda () (set-signal! output new-value)))))
  (add-action! o1 or-action-procedure)
  (add-action! o2 or-action-procedure)
