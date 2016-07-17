#lang racket
(require sicp)

(define (half-adder a b s c)
  (let ((d (make-wire))
        (c (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))

(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire))
        (c1 (make-wire))
        (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))


(define (ripple-carry-adder as bs ss c)
  (define (iter as bs ss c result)
    (let ((c-out (make-wire)))
      (if (nil? (cdr as))
          result
          (else (cons result (half-adder (car as) (car bs) c c-cout))
                (iter (cdr as) (cdr bs) (cdr ss) c-out)))))
  (iter as bs ss c '())
  'ok)

