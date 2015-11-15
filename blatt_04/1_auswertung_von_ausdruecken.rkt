#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 4
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 1: Auswertung von Ausdrücken

; 1
; (max (min 2 (- 2 5)) 0)
; 0
; , da
; (max (min 2 (- 2 5)) 0)
; (max (min 2 -3) 0)
; (max -3 0)
; 0

; 2
; '(+ (- 2 13) 11)
; '(+ (- 2 13) 11)
; Der Ausdruck ist gequotet.

; 3
; (cadr '(Alle Jahre wieder))
; 'Jahre
; , da das erste Element der Restliste zurückgegeben wird:
; (cadr '(Alle Jahre wieder))
; (car (cdr '(Alle Jahre wieder)))
; (car '(Jahre wieder))
; 'Jahre

; 4
; (cddr '(kommt (das Weihnachtfest)))
; '()
; , da die Restliste der Restliste zurückgegeben wird. Diese ist leer, da die
; Liste nur die zwei Elemente  'kommt und '(das Weihnachtfest) enthält.
; (cddr '(kommt (das Weihnachtfest)))
; (cdr (cdr '(kommt (das Weihnachtfest))))
; (cdr '((das Weihnachtfest)))
; '()

; 5
; (cdadr '(kommt (das . Weihnachtfest)))
; 'Weihnachtfest
; , da das zweite Element des ersten Elementes der Restliste zurückgegeben wird:
; (cdadr '(kommt (das . Weihnachtfest)))
; (cdr (car (cdr '(kommt (das . Weihnachtfest)))))
; (cdr (car '((das . Weihnachtfest))))
; (cdr '(das . Weihnachtfest))
; 'Weihnachtfest

; 6
; (cons 'Listen '(ganz einfach und))
; '(Listen ganz einfach und)
; , da eine Liste ein Tupel aus dem ersten Element und der Restliste ist. Hier
; wir eine neue Liste erstellt, indem ein Tupel aus dem neuen Listenkopf
; 'Listen und der Restliste '(ganz einfach und) gebildet wird.
;

; 7
; (cons 'Paare 'auch)
; '(Paare . auch)
; cons erstellt ein Tupel aus den beiden Symbolen.
 
; 8
; (equal? (list 'Racket 'Prolog 'Java) '(Racket Prolog Java))
; #t
; equal? testet auf Gleichheit.

; 9
; (eq? (list 'Racket 'Prolog 'Java) (cons 'Racket '(Prolog Java)))
; #f
; eq? testet auf Identität.
