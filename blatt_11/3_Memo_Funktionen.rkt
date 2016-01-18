#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 11
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Lennart Braun
; Aufgabe 3: Memo-Funktionen


; n-te Fibonacci Zahl
(define (fib n)
        (if (or (= 0 n) (= 1 n))
            1
            (+ (fib (- n 1)) (fib (- n 2)))))


; n!
(define (fac n)
        (if (= 0 n)
            1
            (* n (fac (- n 1)))))
  

; Erstellt eine memoisierende Version einer Funktion.
; Usage:
; (define mfunc (memoize func))
; (set! func mfunc)
(define (memoize func)
        (letrec ([table '()]
                 ; [wrapped (λ (n) (if (assoc n table)
                 ;                     (cdr (assoc n table))
                 ;                     (let ([res (func n)])
                 ;                          (set! table (cons (cons n res) table))
                 ;                          res)))])
                 [wrapped (λ (n) (let ([stored (assoc n table)])
                                      (if stored
                                          (cdr stored)
                                          (let ([res (func n)])
                                               (set! table (cons (cons n res) table))
                                               res))))])
                wrapped))


(define mfib (memoize fib))
(set! fib mfib)

(define mfac (memoize fac))
(set! fac mfac)
