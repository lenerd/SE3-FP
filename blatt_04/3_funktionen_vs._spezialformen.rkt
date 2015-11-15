#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 4
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 3: Funktionen vs. Spezialformen

(define (hoch3 x) (* x x x))

; Auswertung mit äußerer Reduktion
; Hier werden die Ausdrücke, die außen stehen, zuerst ausgewertet. Funktions-
; argumente werden zunächst ohne Auswertung in den Rumpf der Funktion
; eingesetzt.
; Beispiel:
; (hoch3 (* 3 (+ 1 (hoch3 2))))
; (* (* 3 (+ 1 (hoch3 2))) (* 3 (+ 1 (hoch3 2))) (* 3 (+ 1 (hoch3 2))))
; (* (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (* 2 2 2))) (* 3 (+ 1 (* 2 2 2))))
; (* (* 3 (+ 1 8)) (* 3 (+ 1 8)) (* 3 (+ 1 8)))
; (* (* 3 9) (* 3 9) (* 3 9))
; (* 27 27 27)
; 19683

; Auswertung mit innerer Reduktion
; Hier werden die Ausdrücke, die weiter innen stehen, zuerst ausgewertet.
; Beispiel:
; (hoch3 (* 3 (+ 1 (hoch3 2))))
; (hoch3 (* 3 (+ 1 (* 2 2 2))))
; (hoch3 (* 3 (+ 1 8)))
; (hoch3 (* 3 9))
; (hoch3 27)
; (* 27 27 27)
; 19683

; Für Funktionen verwendet Racket die innere Reduktion. Special Forms werden
; anders ausgewertet.
; Beispiel: (define (foo x) (* 42 x))
;           Würde hier die innere Reduktion verwendet werden, so würde versucht
;           werden, (foo x) und (* 42 x) auszuwerden. Dies würde in einem Fehler
;           resultieren, da foo wahrscheinlich noch nicht definiert ist.


(define (new-if predicate then-clause else-clause)
        (cond (predicate then-clause)
              (else else-clause)))

; Würde Alyssa faculty mit Hilfe von new-if definieren, so würden die Argumente
; nach der inneren Reduktion ausgewertet werden. Damit würde auch die rekursive
; else-clause ausgewertet, bevor eine Abbruchbedingung geprüft wird. Dadurch
; entsteht eine Rekursion, die nicht freiwillig endet.
