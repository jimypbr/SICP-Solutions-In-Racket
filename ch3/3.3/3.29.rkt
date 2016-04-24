#lang racket
(require sicp)

;; define the or gate as a compound of the and gate and an inverter

;; define NAND gate
(define (nand-gate a b out)
  (let ((c (make-wire)))
    (and-gate a b c)
    (inverter c out)
    'ok))

(define (or-gate a b out)
  (let ((c (make-wire))
        (d (make-wire)))
    (inverter a c)
    (inverter b d)
    (nand-gate c d out)))

;; the delay time will be inverter + and + inverter time = 2*inverter + and time.
