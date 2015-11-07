#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 3
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 1: Die internationale Buchstabiertafel

; 1. Datenstruktur
(define table
        '((#\A . "Alfa")
          (#\B . "Bravo")
          (#\C . "Charlie")
          (#\D . "Delta")
          (#\E . "Echo")
          (#\F . "Foxtrott")
          (#\G . "Golf")
          (#\H . "Hotel")
          (#\I . "India")
          (#\J . "Juliett")
          (#\K . "Kilo")
          (#\L . "Lima")
          (#\M . "Mike")
          (#\N . "November")
          (#\O . "Oscar")
          (#\P . "Papa")
          (#\Q . "Quebec")
          (#\R . "Romero")
          (#\S . "Sierra")
          (#\T . "Tango")
          (#\U . "Uniform")
          (#\V . "Viktor")
          (#\W . "Whiskey")
          (#\X . "X-ray")
          (#\Y . "Yankee")
          (#\Z . "Zulu")
          (#\0 . "Nadazero")
          (#\1 . "Unaone")
          (#\2 . "Bissotwo")
          (#\3 . "Terrathree")
          (#\4 . "Kartefour")
          (#\5 . "Pantafive")
          (#\6 . "Soxisix")
          (#\7 . "Setteseven")
          (#\8 . "Oktoeight")
          (#\9 . "Novenine")
          (#\, . "Decimal")
          (#\. . "Stop")))
; TODO: Begründung


; 2. encode
(define (encode c)
        (cdr (assoc c table)))

; > (encode #\B)
; "Bravo"
; > (encode #\4)
; "Kartefour"
; > (encode #\2)
; "Bissotwo"
; > (encode #\,)
; "Decimal"
; > (encode #\.)
; "Stop"


; 3. upper

; Accepts a character. Returns the uppercase version if the argument is a
; lower case character; else the argument itself is returned.
(define (upper c)
        (let ((ascii (char->integer c)))
             (if (and (<= #x61 ascii) (<= ascii #x7a))
                 (integer->char (- ascii #x20))
                 c)))

; > (upper #\a)
; #\A
; > (upper #\A)
; #\A
; > (upper #\space)
; #\space
; > (upper #\newline)
; #\newline
; > (upper #\0)
; #\0


; 4. Buchstabieren

(define (spell-helper l)
        (if (empty? l) '()
            (cons (encode (upper (car l))) (spell-helper (cdr l)))))

; Akzeptiert ein Wort
; s ∈ {'a', 'b', ..., 'z', 'A', 'B', ..., 'Z', '0', '1', ..., '9', ',', '.'}^*
; Gibt eine Liste der entsprechenden Buchstabierschlüssel zurück.
(define (spell s)
        (spell-helper (string->list s)))

; > (spell "f00b4r")
; '("Foxtrott" "Nadazero" "Nadazero" "Bravo" "Kartefour" "Romero")


(provide upper)
