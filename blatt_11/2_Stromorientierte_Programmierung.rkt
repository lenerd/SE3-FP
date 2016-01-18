#!/usr/bin/env racket
#lang lazy
; SE3 FP Übungsblatt 11
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Lennart Braun
; Aufgabe 2: Stromorientierte Programmierung

; seven Stream ab n.
(define (seven-helper n)
        (cons (if (or (= (remainder n 7) 0)
                      (member #\7 (string->list (number->string n))))
                  'sum
                  n)
              (seven-helper (+ n 1))))

; seven Stream
(define seven (seven-helper 1))

;(!! (take 20 seven))
;'(1 2 3 4 5 6 sum 8 9 10 11 12 13 sum 15 16 sum 18 19 20)
