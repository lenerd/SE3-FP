#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 6
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.3: Testen der Sortierverfahren mit einer Liste von Bildern

(require "./2.1_Insertion-Sort.rkt")
(require "./2.2_Quicksort.rkt")
(require 2htdp/image)


(define (rel<? a b) a)


(define icons (list (star-polygon 35 5 2 "solid" "gold")
                    (ellipse 44 44 "solid" "red")
                    (rectangle 38 38 "solid" "blue")
                    (isosceles-triangle 45 65 "solid" "darkgreen")))


; unsortiert
; icons

(define (image-width<? a b) (< (image-width a) (image-width b)))

; nach Breite sortiert
; (insertion-sort icons image-width<?)
; (quicksort icons image-width<?)
; blaues Quadrat, roter Kreis, grünes Dreieck, gelber Stern
