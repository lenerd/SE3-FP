#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 5
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2: Ein Vaterschaftstest

(require "./1_Mendels_Land.rkt")


(define antonia-pheno
        '(blue stripes curved hexagon))

(define anton-pheno
        '(green star curly rhomb))

(define toni-pheno
        '(red star curved hexagon))

(define tini-pheno
        '(green dots straight rhomb))

(define tina-pheno
        '(yellow stripes curly ellipse))

(define (test-characteristic p1c p2c cc)
        (> (length (memq cc characteristics))
           (max (length (memq p1c characteristics))
                (length (memq p2c characteristics)))))

(define (test pheno-p1 pheno-p2 pheno-c)
        (ormap test-characteristic pheno-p1 pheno-p2 pheno-c))
        

(test antonia-pheno anton-pheno toni-pheno)
(test antonia-pheno anton-pheno tini-pheno)
(test antonia-pheno anton-pheno tina-pheno)
