#lang racket
(require sicp)

(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))

;; v => (a b c)
;; (mystery v)
;; (loop v '())
;; temp: x:(b c), y: (a)
;; (loop x:(b c) y:(a))
;; temp: (c), x: (b a)
;; (loop x: (c), y: (b a)
;; temp: '(), x: (c b a)
;; x: '(), y: (c b a)
;; => (c b a)

;; The mystery function takes a list, reverses it (via destroying it), and returns
;; a new list whose value is the original list reversed.
(define v (list 1 2 3))
;; v: [1 | .] -> [2 | .] -> [3 | /]
(define w (mystery v))
;; w: [3 | .] -> [2 | .] -> [1 | /]

v ;; (1)
;; v: [1 | /]
w ;; (3 2 1)
;; w: [3 | .] -> [2 | .] -> [1 | /]

;; This makes sense because the cons-cell in v: [1 | .] is aliased in w.
;; w alters this cons-cell and sets its cdr to null.
;; v meanwhile still refers to that same cons-cell.
;; Hence v is now (1)
;; Basically it is mutating the cons-cells
;; in the list such that the list is now reversed.

