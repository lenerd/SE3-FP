#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 10
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Lennart Braun
; Aufgabe 1: Sudoku

(require 2htdp/image)


; Aufgabe 1.1: Konsistenz eines Spielzustands


(define spiel #(0 0 0 0 0 9 0 7 0
                0 0 0 0 8 2 0 5 0
                3 2 7 0 0 0 0 4 0
                0 1 6 0 4 0 0 0 0
                0 5 0 0 0 0 3 0 0
                0 0 0 0 9 0 7 0 0
                0 0 0 6 0 0 0 0 5
                8 0 2 0 0 0 0 0 0
                0 0 4 2 0 0 0 0 8))

; 1.

; Wandelt Indizes im zweidimensionalen Spielfeld in eindimensionalen Index des
; Vektors um.
(define (xy->index x y)
        (+ x (* y 9)))

; Wandelt Indizes im eindimensionalen Vektor in zweidimensionale Indizes des
; Spielfeldes um.
(define (index->xy i)
        (list (remainder i 9)
              (quotient i 9)))


; 2.
; Gibt Indizes der y-ten Zeile.
(define (zeile->indizes y)
        (build-list 9 (curry + (* y 9))))


; Gibt Indizes der x-ten Spalte.
(define (spalte->indizes x)
        (build-list 9 (compose (curry + x) (curry * 9))))


; Gibt Indizes des n-ten Quadranten (links nach rechts, oben nach unten).
(define (quadrant->indizes n)
        (let ((x (remainder n 3))
              (y (quotient n 3)))
             (map (curry + (* x 3) (* y 27))
                  '(0 1 2 9 10 11 18 19 20))))


; Liste der definierten Indexfunktionen
(define index-functions (list zeile->indizes
                              spalte->indizes
                              quadrant->indizes))


; Erstellt Liste mit allen Indexgruppen.
(define (index-parts)
        (apply append (map (curryr map (range 9)) index-functions)))


; 3.
; Gibt die Einträge auf dem Spielfeld an den gegebenen Indizes.
(define (spiel->eintraege feld idxs)
        (map (curry vector-ref feld) idxs))

; Erstellt Liste mit allen Gruppen des Feldes.
(define (entry-parts feld)
        (map (curry spiel->eintraege feld) (index-parts)))



; 4.
; Prüft, ob das Spiel in einem konsistenten Zustand ist.
(define (spiel-konsistent? spiel)
        (andmap (compose not 
                         (curryr check-duplicates
                                 (λ (a b) (and (eq? a b) (> a 0)))))
                (entry-parts spiel)))


; Prüft, ob das Spiel gelöst ist.
(define (spiel-geloest? spiel)
        (and (spiel-konsistent? spiel) (not (vector-member 0 spiel))))



; Aufgabe 1.2: Sudoku lösen (ohne Backtracking)

; 1.
; Markiert alle Positionen aus feld, in denen der Wert n nicht stehen darf mit
; einem 'X
(define (markiere-ausschluss feld n)

        ; Ersetzt from durch to im Vektor vec an den Indizes idxs
        (define (vector-replace! vec idxs from to)
                (map (λ (i) (when (eq? (vector-ref vec i) from)
                                  (vector-set! vec i to)))
                     idxs))

        ; Markiert Positionen in einzelnen Gruppen.
        (define (helper mark-feld idxs)
                (if (member n (spiel->eintraege mark-feld idxs))
                    (begin (vector-replace! mark-feld idxs 0 'X)
                           #t)
                    #f))

        (let ((mark-feld (vector-copy feld)))
             (map (curry helper mark-feld)
                  (index-parts))
             mark-feld))



; 2.
; Bestimmt Positionen auf dem Feld, an denen auf jeden Fall n stehen muss.
(define (eindeutige-positionen feld n)

        ; Bestimmt Positionen in einer Gruppe, an denen auf jeden Fall n stehen
        ; muss.
        (define (positionen-part marked idxs)
                (let* ((marked-xs (spiel->eintraege marked idxs)))
                      (if (= 1 (count (curry eq? 0) marked-xs))
                          (list (list-ref idxs (- 9 (length (member 0 marked-xs)))))
                          '())))

        (let ((marked (markiere-ausschluss feld n)))
             (remove-duplicates (apply append
                                       (map (curry positionen-part marked)
                                            (index-parts))))))


; 3.
; Löst das Sudoku.
; Falls hook callable ist, führe es je einmal zu Beginn und zum Ende mit dem
; Feld aus ist always #t, rufe hook nach jeder Iteration.
(define loese-spiel (λ (feld [hook 0] [always #f])

        ; Löst das Sudoku auf einer veränderbaren Kopie der Eingabe.
        (define (loese mutable-feld)
                (let ((poss (flatten (apply append
                                            (map (λ (n)
                                                    (map (curryr cons n)
                                                         (eindeutige-positionen mutable-feld
                                                                                n)))
                                                 (range 1 10))))))
                     (cond [(not (empty? poss))             ; Weiter machen.
                            (when (and (procedure? hook) always)
                                  (hook mutable-feld))
                            (apply (curry vector-set*! mutable-feld) poss)
                            (loese mutable-feld)]
                           [(spiel-geloest? mutable-feld)   ; Fertig
                            (display "Done\n")
                            mutable-feld]
                           [else                            ; Nicht lösbar.
                            (display "Failed\n")])))

        (let ((feld-cpy (vector-copy feld)))
             (when (procedure? hook) (hook feld-cpy))
             ((λ (feld) (when (procedure? hook) (hook feld))
                        feld)
              (loese feld-cpy))
             )))


; (loese-spiel spiel)



; Aufgabe 1.3: Grafische Ausgabe

; 1.
; In 1.2.2 steht nicht von annotierten Spielfeldern.
; Felder mit eindeutiger Belegung gemeint?

; Zeichnet das Spielfeld feld.
(define (zeichne-spiel feld)
        (define (draw-number n)
                (text (number->string n) 8 "black"))

        (define (get-pen x)
                (if (= 0 (remainder x 3))
                    (make-pen "black" 1 "solid" "round" "round")
                    "black"))

        (define (draw-grid)
          (foldl (λ (x img) (add-line img (* 10 x) 0 (* 10 x) 90 (get-pen x)))
                 (foldl (λ (x img) (add-line img 0 (* 10 x) 90 (* 10 x) (get-pen x)))
                        (rectangle 90 90 "solid" "white")
                        (range 10))
                 (range 10)))

        (define (place-number n grid idx)
                (let ((xy (index->xy idx)))
                     (underlay/offset grid
                                      (* 10 (- (car xy) 4))
                                      (* 10 (- (cadr xy) 4))
                                      (draw-number n))))

        (scale 5 (foldl (λ (n idx img) (if (> n 0) (place-number n img idx)
                                                   img))
                        (draw-grid)
                        (map (curry vector-ref feld) (range 81))
                        (range 81))))

; (zeichne-spiel spiel)
; (zeichne-spiel (loese-spiel spiel))


; 2.

(define (printer feld)
        (begin (display (zeichne-spiel feld))
               (display "\n")
               feld))


; Lört Sudoku mit Ausgabe.
(define (loese-spiel-grafisch feld short)

        (define (printer feld)
                (begin (display (zeichne-spiel feld))
                       (display "\n")
                       feld))

        (loese-spiel feld printer (not short)))


; (loese-spiel-grafisch spiel #t)
; (loese-spiel-grafisch spiel #f)

