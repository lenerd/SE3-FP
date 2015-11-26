#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 6
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.1: Insertion-Sort


(define (insertion-sort xs rel<?)
        
        (define (helper xs pos)
                (if (= pos (length xs))
                    xs
                    (let*-values ([(sorted rest) (split-at xs pos)]
                                  [(x) (car rest)]
                                  [(left right) (splitf-at sorted (curryr rel<? x))])
                                 (helper (append left (list x) right (cdr rest))
                                         (+ 1 pos)))))
                

        (helper xs 1))


(provide insertion-sort)


; (insertion-sort (list 3 5 1 2 4) <)
; '(1 2 3 4 5)
