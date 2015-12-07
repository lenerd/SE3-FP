#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 7
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.3: Grafische Darstellung 1


(require 2htdp/image)
(require "./2.2_wertebereiche.rkt")

; Malt Punkte.
(define (draw-points pointlist)
        (apply (curry foldl
                      (curry place-image (ellipse 2 2 "solid" "blue"))
                      (empty-scene 800 600))
               (zip-pairs->lists (map (λ (xy) (cons (car xy) (- 600 (cdr xy)))) pointlist))))


;(draw-points '((0 . 0) (2 . 4) (4 . 16) (6 . 36) (8 . 64)))
               
(provide draw-points)
