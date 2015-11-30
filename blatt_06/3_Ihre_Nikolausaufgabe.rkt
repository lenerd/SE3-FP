#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 6
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 3: Ihre Nikolausaufgabe

(require 2htdp/image)
(require "./koch-flocke.rkt")
(require "./binary-tree.rkt")


(define baum-flocken-baum (let ((tree (binary-tree 3 (λ () (wtf 100 3 6)))))
                               (place-image tree
                                            (/ (image-width tree) 2)
                                            (/ (image-height tree) 2)
                                            (empty-scene (image-width tree)
                                                         (image-height tree)
                                                         "PowderBlue"))))

(save-svg-image baum-flocken-baum "./baum-flocken-baum.svg")
(save-image baum-flocken-baum "./baum-flocken-baum.png")


;(save-svg-image (let ((tree (binary-tree 3 (λ () (wtf 300 3 6)))))
;                     (place-image tree
;                                  (/ (image-width tree) 2)
;                                  (/ (image-height tree) 2)
;                                  (empty-scene (image-width tree)
;                                               (image-height tree)
;                                               "PowderBlue")))
;                "./baum-flocken-baum.svg")
