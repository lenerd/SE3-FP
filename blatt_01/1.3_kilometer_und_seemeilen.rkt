#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 1
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 1.3 Kilometer und Seemeilen

; Rechnet Seemeilen in Kilometer um.
(define (nm->km n)
        (* 1.852 n))


(provide nm->km)

