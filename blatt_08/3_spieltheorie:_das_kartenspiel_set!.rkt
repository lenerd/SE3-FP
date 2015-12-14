#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 8
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Lennart Braun
; Aufgabe 3: Spieltheorie: Das Kartenspiel SET!

(require se3-bib/setkarten-module)
(require racket/trace)

; 1.
; Eine Spielkarte wird als Liste ihrer Eigenschaften repräsentiert. Die
; Ausprägung eines Eigenschaftstyps (Anzahl, Farbe etc.) wird durch Symbole
; analog zu den Parametern von show-set-card repräsentiert.
; Die Reihenfolge der Eigenschaften entspricht ebenfalls der Reihenfolge der
; Parameter von show-set-card.

; Begründung:
; Listen lassen sich in Racket einfach durch Funktionen höherer Ordnung
; verarbeiten.  Sei C die Repräsentation einer Karte.  Da die Reihenfolge und
; die verwendeten Symbole an show-set-card angepasst sind, kann eine Karte
; einfach durch (apply show-set-card C) graphisch dargestellt werden.

; 2.

; Berechnet das Karthesische Produkt von (als Listen repräsentierte) Mengen von
; Werten (Enthält eine der Mengen Listen als Elemente, so werden diese im Zuge
; der Verarbeitung geflattent.):
; (xs, ..., zs) |-> xs X ... X zs
(define (k-product . lsts)

        (define (product ys xs)
                (apply append (map (λ (x) (map (curry list x) ys)) xs)))

        (map flatten (foldl product (car lsts) (cdr lsts))))

; (k-product '(0 2) '(1 3) '(a b))
; '((0 1 a) (0 1 b) (0 3 a) (0 3 b) (2 1 a) (2 1 b) (2 3 a) (2 3 b))


;;(k-product '(0 1) '(a b) '((α β) (μ ν)))
;;'((0 a α β)
;;  (0 a μ ν)
;;  (0 b α β)
;;  (0 b μ ν)
;;  (1 a α β)
;;  (1 a μ ν)
;;  (1 b α β)
;;  (1 b μ ν))

(define ns (list 1 2 3))
(define the-patterns '(waves oval rectangle))
(define the-modes '(outline solid hatched))
(define the-colors '(red green blue))

(define kartenspiel (k-product ns the-patterns the-modes the-colors))

(define (show-cards cs)
        (map (curry apply show-set-card) cs))

; (show-cards kartenspiel)
; viele Bilder


; 3. Testen auf SETs.

; Filtert Duplikate aus einer Liste
; Bsp. '(1 3 3 7) |-> '(1 3 7)
(define (uniq xs)
        (foldl (λ (x l)
                  (if (member x l)
                      l
                      (append l (list x))))
               '()
               xs))


; Transponiert eine Liste von Listen
; Bsp. '((1 2 3) (4 5 6) (7 8 9)) |-> '((1 4 7) (2 5 8) (3 6 9))
(define (transpose xs)
        (apply map list xs))


; Prüft, ob eine Liste von drei Karten ein SET bilden.
(define (is-a-set? cards)
        (andmap (λ (xs)
                   (let ((l (length xs))) (not (= 2 l))))
                (map uniq (transpose cards))))


; (is-a-set? '((2 red oval hatched)
;              (2 red rectangle hatched)
;              (2 red wave hatched)))
; #t

; (is-a-set? '((2 red rectangle outline)
;              (2 green rectangle outline)
;              (1 green rectangle solid)))
; #f


; 4. Zusatzaufgabe:


; Wählt ein zufälliges Element aus der Liste lst.
; Parameter:
; * lst: Liste
; Return: l ∈ lst
(define (choose-random lst)
        (list-ref lst (random (length lst))))

; Wählt n unterschiedliche Elemente aus xs.
; Bedingung: |xs| >= n
(define (choose n xs)
        (if (= n 0) '()
            (let*-values ([(r) (random (length xs))]
                          [(left right) (split-at xs r)])
                         (append (list (car right))
                                 (choose (- n 1) (append left (cdr right)))))))

(define subset (choose 12 kartenspiel))
(show-cards subset)
;subset


; Teilt eine Konkatenation von drei Karten wieder auf.
(define (split xs)
        (let*-values ([(first rest) (split-at xs 4)]
                      [(second third) (split-at rest 4)])
                     (list first second third)))

; < Relation auf Listen, die Symbole und Zahlen enthalten, aber an der i-ten
; Stelle Werte des gleichen Typs.
(define (lsts<? xs ys)
        (cond ((empty? ys) #f)
              ((empty? xs) #t)
              ((eq? (car xs) (car ys)) (lsts<? (cdr xs) (cdr ys)))
              (else ((if (number? (car xs)) < symbol<?) (car xs) (car ys)))))


; Findet alle sets in cs
(define (find-sets cs)
        (let*-values ([(product) (apply k-product (make-list 3 cs))]
                      ; erstelle Triple
                      [(triple) (map split product)]
                      ; nur noch sets
                      [(sets) (filter is-a-set? triple)]
                      ; jede Karte nur einmal
                      [(uniq-cards) (filter (λ (s) (= 3 (length (uniq s)))) sets)]
                      ; Reihenfolgen egal
                      [(sorted-sets) (map (curryr sort lsts<?) uniq-cards)]
                      [(uniq-sets) (uniq sorted-sets)])
                     ;)
                     uniq-sets))
;;
;;(display "\n")
;;
(find-sets subset)
(map show-cards (find-sets subset))


