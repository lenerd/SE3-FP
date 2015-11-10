#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 4
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 3: Funktionen vs. Spezialformen

(define (hoch3 x) (* x x x))

; normal-order evaluation
; (hoch3 (* 3 (+ 1 (hoch3 2))))
; (* (* 3 (+ 1 (hoch3 2))) (* 3 (+ 1 (hoch3 2))) (* 3 (+ 1 (hoch3 2))))
; (* (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (* 2 2 2))))
; (* (* 3 (+ 1 8)) (* 3 (+ 1 8)) (* 3 (+ 1 8)))
; (* (* 3 9) (* 3 9) (* 3 9))
; (* 27 27 27)
; 19683

; applicative-order evaluation
; (hoch3 (* 3 (+ 1 (hoch3 2))))
; (hoch3 (* 3 (+ 1 (* 2 2 2))))
; (hoch3 (* 3 (+ 1 8)))
; (hoch3 (* 3 9))
; (hoch3 27)
; (* 27 27 27)
; 19683

; Für Funktionen verwendet Racket applicative-order evaluation, für special
; forms die normal-order evaluation.


(define (new-if predicate then-clause else-clause)
        (cond (predicate then-clause)
              (else else-clause)))

; Würde Alyssa faculty mit Hilfe von new-if definieren, so würden die Argumente
; in normal-order ausgewertet werden. D.h. faculty würde sich immer wieder
; rekursiv aufrufen und die Abbruchbedingung würde nie geprüft werden.


; Diese Aufgaben kenne ich doch irgendwoher ...
; Hat wohl ein Zauberer geschrieben.
