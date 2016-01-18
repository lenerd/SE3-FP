#!/usr/bin/env racket
#lang swindle
; SE3 FP Übungsblatt 11
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Lennart Braun
; Aufgabe 1.2: Anfragen

(require se3-bib/prolog/prologInScheme)


; Knowledge Base

;(ausleihe Signatur Lesernummer)
(<- (ausleihe "P 201" 100))
(<- (ausleihe "P 30" 102))
(<- (ausleihe "P 32" 104))
(<- (ausleihe "P 50" 104))
; (vorbestellung Signatur Lesernummer)
(<- (vorbestellung "P 201" 104))
(<- (vorbestellung "P 201" 102))
(<- (vorbestellung "P 30" 100))
(<- (vorbestellung "P 30" 104))
; (leser Name Vorname Lesernummer Geburtsjahr)
(<- (leser Neugierig Nena 100 1989))
(<- (leser Linux Leo 102 1990))
(<- (leser Luator Eva 104 1988))


; 1.
;(?- (vorbestellung "P 201" ?))
;;
;;
; No.
; Zwei Personen haben das Buch mit der Signatur "P 201" vorbestellt (zweifache
; Anfrage nach weiteren Ergebnissen vor "No.").


; 2.
;(?- (leser Linux Leo ?lesernummer ?))
;?lesernummer = 102
;;
; No.
; Leo Linux hat die Lesernummer 102.


; 3.
;(?- (leser ?name ?vorname ?lesernummer ?)
;    (vorbestellung "P 30" ?lesernummer))
;?name = Neugierig
;?vorname = Nena
;?lesernummer = 100
;;
;?name = Luator
;?vorname = Eva
;?lesernummer = 104
;;
; No.
; Nena Neugierig und Eva Luator haben das Buch mit der Signatur "P 30"
; vorbestellt.


; 4.
;(?- (ausleihe ? ?lesernummer)
;    (leser ?name ?vorname ?lesernummer ?geburtsjahr)
;    (test (< ?geburtsjahr 1956)))
; No.
; Niemand, der über 60 Jahre als ist, hat ein Buch ausgeliehen (oder ist in der
; Knowledge Base).


; 5.
;(?- (leser ?name ?vorname ?lesernummer ?)
;    (ausleihe ?x ?lesernummer)
;    (ausleihe ?y ?lesernummer)
;    (!= ?x ?y))
;?name = Luator
;?vorname = Eva
;?lesernummer = 104
;?x = P 32
;?y = P 50
;;
;?name = Luator
;?vorname = Eva
;?lesernummer = 104
;?x = P 50
;?y = P 32
;;
; No.
; Eva Luator hat mehr als ein Buch ausgeliehen. (Geht bestimmt hübscher.)
