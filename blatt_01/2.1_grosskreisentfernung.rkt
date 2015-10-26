#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 1
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.1 Großkreisentfernung

(require "./1.1_bogenmass_und_grad.rkt")
(require "./1.3_kilometer_und_seemeilen.rkt")


; Berechnet die Großkreisentfernung in Radiant zwischen zwei Punkten A und B.
; Parameter (im Bogenmaß):
; φA: Breitengrad von A
; λA: Längengrad von A
; φB: Breitengrad von B
; λB: Längengrad von B
(define (great-circle-distance φA λA φB λB)
        (acos (+ (* (sin φA)
                    (sin φB))
                 (* (cos φA)
                    (cos φB)
                    (cos (- λA λB))))))


; Berechnet die Großkreisentfernung in Kilometer zwischen zwei Punkten A und B.
; Parameter (in Grad):
; φA: Breitengrad von A
; λA: Längengrad von A
; φB: Breitengrad von B
; λB: Längengrad von B
(define (great-circle-distance-km φA λA φB λB)
        (nm->km
            (* 60
                (radians->degrees
                    (great-circle-distance (degrees->radians φA)
                                           (degrees->radians λA)
                                           (degrees->radians φB)
                                           (degrees->radians λB)
                    )
                )
            )
        )
)


; Oslo - Hongkong: 8589.4 km
;(great-circle-distance-km 59.93 10.75 22.20 114.10)

; San Francisco - Honolulu: 3844.7 km
;(great-circle-distance-km 37.75 -122.45 21.32 -157.83)

; Osterinsel - Lima: 3757.6 km
;(great-circle-distance-km -27.10 -109.40 -12.10 -77.05)


(provide great-circle-distance great-circle-distance-km)
