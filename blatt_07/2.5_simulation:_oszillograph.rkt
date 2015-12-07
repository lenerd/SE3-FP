#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 7
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.5: Simulation: Oszillograph

(require 2htdp/image)
(require 2htdp/universe)
(require "./2.1_funktionen_und_werte.rkt")
(require "./2.2_wertebereiche.rkt")

; Wie aus 2.3, malt dicke rote Punkte falls special?
(define (draw-points pointlist special?)
        (apply (curry foldl
                      (curry place-image (if special?
                                             (ellipse 5 5 "solid" "red")
                                             (ellipse 2 2 "solid" "blue")))
                      (empty-scene 800 600 "transparent"))
               (zip-pairs->lists (map (λ (xy) (cons (car xy) (- 600 (cdr xy)))) pointlist))))

; Wie plot-function, markiert Punkt t
(define (live-plot-function f interval n t)
        (let* ((points (rescale2d (function->points f interval n)
                                '(0 . 600)
                                '(0 . 600)))
               (index (modulo t (length points))))
              (overlay (draw-points (take points index) #f)
                       (draw-points (list (car (drop points index))) #t)
                       (draw-points (cdr (drop points index)) #f))))


; yay
(animate (curry live-plot-function (λ (x) (+ 1 (sin x))) (cons 0 (* 2 pi)) 100))

