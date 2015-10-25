#!/usr/bin/env racket
#lang racket

; SE3 Übungsblatt 1
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.2 Anfangskurs

(require "./1.1_bogenmass_und_grad.rkt")
(require "./2.1_grosskreisentfernung.rkt")


(define (course-helper φA φB dG)
        (acos (/ (- (sin φB)
                    (* (cos dG)
                       (sin φA)))
                 (* (cos φA)
                    (sin dG))))
)

(define (fix-dir α λA λB)
        (if (and (< λB λA)
                 (< (- λA λB) 180))
            (- 360 α)
            α))

; Berechnet die Richtung in der B von A aus gesehen liegt.
; Parameter (in Grad):
; φA: Breitengrad von A
; λA: Längengrad von A
; φB: Breitengrad von B
; λB: Längengrad von B
(define (initial-course φA λA φB λB)
        (fix-dir
            (radians->degrees
                (course-helper
                    (degrees->radians φA)
                    (degrees->radians φB)
                    (great-circle-distance (degrees->radians φA)
                                           (degrees->radians λA)
                                           (degrees->radians φB)
                                           (degrees->radians λB))
                )
            )
            λA
            λB
        )
)

; Oslo - Hongkong: 67.44°
(initial-course 59.93 10.75 22.20 114.10)

; San Francisco - Honolulu: 251.78°
(initial-course 37.75 -122.45 21.32 -157.83)

; Osterinsel - Lima: 70.07°
(initial-course -27.10 -109.40 -12.10 -77.05)

