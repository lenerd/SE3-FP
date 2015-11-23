#!/usr/bin/env racket
#lang racket

; SE3 FP Übungsblatt 5
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 2: Ein Vaterschaftstest

; Sieht man dem Kind ein Merkmal an, so muss mindestens ein Elternteil das
; entsprechende Genom weitergegeben haben.
; Hat nun das Kind ein Merkmal, dass die sichtbaren Merkmale der Eltern
; dominiert, so kann es nicht von dem Elternpaar abstammen (mindestens ein
; Elternteil ist nicht das richtige).

(require "./1_Mendels_Land.rkt")


; Phänotyp von Antonia
(define antonia-pheno
        '(blue stripes curved hexagon))

; Phänotyp von Anton
(define anton-pheno
        '(green star curly rhomb))

; Phänotyp von Toni
(define toni-pheno
        '(red star curved hexagon))

; Phänotyp von Tini
(define tini-pheno
        '(green dots straight rhomb))

; Phänotyp von Tina
(define tina-pheno
        '(yellow stripes curly ellipse))


; Vaterschaftstest
; Wird true zurückgegeben, so ist der Test angeschlagen das Kind stammt nicht
; (nur) von diesem Elternpaar ab.
; Wird false zurückgegeben, so kann aufgrund des Aussehens nichts über das
; Verwandtschaftsverhältnis ausgesagt werden.
(define (test pheno-p1 pheno-p2 pheno-c)

        (define (test-characteristic p1c p2c cc)
                (> (length (memq cc characteristics))
                   (max (length (memq p1c characteristics))
                        (length (memq p2c characteristics)))))

        (ormap test-characteristic pheno-p1 pheno-p2 pheno-c))
        

; (test antonia-pheno anton-pheno toni-pheno)
; #t
; Toni ist nicht das Kind von Antonia und Anton, da seine Flügel rot sind und
; blau und grün von rot dominiert werden.
; (test antonia-pheno anton-pheno tini-pheno)
; #t
; Tini ist nicht das Kind von Antonia und Anton, da ihre geraden Fühler und
; die Punkte auf ihren Flügen nicht von Antonia oder Anton vererbt worden sein
; können.
; (test antonia-pheno anton-pheno tina-pheno)
; #f
; Tina könnte das Kind von Antonia und Anton sein.
