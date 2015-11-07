#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 3
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2 Das internationale Flaggenalphabet

;(require "./flaggen-module.rkt")
(require se3-bib/flaggen-module)


; 1. Datenstruktur
(define table
        '((#\A . A)
          (#\B . B)
          (#\C . C)
          (#\D . D)
          (#\E . E)
          (#\F . F)
          (#\G . G)
          (#\H . H)
          (#\I . I)
          (#\J . J)
          (#\K . K)
          (#\L . L)
          (#\M . M)
          (#\N . N)
          (#\O . O)
          (#\P . P)
          (#\Q . Q)
          (#\R . R)
          (#\S . S)
          (#\T . T)
          (#\U . U)
          (#\V . V)
          (#\W . W)
          (#\X . X)
          (#\Y . Y)
          (#\Z . Z)
          (#\0 . Z0)
          (#\1 . Z1)
          (#\2 . Z2)
          (#\3 . Z3)
          (#\4 . Z4)
          (#\5 . Z5)
          (#\6 . Z6)
          (#\7 . Z7)
          (#\8 . Z8)
          (#\9 . Z9)))
; TODO: Begründung


; 2. encode
(define (encode c)
        (cdr (assoc c table)))

(encode #\F)
(encode #\O)
(encode #\0)
