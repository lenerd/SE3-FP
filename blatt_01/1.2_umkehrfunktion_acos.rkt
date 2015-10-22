#!/usr/bin/env racket
#lang racket

; SE3 Übungsblatt 1
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 1.2 Umkehrfunktion acos

; Berechnet arccos(x) für -1 <= x <= 1
(define (my-acos x)
        (if (= x -1)
            pi
            (* 2 (atan (/ (sqrt (- 1 (sqr x))) (+ 1 x))))))

