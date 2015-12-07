#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 7
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.1: Funktionen und Werte


(require "./1_generieren_von_listen.rkt")


; Evaluiert f.
(define (function->points f interval n)
        (map (λ (x) (cons x (f x)))
             (range interval n)))


; (function->points sqr '(0 . 10) 5)

(provide function->points)
