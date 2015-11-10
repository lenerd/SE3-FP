#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 3
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 1: Die internationale Buchstabiertafel


; Liste von Großbuchstaben, Ziffern, Komma und Punkt
(define chars (list #\A #\B #\C #\D #\E #\F #\G #\H #\I #\J #\K #\L #\M #\N #\O
                    #\P #\Q #\R #\S #\T #\U #\V #\W #\X #\Y #\Z #\0 #\1 #\2 #\3
                    #\4 #\5 #\6 #\7 #\8 #\9 #\, #\.))

; Liste der entsprechenden Buchstabierschlüssel
(define icao-alphabet (list "Alfa" "Bravo" "Charlie" "Delta" "Echo" "Foxtrott"  
                            "Golf" "Hotel" "India" "Juliett" "Kilo" "Lima"
                            "Mike" "November" "Oscar" "Papa" "Quebec" "Romeo"
                            "Sierra" "Tango" "Uniform" "Viktor" "Whiskey"
                            "X-ray" "Yankee" "Zulu" "Nadazero" "Unaone"
                            "Bissotwo" "Terrathree" "Kartefour" "Pantafive"
                            "Soxisix" "Setteseven" "Oktoeight" "Novenine"
                            "Decimal" "Stop"))


; Association List von Buchstaben und Buchstabierschlüssel
(define icao-table (map cons chars icao-alphabet))


; Encodiert einen char als Buchstabierschlüssel.
(define (char->icao c)
        (cdr (assoc c icao-table)))


; Wandelt einen Buchstaben c in einen Großbuchstaben um, falls dieser ein
; Kleinbuchstabe ist.
(define (upper c)
        (let ((ascii (char->integer c)))
             (if (and (<= #x61 ascii) (<= ascii #x7a))
                 (integer->char (- ascii #x20))
                 c)))


; Akzeptiert ein Wort
; s ∈ {'a', 'b', ..., 'z', 'A', 'B', ..., 'Z', '0', '1', ..., '9', ',', '.'}^*
; Gibt eine Liste der entsprechenden Buchstabierschlüssel zurück.
(define (icao-spell s)

        (define (spell-helper l)
                (if (empty? l) '()
                    (cons (char->icao (upper (car l))) (spell-helper (cdr l)))))

        (spell-helper (string->list s)))


(provide chars upper)
(provide chars icao-spell)
