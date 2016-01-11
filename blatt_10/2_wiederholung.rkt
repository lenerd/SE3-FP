#!/usr/bin/env racket
#lang racket
; SE3 FP Übungsblatt 10
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Lennart Braun
; Aufgabe 2: Wiederholung, Klausurvorbereitung

; 1.
; (a)
;(max (min 2 (- 2 3)))
;-1

; (b)
;'(+ ,(- 2 4) 2)
;'(+ ,(- 2 4) 2)

; (c)
;(car '(Alle meine Entchen))
;'Alle

; (d)
;(cdr '(schwimmen auf (dem See)))
;'(auf (dem See))

; (e)
;(cons 'Listen '(sind einfach))
;'(Listen sind einfach)

; (f)
;(cons 'Paare 'auch)
;'(Paare . auch)

; (g)
;(equal? (list 'Racket 'Prolog 'Java)
;        '(Racket Prolog Java))
;#t
; equal? testet auf Gleichheit.

; (h)
;(eq? (list 'Racket 'Prolog 'Java)
;     (cons 'Racket '(Prolog Java)))
;#f
; eq? testet auf Identität.

; (i)
;(map (lambda (x) (* x x x))
;     '(1 2 3))
;'(1 8 27)

; (j)
;(filter odd? '(1 2 3 4 5))
;'(1 3 5)

; (k)
;((curry min 6) 2)
;2

; (l)
;((curry = 2) 2)
;#t



; 2.
(define *a* 10)
(define *b* *a*)
(define (merke x) (lambda () x))
(define (test x)
        (let ((x (+ x *a*)))
             (+ x 2)))  ; <- angenommen da fehlte eine Klammer

; (a)
;*a*
;10

; (b)
;(+ *a* *b*)
;20

; (c)
;(+ (eval *a*) (eval *b*))
;20 in der REPL, funktioniert nicht im Skript

; (d)
;(and (> *a* 10) (> *b* 3))
;#f

; (e)
;(or (> *a* 10) (/ *a* 0))
; Exception: division by zero

; (f)
;(+ 2 (merke 3))
; Exception: contract violation  <- Number + Function

; (g)
;(+ 2 ((merke 3)))
;5

; (h)
;(test 4)
;16



; 3.
; (a)
;(+ (* 3 4) (* 5 6))

; (b)
;(λ (x) (sqrt (- 1 (sqr (sin x)))))



; 4.

;(define (c a b)
;        (sqrt (+ (sqr a) (sqr b))))

;(define (mytan α)
;        (/ (sin α) (sqrt (- 1 (sqr (sin α))))))


; 5.
; (a)
;(+ 1 (/ 4 2) (- 1))

; (b)
;(/ (- 2 (/ (+ 1 3) (+ 3 (* 2 3)))) (sqrt 3))



; 6.
;(1 + 2 + 3 ) * (2 - 3 - (2 - 1))



; 7.
; Sei square wie folgt definiert.
(define (square x) (* x x))
; (a)
; Bei der inneren Reduktion werden Ausdrücke von innen nach außen evaluert.
; Beispiel:
;(square (+ 1 2 3))
;(square 6)
;(* 6 6)
;36

; Bei der äußeren Reduktion geschieht dies anders herum.
; Beispiel:
;(square (+ 1 2 3))
;(* (+ 1 2 3) (+ 1 2 3))
;(* 6 6)
;36

; (b)
; Wenn eine Funktion bei gleicher Eingabe immer die gleiche Ausgabe liefert
; (Bezugstransparenz), führen innere und äußere Reduktion zum gleichen
; Ergebnis.
; Eine Fallunterscheidung (z.B. durch if) zum Abbruch einer Rekursion ist durch
; die Auswertung mit äußerer Reduktion angewiesen, da die Rekursion sonst unter
; Umständen nicht enden würde.


; 8.
(define (laengen-rek xss)
        (if (empty? xss)
            '()
            (cons (length (car xss)) (laengen-rek (cdr xss)))))

(define (laengen-end xss)

        (define (helper xss acc)
                (if (empty? xss)
                    acc
                    (helper (cdr xss) (append acc (list (length (car xss)))))))

        (helper xss '()))


; 9.
; (a)
(define make-length list)
;(make-length 3 'cm)

; (b)
(define value-of-length car)
(define unit-of-length cadr)
;(value-of-length (make-length 3 'cm))
;(unit-of-length (make-length 3 'cm))

; (c)
; Skalierung
(define (scale-length len fac)
        (make-length (* fac (value-of-length len)) (unit-of-length len)))
;(value-of-length (scale-length (make-length 3 'cm) 2))

; (d)
(define *conversiontable* ;
        '( ; (unit . factor)
          (m . 1)
          (cm . 0.01)
          (mm . 0.001)
          (km . 1000)
          (inch . 0.0254)
          (feet . 0.3048)
          (yard . 0.9144)))

; Auslesen des Umrechungsfactors
(define factor (compose cdr (curryr assoc *conversiontable*)))
;(factor 'mm)


; Umwandlung in Meter
(define (length->meter len)
        (make-length ((compose (curry * (value-of-length len))
                               factor
                               unit-of-length)
                      len)
                     'm))
;(length->meter '(3 cm))


; kleiner-als über Längen
(define (length< . lens)
        (apply < (map (compose value-of-length length->meter) lens)))
; gleich über Längen
(define (length= . lens)
        (apply = (map (compose value-of-length length->meter) lens)))

;(length< '(3 cm) '(6 km))
;(length= '(300 cm) '(3 m))


(define (_length-arith func . lens)
        (make-length (apply func (map (compose value-of-length length->meter) lens))
                     'm))

; Addition über Längen
(define length+ (curry _length-arith +))
; Subtraktion über Längen
(define length- (curry _length-arith -))
;(length+ '(3 cm) '(1 km))
;(length- '(1.001 km) '(1 m))

; (e)
(define lens '((6 km) (2 feet) (1 cm) (3 inch)))

; Liste der Längen in Metern.
;(map length->meter lens)

; Liste der Längen, die kürzer als 1 m sind.
;(filter (curryr length< '(1 m)) lens)

; Summe aller Längen
;(apply length+ lens)

; Kürzeste Länge.
;(foldl (λ (a b) (if (length< a b) a b)) (car lens) (cdr lens))
