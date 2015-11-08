#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 3
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2 Das internationale Flaggenalphabet

(require "./1_die_internationale_buchstabiertafel.rkt")
; (require "./flaggen-module.rkt")
(require se3-bib/flaggen-module)

; 1.
; Liste der Flaggen entsprechend zu der importierten chars
(define flags (list A B C D E F G H I J K L M N O P Q R S T U V W X Y Z Z0 Z1
                    Z2 Z3 Z4 Z5 Z6 Z7 Z8 Z9 '_ '_))

; Association List von Buchstaben und Flagge (Liste von Pairs mit dem
; Buchstaben als erstes Element und der entsprechenden Flagge als zweites
; Element)
; Begründung: Eine einfach zu erstellende und benutzende Datenstruktur.
(define flag-table (map cons chars flags))


; 2.
; Encodiert einen char als Flagge.
(define (char->flag c)
        (cdr (assoc c flag-table)))

; (char->flag #\F)
; (char->flag #\O)
; (char->flag #\0)


; 3. Buchstabieren


; Akzeptiert ein Wort
; s ∈ {'a', 'b', ..., 'z', 'A', 'B', ..., 'Z', '0', '1', ..., '9'}^*
; Gibt eine Liste der entsprechenden Flaggen zurück.
(define (flag-spell s)

        (define (flag-spell-helper l)
                (if (empty? l) '()
                    (cons (char->flag (upper (car l))) (flag-spell-helper (cdr l)))))

        (flag-spell-helper (string->list s)))

(flag-spell "f00b4r")
