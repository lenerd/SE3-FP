#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 2
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 3 Typprädikate


; Nimmt ein Ding als Parameter und gibt ein Symbol zurück, das dessen Typ
; angibt. Ist dieser unbekannt, wird 'unknown zrückgegeben.
(define (type-of x)
        (cond ((boolean? x) 'boolean)
              ((list? x) 'list)  ; eine Liste ist ein Sonderfall eines Paares
              ((pair? x) 'pair)  ; erkennt Paare, welche keine Listen sind
              ((symbol? x) 'symbol)
              ((number? x) 'number)
              ((char? x) 'char)
              ((string? x) 'string)
              ((vector? x) 'vector)
              ((procedure? x) 'procedure)
              (else 'unknown)))


; (type-of (* 2 3 4))
; 'number
; Das Produkt von Zahlen ist eine Zahl. :O

; (type-of (not 42))
; 'boolean
; not gibt einen Boolean zurück.

; (type-of '(eins zwei drei))
; 'list
; (eins zwei drei) ist eine nichtleere Liste (und damit auch ein Pair).

; (type-of '())
; 'list
; () ist eine leere Liste.

(define (id z) z)

; (type-of (id sin))
; 'procedure
; sin ist eine Funktion.

; (type-of (string-ref "Harry Potter und der Stein der Weisen" 3))
; 'char
; string-ref gibt den i-ten Character aus dem String zurück.

; (type-of (lambda (x) x))
; 'procedure
; Die übergebene Lambdafunktion ist auch eine Funktion.

; (type-of type-of)
; 'procedure
; type-of ist eine Funktion.

; (type-of (type-of type-of))
; 'symbol
; Unsere Definition von type-of gibt Symbole zurück.

