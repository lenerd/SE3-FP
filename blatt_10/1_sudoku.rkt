#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 10
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Lennart Braun
; Aufgabe 1: Sudoku


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


(define index-functions (list zeile->indizes
                              spalte->indizes
                              quadrant->indizes))


; 3.
; Gibt die Einträge auf dem Spielfeld an den gegebenen Indizes.
(define (spiel->eintraege feld idxs)
        (map (curry vector-ref feld) idxs))


; 4.
; Prüft, ob das Spiel in einem konsistenten Zustand ist.
(define (spiel-konsistent? spiel)

        ; Prüft, ob ein/e Zeile/Spalte/Quadrant konsistent ist.
        (define (konsistent-part? x idx-func)
                (not (check-duplicates (spiel->eintraege spiel (idx-func x))
                                       (λ (a b) (and (eq? a b) (> a 0))))))

        ; Prüft, ob Zeile/Spalte/Quadrant mit Index x jeweils konsistent ist.
        (define (konsistent-index? x)
                (andmap (curry konsistent-part? x) index-functions))

        (andmap konsistent-index? (range 9)))


; Prüft, ob das Spiel gelöst ist.
(define (spiel-geloest? spiel)
        (and (spiel-konsistent? spiel) (not (vector-member 0 spiel))))



; Aufgabe 1.2: Sudoku lösen (ohne Backtracking)

; 1.
; Markiert alle Positionen aus feld, in denen der Wert n nicht stehen darf mit
; einem 'X
(define (markiere-ausschluss feld n)

        
        (define (vec-replace! vec idxs from to)
                (map (λ (i) (when (eq? (vector-ref vec i) from)
                                  (vector-set! vec i to)))
                     idxs))

        (define (mark-part mark-feld x idx-func)
                (if (member n (spiel->eintraege mark-feld (idx-func x)))
                    (begin (vec-replace! mark-feld (idx-func x) 0 'X)
                           #t)
                    #f))

        (define (mark-index mark-feld x)
                (map (curry mark-part mark-feld x) index-functions))

        (let ((mark-feld (vector-copy feld)))
             (map (curry mark-index mark-feld) (range 9))
             ;(vector-set! mark-feld 42 'X)
             mark-feld))


(define spielm #(0 X 0 0 0 9 X 7 X
                 X X X X 8 2 X 5 X
                 3 2 7 0 0 0 X 4 X
                 X 1 6 0 4 0 0 X X
                 X 5 X X X X 3 X X
                 X X X 0 9 0 7 X X
                 X X X 6 X X X X 5
                 8 X 2 0 0 0 X X X
                 0 X 4 2 0 0 X X 8))

; 2.
; TODO
(define (eindeutige-positionen feld n)

        (define (positionen-part marked x idx-func)
                (let* ((marked-xs (spiel->eintraege marked (idx-func x)))
                       (free (- 9 (length (or (member 0 marked-xs) '())))))
                      (if (= 1 (count (curry eq? 0) marked-xs))
                          (list (list-ref (idx-func x) free))
                          '())))

        (define (positionen-index marked x)
                (foldl append '() (map (curry positionen-part marked x) index-functions)))

        (let ((marked (markiere-ausschluss feld n)))
             (remove-duplicates (foldl append '() (map (curry positionen-index marked) (range 9))))))



; 3.
; TODO
(define (loese-spiel feld)

        (define (loese mutable-feld)
                (let ((positions (flatten (foldl append
                                                 '()
                                                 (map (λ (n)
                                                         (map (curryr cons n)
                                                              (eindeutige-positionen mutable-feld n)))
                                                      (range 1 10))))))
                     (cond [(not (empty? positions)) (apply (curry vector-set*! mutable-feld)
                                                            positions)
                                                     (loese-spiel mutable-feld)]
                           [(spiel-geloest? mutable-feld) (display "Done\n")
                                                      mutable-feld]
                           [else (display "Failed\n")])))

        (let ((feld-cpy (vector-copy feld)))
             (loese feld-cpy)))


(loese-spiel spiel)
