#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 2
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.2 Potenzen von Rationalzahlen


; Berechnet r^n für r ∈ ℝ, n ∈ ℕ 
(define (power r n)
        (cond ((= n 0) 1)
              ((odd? n) (* (power r (- n 1)) r))
              ((even? n) (sqr (power r (/ n 2))))))

(provide power)

