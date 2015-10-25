#!/usr/bin/env racket
#lang racket

; SE3 Übungsblatt 1
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.3 Himmelsrichtungen


; Berechnet einen entsprechenden Winkel in [0, 360).
(define (normalize-direction α)
        (cond ((< α 0) (normalize-direction (+ α 360)))
              ((>= α 360) (normalize-direction (- α 360)))
              (else α)))

; Wandelt einen Kurs in Grad in eine symbolische Himmelsrichtung um.
; Parameter (in Grad):
; α ∈ [0, 360)
; Return ∈ {"N", "NNE", ..., "NNW"}
(define (Grad->Himmelsrichtung-helper α)
        (cond ((or (<= α 11.25) (> α 348.75)) "N")
              ((<= α  33.75) "NNE")
              ((<= α  56.25) "NE")
              ((<= α  78.75) "ENE")
              ((<= α 101.25) "E")
              ((<= α 123.75) "ESE")
              ((<= α 146.25) "SE")
              ((<= α 168.75) "SSE")
              ((<= α 191.25) "S")
              ((<= α 213.75) "SSW")
              ((<= α 236.25) "SW")
              ((<= α 258.75) "WSW")
              ((<= α 281.25) "W")
              ((<= α 303.75) "WNW")
              ((<= α 326.25) "NW")
              ((<= α 348.75) "NNW")))

; Wandelt einen Kurs in Grad in eine symbolische Himmelsrichtung um.
; Parameter (in Grad):
; α: Richtung
; Return ∈ {"N", "NNE", ..., "NNW"}
(define (Grad->Himmelsrichtung α)
        (Grad->Himmelsrichtung-helper (normalize-direction α)))


; Wandelt eine Himmelsrichtung in eine Angabe in Grad um.
; Parameter (in Grad):
; h ∈ {"N", "NNE", ..., "NNW"}
(define (Himmelsrichtung->Grad h)
        (cond ((string=? h "N")     0.0)
              ((string=? h "NNE")  22.5)
              ((string=? h "NE")   45.0)
              ((string=? h "ENE")  67.5)
              ((string=? h "E")    90.0)
              ((string=? h "ESE") 112.5)
              ((string=? h "SE")  135.0)
              ((string=? h "SSE") 157.5)
              ((string=? h "S")   180.0)
              ((string=? h "SSW") 202.5)
              ((string=? h "SW")  225.0)
              ((string=? h "WSW") 247.5)
              ((string=? h "W")   270.0)
              ((string=? h "WNW") 292.5)
              ((string=? h "NW")  315.0)
              ((string=? h "NNW") 337.5)))

