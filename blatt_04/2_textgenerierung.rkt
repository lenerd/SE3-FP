#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 4
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2: Textgenerierung

; Backus-Naur-Form für Notrufe:
;
; <notmeldung>       ::= <ueberschrift> <notfall> <hilfeleistung> <peilzeichen>
;                        <unterschrift> <over>
; 
; <ueberschrift>     ::= <3x_mayday> <hier_ist> <3x_schiffsname> <rufzeichen>
;                        <mayday> <schiffsname> <icao_schiffsname> <rufzeichen>
; <notfall>          ::= <position> <zeit> <status>
; <peilzeichen>      ::= "ICH SENDE DEN TRAEGER --"
; <unterschrift>     ::= <schiffsname> <rufzeichen>
; <over>             ::= "OVER"
;
; <position>         ::= "NOTFALLPOSITION" <string>
; <zeit>             ::= "NOTFALLZEIT" <string>
; <status>           ::= <string>
; <hilfeleistung>    ::= <string>
; 
; <mayday>           ::= "MAYDAY"
; <3x_mayday>        ::= <mayday> <mayday> <mayday>
; 
; <hier_ist>         ::= "HIER IST" | "DELTA ECHO"
; 
; <schiffsname>      ::= <alpha_string>
; <icao_schiffsname> ::= <icao_string>
; <3x_schiffsname>   ::= <schiffsname> <schiffsname> <schiffsname>
; 
; <rufzeichen>       ::= <icao_letter> <icao_letter> <icao_letter>
;                        <icao_letter>
; 
; 
; <icao_letter>      ::= "Alfa" | "Bravo" | "Charlie" | "Delta" | "Echo" |
;                        "Foxtrott" | "Golf" | "Hotel" | "India" | "Juliett" |
;                        "Kilo" | "Lima" | "Mike" | "November" | "Oscar" |
;                        "Papa" | "Quebec" | "Romeo" | "Sierra" | "Tango" |
;                        "Uniform" | "Viktor" | "Whiskey" | "X-ray" | "Yankee" |
;                        "Zulu"
; 
; <letter>           ::= "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" |
;                        "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" |
;                        "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z"
; <digit>            ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" |
;                        "9"
; 
; <character>        ::= <letter> | <digit> | " "
; 
; <string>           ::= <character> | <character> <string>
; <alpha_string>     ::= <letter> | <letter> <alpha_string>
; <icao_string>      ::= <icao_letter> | <icao_letter> <icao_string>

(require "./3.1_die_internationale_buchstabiertafel.rkt")

; Verbindet Strings mit einem Delimiter
; Parameter:
;   * del       Delimiter
;   * strings   Liste von Strings
(define (join del . strings)

        (define (helper strings)
                (if (empty? strings) ""
                    (string-append del (car strings) (helper (cdr strings)))))

        (string-append (car strings) (helper (cdr strings))))

; Verbindet string mit Leerzeichen als Delimiter
(define (space-join . strings)
        (apply join " " strings))

(define (3x str) (space-join str str str))


; Generiert die Überschrift eines Notrufes
; Parameter:
;   * schiffsname
;   * rufzeichen
(define (ueberschrift schiffsname rufzeichen)
        (space-join (3x "MAYDAY")
                    "HIER IST"
                    (3x schiffsname)
                    (apply space-join (icao-spell rufzeichen))
                    "MAYDAY"
                    schiffsname
                    "ICH BUCHSTABIERE"
                    (apply space-join (icao-spell schiffsname))
                    "RUFZEICHEN"
                    (apply space-join (icao-spell rufzeichen))))

; Generiert die Beschreibung des Notfalls
; Parameter:
;   * position
;   * zeit
;   * status
(define (notfall position zeit status)
        (space-join "NOTFALLPOSITION" position
                    "NOTFALLZEIT" zeit
                    status))

; Generiert die Unterschrift eines Notrufes
; Parameter:
;   * schiffsname
;   * rufzeichen
(define (unterschrift schiffsname rufzeichen)
        (space-join schiffsname
                    (apply space-join (icao-spell rufzeichen))))

; Wandelt die Kleinbuchstaben in einem String in Großbuchstaben um.
(define (str-upper s)
        (list->string (map upper (string->list s))))

; Generiert einen Notruf
; Parameter:
;   * schiffsname
;   * rufzeichen
;   * position
;   * zeit
;   * status
;   * hilfeleistung
(define (notruf schiffsname rufzeichen position zeit status hilfeleistung)
        (str-upper (space-join (ueberschrift schiffsname rufzeichen)
                               (notfall position zeit status)
                               hilfeleistung
                               "ICH SENDE DEN TRAEGER --"
                               (unterschrift schiffsname rufzeichen)
                               "OVER")))


(notruf "Babette"  ; Schiffsname
        "DEJY"     ; Rufzeichen
        "UNGEFAEHR 10 SM NORDOESTLICH LEUCHTTURM KIEL"  ; Position
        "1000 UTC"  ; Zeit
        (string-append "SCHWERER WASSEREINBRUCH WIR SINKEN KEINE VERLETZTEN "
                       "VIER MANN GEHEN IN DIE RETTUNGSINSEL")  ; Status
        "SCHNELLE HILFE ERFORDERLICH"  ; notwendige Hilfe
        )
; "MAYDAY MAYDAY MAYDAY HIER IST BABETTE BABETTE BABETTE DELTA ECHO JULIETT
; YANKEE MAYDAY BABETTE ICH BUCHSTABIERE BRAVO ALFA BRAVO ECHO TANGO TANGO 
; ECHO RUFZEICHEN DELTA ECHO JULIETT YANKEE NOTFALLPOSITION UNGEFAEHR 10 SM
; NORDOESTLICH LEUCHTTURM KIEL NOTFALLZEIT 1000 UTC SCHWERER WASSEREINBRUCH WIR
; SINKEN KEINE VERLETZTEN VIER MANN GEHEN IN DIE RETTUNGSINSEL SCHNELLE HILFE
; ERFORDERLICH ICH SENDE DEN TRAEGER -- BABETTE DELTA ECHO JULIETT YANKEE OVER"


(notruf "Amira"  ; Schiffsname
        "AMRY"  ; Rufzeichen
        "53°56’N, 006°31’E"  ; Position
        "1640 UTC"  ; Zeit
        (string-append "sinken nach Kenterung in schwerer See: 15 Mann an "
                       "Bord, das Schiff ist 15m lang, roter Rumpf.")  ; Status
        "Hilfe?"  ; notwendige Hilfe
        )

; "MAYDAY MAYDAY MAYDAY HIER IST AMIRA AMIRA AMIRA ALFA MIKE ROMEO YANKEE
; MAYDAY AMIRA ICH BUCHSTABIERE ALFA MIKE INDIA ROMEO ALFA RUFZEICHEN ALFA MIKE
; ROMEO YANKEE NOTFALLPOSITION 53°56’N, 006°31’E NOTFALLZEIT 1640 UTC SINKEN
; NACH KENTERUNG IN SCHWERER SEE: 15 MANN AN BORD, DAS SCHIFF IST 15M LANG,
; ROTER RUMPF. HILFE? ICH SENDE DEN TRAEGER -- AMIRA ALFA MIKE ROMEO YANKEE
; OVER"
