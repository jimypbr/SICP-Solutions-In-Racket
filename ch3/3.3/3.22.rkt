#lang racket
(require sicp)

;; Exercise 3.22 - FIFO queue with message passing style

(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (empty-queue?)
      (null? front-ptr))
    (define (front-queue)
      (if (empty-queue?)
          (error "FRONT-QUEUE called with an empty queue")
          (car front-ptr)))
    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (set! rear-ptr new-pair)
               (set! front-ptr new-pair))
              (else
               (set-cdr! rear-ptr new-pair)))))
    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE-QUEUE! called with an empty queue"))
            (else
             (set! front-ptr (cdr front-ptr)))))
    (define (dispatch m)
      (cond ((eq? m 'empty-queue?) empty-queue?)
            ((eq? m 'front-queue) front-queue)
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'delete-queue!) delete-queue!)
            (else (error "Undefined operation: MAKE-QUEUE" m))))
    dispatch))

(define (empty-queue? queue)
  ((queue 'empty-queue?)))

(define (front-queue queue)
  ((queue 'front-queue)))

(define (insert-queue! queue item)
  ((queue 'insert-queue!) item))

(define (delete-queue! queue)
  ((queue 'delete-queue!)))


(module+ test
  (require rackunit)
  (let ((q1 (make-queue)))
    (insert-queue! q1 'a)
    (check-equal? (front-queue q1) 'a)
    (insert-queue! q1 'b)
    (check-equal? (front-queue q1) 'a)
    (delete-queue! q1)
    (check-equal? (front-queue q1) 'b)
    (delete-queue! q1)
    (check-equal? (empty-queue? q1) true)))
