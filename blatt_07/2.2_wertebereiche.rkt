#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 7
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2.2: Wertebereiche


; Rescaled xs auf interval.
(define (rescale1d xs interval)
        (map (λ (x) (+ (car interval) 
                       (* (/ x (apply max xs))
                          (- (cdr interval) (car interval)))))
             xs))
        

(define (zip-pairs->lists ps)
        (list (map car ps) (map cdr ps)))
(define (zip-lists->pairs ps)
        (apply map cons ps))


; Rescaled doppelt.
(define (rescale2d xys xinterval yinterval)
        (zip-lists->pairs (map rescale1d (zip-pairs->lists xys) (list xinterval yinterval))))
        


; (rescale1d '(0 2 4 6 8) '(10 . 50))
;(rescale1d '(0 2 4 6 8) '(10 . 50))
;(rescale1d '(0 4 16 36 64) '(5 . 25))
;(rescale2d '((0 . 0) (2 . 4) (4 . 16) (6 . 36) (8 . 64))
;           '(10 . 50)
;           '(5 . 25))


(provide rescale2d zip-pairs->lists)
