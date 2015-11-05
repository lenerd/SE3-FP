#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 2
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 1 Symbole und Werte, Umgebungen

; Gegeben seien die folgenden Definitionen

(define miau 'Plueschi)
(define katze miau)
(define tiger 'miau)
(define (welcherNameGiltWo PersonA PersonB)
        (let ((PersonA 'Sam)
              (PersonC PersonA))
             PersonC))
(define xs1 '(0 2 3 miau katze))
(define xs2 (list miau katze))
(define xs3 (cons katze miau))


; 1.
; > miau
; 'Plueschi
; miau ist an das Symbol 'Plueschi gebunden.

; 2.
; > katze
; 'Plueschi
; katze ist an miau gebunden, welches an 'Plueschi gebunden ist.

; 3.
; > tiger
; 'miau
; tiger ist an 'miau gebunden.

; 4.
; > (quote katze)
; 'katze
; katze wird gequotet.

; 5.
; > (eval tiger)
; 'Plueschi
; Tiger ist an 'miau gebunden, welches zu 'Plueschi evaluiert wird.

; 6.
; > (eval katze)
; ; Plueschi: undefined;
; ;  cannot reference an identifier before its definition
; ;   in module:
; ;     "/home/.../1_symbole_und_werte_umgebungen.rkt"
; ; [,bt for context]
; katze ist an miau gebunden, welches an 'Plueschi gebunden ist. Dieses kann
; nicht evaluiert werden, da Plueschi nicht definiert ist.

; 7.
; > (eval 'tiger)
; 'miau
; Das Symbol 'tiger wird zu tiger evaluiert, welches an 'miau gebunden ist.

; 8.
; > (welcherNameGiltWo 'harry 'potter)
; 'harry
; Innerhalb der let Klausel ist PersonA an 'Sam und PersonC an das originale
; PersonA gebunden. Daher wird der erste Parameter zurückgegeben.

; 9.
; > (cdddr xs1)
; '(miau katze)
; cdddr entspricht der Komposition cdr ∘ cdr ∘ cdr. cdr gibt das zweite Element
; eines Tupels zurück. Bei einer Liste entspricht dies der Restliste. Dreimal
; hintereinander angewendet, ergibt dies die Liste ab dem vierten Element.
; (cdddr '(0 2 3 miau katze))
; = (cdr (cdr (cdr '(0 2 3 miau katze))))
; = (cdr (cdr '(2 3 miau katze)))
; = (cdr '(3 miau katze))
; = '(miau katze)

; 10.
; > (cdr xs2)
; '(Plueschi)
; xs2 ist eine Liste aus den Werten von katze und miau. Beide sind (transitiv)
; an 'Plueschi gebunden. Eine Liste ist ein Tupel bestehend aus Listenkopf und
; der Restliste. cdr gibt das zweite Element zurück, die Restliste, die
; 'Plueschi enthält.

; 11.
; > (cdr xs3)
; 'Plueschi
; xs3 ist ein Tupel aus den Werten von katze und miau. Beide sind (transitiv) an 'Plueschi
; gebunden. cdr das zweite Element zurück, also 'Plueschi.

; 12.
; > (eval (sqrt 3))
; 1.7320508075688772
; (sqrt 3) ergibt eine Fließkommazahl. Evaluiert man einen Wert, so ändert sich
; an diesem nichts mehr.
