#!/usr/bin/env racket
#lang racket

; SE3 Übungsblatt 1
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.3 Himmelsrichtungen


; Wandelt einen Kurs in Grad in eine symbolische Himmelsrichtung um.
; Parameter (in Grad):
; α ∈ [0, 360)
; Return ∈ {'N, 'NNE, ..., 'NNW}
(define (Grad->Himmelsrichtung α)
        (cond ((or (<= α 11.25) (> α 348.75)) 'N)
              ((<= α  33.75) 'NNE)
              ((<= α  56.25) 'NE)
              ((<= α  78.75) 'ENE)
              ((<= α 101.25) 'E)
              ((<= α 123.75) 'ESE)
              ((<= α 146.25) 'SE)
              ((<= α 168.75) 'SSE)
              ((<= α 191.25) 'S)
              ((<= α 213.75) 'SSW)
              ((<= α 236.25) 'SW)
              ((<= α 258.75) 'WSW)
              ((<= α 281.25) 'W)
              ((<= α 303.75) 'WNW)
              ((<= α 326.25) 'NW)
              ((<= α 348.75) 'NNW)))


; Wandelt eine symbolische Himmelsrichtung in eine Angabe in Grad um.
; Parameter (in Grad):
; h ∈ {'N, 'NNE, ..., 'NNW}
(define (Himmelsrichtung->Grad h)
        (cond ((eq? h 'N)     0.0)
              ((eq? h 'NNE)  22.5)
              ((eq? h 'NE)   45.0)
              ((eq? h 'ENE)  67.5)
              ((eq? h 'E)    90.0)
              ((eq? h 'ESE) 112.5)
              ((eq? h 'SE)  135.0)
              ((eq? h 'SSE) 157.5)
              ((eq? h 'S)   180.0)
              ((eq? h 'SSW) 202.5)
              ((eq? h 'SW)  225.0)
              ((eq? h 'WSW) 247.5)
              ((eq? h 'W)   270.0)
              ((eq? h 'WNW) 292.5)
              ((eq? h 'NW)  315.0)
              ((eq? h 'NNW) 337.5)))

