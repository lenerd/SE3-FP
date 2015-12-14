#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 8
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Lennart Braun
; Aufgabe 2: Einfache funktionale Ausdrücke höherer Ordnung


(define xs '(-4 -3 -2 -1 0 1 2 3 4 10 11 12 13))


; (map sqrt xs)
; '(0+2i 0+1.7320508075688772i 0+1.4142135623730951i 0+1i 0 1 1.4142135623730951 1.7320508075688772 2 3.1622776601683795 3.3166247903554 3.4641016151377544 3.605551275463989)

; (filter (compose (curry = 0) (curryr modulo 3)) xs)
; '(-3 0 3 12)

; (foldl + 0 (filter (λ (x) (and (odd? x) (> x 10))) xs))
; 24
