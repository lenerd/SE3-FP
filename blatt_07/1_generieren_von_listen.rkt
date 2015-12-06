#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 7
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Jan-Hendrik Briese, Lennart Braun, Felix Gebauer
; Aufgabe 1: Generieren von Listen


(define (range1 interval n)
        (let ((step (/ (- (cdr interval)
                          (car interval))
                       n)))
             (define (helper i)
                     (if (= i n) '()
                         (cons (+ (car interval) (* i step)) (helper (+ i 1)))))
             (helper 0)))
                    

(define (range2 interval n)
        (let ((step (/ (- (cdr interval)
                          (car interval))
                       n)))

             (define (helper cur n i)
                     (if (= n i) cur
                         (helper (cons (- (car cur) step)
                                       cur)
                                 n
                                 (+ i 1))))
             
             (helper (list (- (cdr interval) step))
                     n
                     1)))


(define (range3 interval n)
        (let ((step (/ (- (cdr interval)
                          (car interval))
                       n)))
             (map (curry + (car interval))
                  (build-list n (curry * step)))))


; (range1 '(0 . 10) 5)
; (range1 '(0 . 10) 4)
; (range1 '(10 . 20) 5)
; (range1 '(0 . 15) 5)
; 
; (range2 '(0 . 10) 5)
; (range2 '(0 . 10) 4)
; (range2 '(10 . 20) 5)
; (range2 '(0 . 15) 5)
; 
; (range3 '(0 . 10) 5)
; (range3 '(0 . 10) 4)
; (range3 '(10 . 20) 5)
; (range3 '(0 . 15) 5)
; (range3 '(15 . 0) 5)


(provide (rename-out [range3 range]))
