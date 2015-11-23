#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 5
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 1: Mendels Land

(require se3-bib/butterfly-module)
(require racket/trace)

; Es werden Funktionen für folgende Aufgaben benötigt:
; * Vergleich von Merkmalen nach Dominanz
; * Berechnung des Phänotyps aus einem gegebenen Genotypen
; * zufällige Auswahl von einem Merkmal pro Merkmalstyp
; * Erstellung eines neuen Schmetterlings, dessen Genom sich aus den Genomen
;   der Eltern zusammensetzt
; * Erstellung von beliebig vielen Kindern
; Die Schnittstellen stehen an der jeweilige Funktion

; Als Datenstruktur für das Genom wählen wir den folgenden Ansatz
; Eine Liste, die für jeden Merkmalstyp eine zweielementige Liste der
; vorhandenen Merkmale enthält.
; Ein Phänotyp ist eine Liste der dominanten Merkmale.
; Die Reihenfolge der Merkmalstypen in den Listen entspricht der Reihenfolge
; der Parameter von show-butterfly.

; Begründung:
; TODO


; Beispiel Schmetterlinge aus Aufgabe 1 als Testdaten
(define mother
        '((red  blue)
          (stripes  star)
          (straight  curved)
          (hexagon  ellipse)))
(define father
        '((green green)
          (dots  star)
          (straight  curved)
          (rhomb  ellipse)))


; Ordnung über die Menge der möglichen Merkmale:
; Seien a,b verschiedene Ausprägungen der gleichen Merkmalstyps, dann gilt:
; a dominiert b genau dann, wenn a vor b in der Liste steht.
; Über zwei Ausprägungen verschiedener Typen gebe die Liste keine Aussage.
(define characteristics '(red green blue yellow 
                          dots stripes star 
                          straight curved curly
                          rhomb hexagon ellipse))

; Gibt das dominante der beiden Merkmale a und b zurück.
; Parameter:
; * a ∈ characteristics
; * b ∈ characteristics
; * a, b haben den gleichen Merkmalstyp
; Return: a, wenn a > b sonst b
(define (dominant a b)
        (if (> (length (memq a characteristics))
               (length (memq b characteristics)))
            a
            b))

; Wählt ein zufälliges Element aus der Liste lst.
; Parameter:
; * lst: Liste
; Return: l ∈ lst
(define (choose-random lst)
        (list-ref lst (random (length lst))))

; Berechnet den Phänotypen aus einem Genom
; Parameter:
; * genome: Liste von zweielementigen Merkmalslisten
; Return: Liste gleicher Länge von Merkmalen
(define (genotyp->phenotyp genome)
        (map (λ (ab) (apply dominant ab)) genome))

; Wählt zufällig eine Ausprägung für jeden Merkmalstyp aus.
; Parameter:
; * genome: Liste von zweielementigen Merkmalslisten
; Return: Liste gleicher Länge von Merkmalen
(define (diploid->haploid genome)
        (map choose-random genome))

; zip über zwei Listen
; Parameter:
; * xs: Liste der Länge n
; * ys: Liste der Länge n
; Return: Liste der Länge n von zweielementigen Listen mit elementen aus xs und
;         ys
(define (zip xs ys)
        (map list xs ys))

; Erstellt ein neues Kind.
; Parameter:
; * p1 Genom des einen Elternteils
; * p2 Genom des anderen Elternteils
; Return: Genom eines Kindes
(define (make-child p1 p2)
        (zip (diploid->haploid p1)
             (diploid->haploid p2)))

; Erstellt n neue Kinder.
; Parameter:
; * p1 Genom des einen Elternteils
; * p2 Genom des anderen Elternteils
; * n ∈ ℕ Anzahl der Kinder
; Return: Liste n Genomen der Kinder
(define (make-children p1 p2 n)
        (if (= n 0) '()
            (cons (make-child p1 p2) (make-children p1 p2 (- n 1)))))

; Zeigt eines Liste von Schmetterlingen (repräsentiert durch ihr Genom) an.
; Parameter:
; * bs Liste von Schmetterlinggenomen
(define (show-butterflies bs)
        (map (λ (g) (apply show-butterfly (genotyp->phenotyp g)))
             bs))
        

; (show-butterflies (list mother father))
; (show-butterflies (make-children mother father 3))

(provide characteristics)
