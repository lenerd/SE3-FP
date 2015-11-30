#!/usr/bin/env racket
#lang racket


(require 2htdp/image)
(require "./tannenbaum.rkt")


; Generiert eine Koch-Kurve
; Parameter:
; * len   initiale Seitenlänge
; * color Farbe
; * n     Anzahl Rekursionsschritte
; * thing Funktion, die Länge und Farbe als Parameter nimmt und etwas malt.
(define (koch-line len color n thing)
        (if (= n 0)
            (thing len color)
            (let ((subline (koch-line (/ len 3) color (- n 1) thing)))
                 (beside/align "bottom"
                               subline
                               (rotate 60 subline)
                               (rotate -60 subline)
                               subline))))
            

; Erstellt eine Koch-Flocke aus Dingen
; Parameter:
; * len   initiale Seitenlänge
; * color Farbe
; * n     Anzahl Rekursionsschritte
; * thing Funktion, die Länge und Farbe als Parameter nimmt und etwas malt.
(define (koch-thing len color n thing)
        (let ((line (koch-line len color n thing)))
             (above line
                    (beside (rotate 120 line)
                            (rotate -120 line)))))


; Erstellt eine klassische Koch-Flocke
; Parameter:
; * len   initiale Seitenlänge
; * color Farbe
; * n     Anzahl Rekursionsschritte
(define (koch-flake len color n) (koch-thing len
                                             color
                                             n
                                             (λ (len color)
                                                (line len 0 color))))

; Erstellt eine Koch-Flocke aus Tannenbäumen
; Parameter:
; * len   initiale Seitenlänge
; * color Farbe
; * n     Anzahl Rekursionsschritte
(define (koch-trees len n) (koch-thing len
                                       "black"
                                       n
                                       (λ (len color)
                                          (baum (* 2 len) (* 4 len) #f))))


; Erstellt eine Koch-Flocke aus Koch-Flocken
; Parameter:
; * len   initiale Seitenlänge
; * color Farbe
; * n     Anzahl Rekursionsschritte
(define (koch^2-flake len color n)
        (koch-thing len color n (λ (len color) (koch-flake len color n))))


; Erstellt m ineinanderliegende, verdrehte Koch-Flocken aus Bäumen der
; Rekursionstiefe n.
; TODO: besseren Namen finden
(define (wtf len n m)
        (define (helper current m)
                (if (= m 0)
                    empty-image
                    (let ((new (rotate -15 (scale 0.6 current))))
                         (overlay new
                                  (helper new (- m 1))))))
        (helper (koch-trees len n) m))


(provide koch-trees koch-flake wtf koch^2-flake)
