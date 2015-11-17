#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 5
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 1: Mendels Land

(require se3-bib/butterfly-module)
(require racket/trace)

; Funktionen
; * Genotyp -> Phänotyp (Gen und Genom)
; * vererben diploid -> haploid
; * kinder machen
; 
; Datenstrukturen:
; * Genotyp

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


(define characteristics '(red green blue yellow 
                          dots stripes star 
                          straight curved curly
                          rhomb hexagon ellipse))

(define (dominant a b)
        (if (> (length (memq a characteristics))
               (length (memq b characteristics)))
            a
            b))

(define (choose-random lst)
        (list-ref lst (random (length lst))))

(define (genotyp->phaenotyp genome)
        (map (λ (ab) (apply dominant ab)) genome))

(define (diploid->haploid genome)
        (map choose-random genome))

(define (zip xs ys)
        (map list xs ys))

(define (make-child p1 p2)
        (zip (diploid->haploid p1)
             (diploid->haploid p2)))

(define (make-children p1 p2 n)
        (if (= n 0) '()
            (cons (make-child p1 p2) (make-children p1 p2 (- n 1)))))

(define (show-butterflies bs)
        (map (λ (g) (apply show-butterfly (genotyp->phaenotyp g)))
             bs))
        

(show-butterflies (list mother father))
(show-butterflies (make-children mother father 3))
