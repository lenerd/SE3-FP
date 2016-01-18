#!/usr/bin/env racket
#lang swindle
; SE3 FP Übungsblatt 11
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Lennart Braun
; Aufgabe 1.1: Unifikation

(require se3-bib/prolog/prologInScheme)


; a)
; ?Marke: Macbook
; ?Farbe: schwarz

;(unify '(Laptop ?Marke schwarz)
;       '(Laptop MacBook ?Farbe)
;       no-bindings)
;((?Farbe . schwarz) (?Marke . MacBook))


; b)
; nicht unifizierbar

;(unify '(Teilnehmer ((Peter Lustig Gold) (Petra Pfiffig Gold)))
;       '(Teilnehmer ((Peter Lustig Gold) (Petra Pfiffig Silber)))
;       no-bindings)
;#f


; c)
; ?Rang: Gold


;(unify '(Teilnehmer ((Peter Lustig Gold) (Petra Pfiffig Gold)))
;       '(Teilnehmer ((Peter Lustig Gold) (Petra Pfiffig ?Rang)))
;       no-bindings)
;((?Rang . Gold))


; d)
; ?andere: (Petra Pfiffig Gold) (Lena Lustig Silber)

;(unify '(Teilnehmer ((Peter Lustig Gold) . ?andere))
;       '(Teilnehmer ((Peter Lustig Gold) (Petra Pfiffig Gold) (Lena Lustig Silber)))
;       no-bindings)
;((?andere (Petra Pfiffig Gold) (Lena Lustig Silber)))


; e)
; ?farbe: Pik
; ?wert : As

;(unify '(Tupel (k ?farbe As) (k Pik ?wert))
;       '(Tupel (k Pik ?wert) (k ?farbe As))
;       no-bindings)
;((?wert . As) (?farbe . Pik))


; f)
; ?farbe: Pik
; ?wert : As
; ?wert2: As

;(unify '(Tupel (k ?farbe As) (k Pik ?wert2))
;       '(Tupel (k Pik ?wert) (k ?farbe ?wert))
;       no-bindings)
;((?wert2 . As) (?wert . As) (?farbe . Pik))
