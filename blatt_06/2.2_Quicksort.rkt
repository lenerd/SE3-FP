#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 6
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.2: Quicksort


(define (quicksort xs rel<?)
        
        (define (pick-pivot xs) (car xs))
                
        (if (<= (length xs) 1)
            xs
            (let ((pivot (pick-pivot xs)))
                 (append (quicksort (filter (curryr rel<? pivot) xs) rel<?)
                         (filter (λ (x) (not (or (rel<? pivot x)
                                                 (rel<? x pivot))))
                                 xs)
                         (quicksort (filter (curry rel<? pivot) xs) rel<?)))))


(provide quicksort)


; (quicksort (list 3 5 1 2 4) <)
; '(1 2 3 4 5)
