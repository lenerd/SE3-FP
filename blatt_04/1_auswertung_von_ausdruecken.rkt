#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 4
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 1: Auswertung von Ausdrücken

; 1
; (max (min 2 (- 2 5)) 0)
; 0

; 2
; '(+ (- 2 13) 11)
; '(+ (- 2 13) 11)

; 3
; (cadr '(Alle Jahre wieder))
; 'Jahre

; 4
; (cddr '(kommt (das Weihnachtfest)))
; '()

; 5
; (cdadr '(kommt (das . Weihnachtfest)))
; 'Weihnachtfest

; 6
; (cons 'Listen '(ganz einfach und))
; '(Listen ganz einfach und)

; 7
; (cons 'Paare 'auch)
; '(Paare . auch)
 
; 8
; (equal? (list 'Racket 'Prolog 'Java) '(Racket Prolog Java))
; #t

; 9
; (eq? (list 'Racket 'Prolog 'Java) (cons 'Racket '(Prolog Java)))
; #f
