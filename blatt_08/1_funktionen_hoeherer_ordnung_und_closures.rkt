#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 8
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Lennart Braun
; Aufgabe 1: Funktionen höherer Ordnung und Closures


; 1. Eine Funktion, die (mindestens) eine andere Funktion als Parameter nimmt.

; 2. (a) foldl ist eine Funktion höherer Ordnung.
;        Sie nimmt eine Funktion als Parameter und ruft diese mit den Elementen
;        der Liste als Argumente auf.
;    (b) anfang-oder-ende ist keine Funktion höherer Ordnung.
;    (c) pepper ist eine Funktion höherer Ordnung.
;        Sie nimmt eine Funktion f als Parameter und verpackt diese in einer
;        Closure.
;    (d) my-tan ist keine Funktion höherer Ordnung.

; 3. Der Aufruf sollte äquivalent zu ((curry max 5) 7) sein. pepper erstellt
;    eine Closure, in der max an f und 5 an arg1 gebunden werden. Beim Aufruf
;    der zurückgegebenen Funktion wird 7 an arg2 gebunden und max mit 5 und 7
;    aufgerufen.

; 4.

; (foldl (curry / 2) 1 '(1 1 2 3))
; 2/3
; (/ 2 1 1) -> 2
; (/ 2 2 1) -> 1
; (/ 2 1 2) -> 1
; (/ 2 1 3) -> 2/3

; (map cons '(1 2 3 4) '(1 2 3 4))
; '((1 . 1) (2 . 2) (3 . 3) (4 . 4))
; cons wir mit den i-ten Elementen jeder Liste aufgerufen, die Ergebnisse
; landen wieder in einer Liste

; (filter pair? '((a b) () 1 (())))
; '((a b) (()))
; Alles, was kein Pair ist, weg rausgefiltert.


; (map (compose (curry + 32) (curry * 1.8))
;      '(5505 100 0 1 1000 -273.15))
; '(9941.0 212.0 32 33.8 1832.0 -459.66999999999996)
; (compose ...) ergibt eine Funktion, die das Argument zunächst mit 1.8
; multipliziert und anschließend 32 raufaddiert.

; 5. Fahrenheit

; (map (compose (curryr / 1.8) (curryr - 32))
;      '(9941.0 212.0 32 33.8 1832.0 -459.66999999999996))
; '(5505.0 100.0 0 0.9999999999999984 1000.0 -273.15)
; Floatingpoint Arithmetik ...

