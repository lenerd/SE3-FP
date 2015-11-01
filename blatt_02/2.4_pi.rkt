#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 2
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.4 π


(require "./2.2_potenzen_von_rationalzahlen.rkt")


(define (π-iter sum n sign acc)
        (let ((val (sign (/ 1 n))))
             (if (< (abs val) acc) sum
                 (π-iter (+ sum val) (+ n 2) (if (eq? sign -) + -) acc))))

; Berechnet π mit der gewünschten Genauigkeit.
(define (π accuracy)
        (* (π-iter 0 1 + accuracy) 4))

; Rechnet eine Anzahl an Dezimalstellen in eine entsprechende Rationalzahl um.
(define (decimal-places->accuracy n)
        (power (/ 1 10) n))

; (π (decimal-places->accuracy 5))
; Stellen | Zeit
;       4      2.99s
;       5   1141.93s
; Die Ausgabe ist leider z lang für meine Zwischenablage. :(

