#!/usr/bin/env racket
#lang racket

; SE3 Übungsblatt 1
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 1.1 Bogenmaß und Grad

; Konvertiert einen Winkel in Grad ins Bogenmaß.
(define (degrees->radians phi)
        (/ (* 2 pi phi) 360))

; Konvertiert einen Winkel vom Bogenmaß nach Grad.
(define (radians->degrees phi)
        (/ (* 360 phi) (* 2 pi)))


(provide degrees->radians radians->degrees)

