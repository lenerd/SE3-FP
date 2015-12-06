#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 7
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.4: Grafische Darstellung 2

(require "./2.3_grafische_darstellung_1.rkt")
(require "./2.2_wertebereiche.rkt")
(require "./2.1_funktionen_und_werte.rkt")


(define (plot-function f interval n)
        (draw-points (rescale2d (function->points f interval n)
                                '(0 . 600)
                                '(0 . 600))))


(plot-function (λ (x) (log x)) ' (1 . 1000) 1000)
;(plot-function (λ (x) (+ 1 (sin x))) ' (1 . 10) 1000)
