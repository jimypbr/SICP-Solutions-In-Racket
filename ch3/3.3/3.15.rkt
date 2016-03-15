#lang racket
(require sicp)

(define (set-to-wow! x) (set-car! (car x) 'wow) x)

(define x (list 'a 'b))
(define z1 (cons x x))
(define z2 (cons (list 'a 'b) (list 'a 'b)))

(set-to-wow! z1)
(set-to-wow! z2)
(display z1)
(display z2)

;; z1 => [. | .] -> [wow | /]
;;        |---------->|
;; z2 => [. | .] -> [a | .] -> [b | /]
;;        |------>[wow | .] -> [b | /]
