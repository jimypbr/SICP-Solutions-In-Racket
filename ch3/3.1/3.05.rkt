#lang racket

;; exercise 3.05 -- monte carlo integration

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else (iter (- trials-remaining 1)
                      trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (* (random) range))))

(define (square x)
  (* x x))

(define (P x y)
  (< (+ (square (- x 5))
        (square (- y 7)))
     9))

(define (estimate-integral P x1 x2 y1 y2 trials)
  (define (estimate)
    (P (random-in-range x1 x2)
       (random-in-range y1 y2)))
  (monte-carlo trials estimate))

(define pi-approx
  (/ (* (estimate-integral P 2.0 8.0 4.0 10.0 10000) 36)
     9))

(estimate-integral P 2.0 8.0 4.0 10.0 1000)
(exact->inexact pi-approx)
