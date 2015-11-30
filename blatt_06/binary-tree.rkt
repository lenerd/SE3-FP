#!/usr/bin/env racket
#lang racket

(require 2htdp/image)

; Erstellt einen vollständigen binären Baum der Höhe h. thing-maker sei eine
; Funktion ohne Parameter, welche die Knoten generiert.
(define (binary-tree h thing-maker)
        (define (helper h thing)
                (if (= h 0)
                    thing
                    (above thing
                           (beside (helper (- h 1) thing)
                                   (helper (- h 1) thing)))))
        (helper h (thing-maker)))


; Beispiel
; (binary-tree 3 (λ () (ellipse 50 50 "solid" "blue")))
(provide binary-tree)
