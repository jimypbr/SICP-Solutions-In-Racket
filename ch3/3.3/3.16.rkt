#lang racket
(require sicp)

(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))

;; Box-and-pointer diagram representing list structures made up of exactly
;; three pairs that:
;; return 3:
;; 3-pairs : [a | .] -> [b | .] -> [c | /]
;; 4-pairs : 
;; foo: [a | b]
;; bar: [a | b]
;; baz: [. | .] --> [a | b]
;;       |------     |
;;             |--> [. | b]
;;
(define foo (cons 'a 'b))
(define bar (cons 'a 'b))
(define baz (cons foo bar))
(set-car! foo bar)
(count-pairs baz)

;; 7-pairs
;; foo: [a | b]
;; bar: [foo | foo]
;; baz: [bar | bar]
;;
;; baz: [ . | . ] -> [ bar | bar ]
;; bar: [ . | . ] -> [a | b]
;;        |--------> [a | b]
;; bar is 3. baz is 1 + 2*3 = 7
(define foo1 (cons 'a 'b))
(define bar1 (cons foo1 foo1))
(define baz1 (cons bar1 bar1))
(count-pairs baz1)
