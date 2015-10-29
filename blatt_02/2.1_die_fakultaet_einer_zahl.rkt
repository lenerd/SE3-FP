#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 2
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.1 Die Fakultät einer Zahl


; Berechnet n! für n ∈ ℕ 
(define (factorial n)
        (if (= n 0) 1
            (* n (factorial (- n 1)))))

(provide factorial)

