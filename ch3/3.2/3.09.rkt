#lang racket

(define (factorialr n)
  (if (= n 1)
      1
      (* n (factorialr (- n 1)))))

(define (factoriali n)
  (define (iter product counter max-count)
    (if (> counter max-count)
        product
        (iter (* counter product)
              (+ counter 1)
              max-count)))
  (iter 1 1 n))

;; environment model of (factorialr 6)
;; global env => factorial
;; (factorial 6) => E1 - n:6
;; (factorial 5) => E2 - n:5
;; ...
;;
;; E1(n:6) * E2(n:5) * E3(n:4) * E4(n:3) * E5(n:2) * 1

;; environment model for (factoriali 6)
;; global env => factoriali
;; E1 => iter, product:1 , counter:1, max-count:6
;; E2 => product: 1, counter: 2, max-count:6
;; E3 => product: 2, counter: 3, max-count:6
;; E4 => product: 6, counter: 4, max-count:6
;; E5 => product: 24, counter: 5, max-count:6
;; E6 => product: 120, counter: 6, max-count:6
;; E7 => product: 720, counter: 7, max-count:6
