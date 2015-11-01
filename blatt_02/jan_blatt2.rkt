#lang racket
;Aufgabe 1
;1. miau
;    >> 'Plueschi
;    miau ist eine Variable, welche das Symbol Plueshi hält.
;
;2. katze
;    >> 'Plueschi
;    katze ist eine Variable, welche den Wert von miau übergeben bekommt.
;
;3. tiger
;    >> 'miau
;    tiger ist eine Variable, welche das Symbol miau hält.
;    
;4. (quote katze)
;    >> 'katze
;    quote ist ein Symbol, es ist die lange schreibweise von 'katze.
;
;5. (eval tiger )
;    >> 'Plueschi
;    eval interpretiert das von tiger zurückgegebene Symbol 'miau als 
;    Definitionsaufruf und ruft somit die Variable miau auf.
;
;6. (eval katze)
;    >> Plueschi: undefined;
;       cannot reference an identifier before its definition
;    katze gibt bereits einen Variablenaufruf zurück, welcher von
;    eval nicht interpretiertwerden kann 
;
;7. (eval ’ tiger )
;    >> 'miau
;    Interpretiert das Symbol 'tiger als Aufruf und gibt somit den Wert
;    von tiger zurück
;
;8. (welcherNameGiltWo ’harry ’potter)
;    >> 'harry
;    PersonA und PersonC werden von let gleichzeitig definiert, wodurch
;    PersonC noch den alten Wert von PersonA ('harry)
;
;9. (cdddr xs1)
;    >> '(miau katze)
;    entspricht (cdr (cdr (cdr x))) und springt somit über die ersten drei
;    Elemente des Sysmbols xs1 und gibt den Rest als Werteliste aus
;
;10. (cdr xs2)
;    >>'(Plueschi)
;    Springt über die erste definition aus der Liste xs2 und ruft somit die
;    Definition von katze auf. Diese werden als Werteliste zurückgegeben.
;
;11. (cdr xs3)
;    >>'Plueschi
;    cons verbindet zwei Elemente. cdr spring über das erste und ruft die 
;    Definition von katze auf
;
;12. (eval (sqrt 3))
;    >>1.7320508075688772
;    Führt Wurzel drei aus.
;
;13. (eval ’(welcherNameGiltWo ’tiger ’katze))
;    >>'tiger
;    Identisch mit 8. Eval Interpretiert das Erste Argument als Definition und 
;    ruft es Argument auf .
;
;14. (eval (welcherNameGiltWo ’katze ’tiger ))
;    >>’katze: undefined; cannot reference an identifier before its definition
;    Eval interpretiert nur das erste Argument, 'tiger ist somit nicht 
;    definiert

;Aufgabe 2

;2.1 - Die Fakultät einer Zahl
(define (fak x)
  (cond
    [(= x 0) 1]
    [else (* x (fak (- x 1)))]
    ))

; 2.2 - Potenzen von Rationalzahlen
(define (power r n)
  (cond
    [(integer? n) (cond
      [(= n 0) 1]
      [(cond
         [(even? n) (sqr (power r (/ n 2)))]
         [else (* r (power r (- n 1)))]
         )]
      )]
    [else (display "n muss eine natürliche Zahl sein")]
    ))

; 2.3 Die Eulerzahl e

(define (euler-helper n max)
  (cond
    [(<= n max) (+ (/ n (fak (- n 1))) (euler-helper (add1 n) max))]
    [else 0]))

(define euler
  (* (expt 10 1001) (/ (euler-helper 1 1000) 2)))

;2.4 Pi

;Hilfsfunktion für pi rekusion
(define (rek-pi n s)
  (if ( > n 10000000) 0 ;mit diesem wert für n ist pi=3.1415924535897934 
  ;(Für mehr reichen 4GB Speicher nicht!)
      (+ (/ (* s 1) n) (rek-pi (+ 2 n) (* -1 s)))))
      
      
(define (pi)
  (* 4 (rek-pi 1.0 1)))
;Pi ist langsamer, da die Reihe, welche für die Eulerfunktion genutzt wird 
;schneller konvergiert!

;Aufgabe 3
(define (type-of o)
  (cond
    [(boolean? o) 'boolean]
    [(pair? o) 'pair]
    [(list? o) 'list]
    [(symbol? o) 'symbol]
    [(number? o) 'number]
    [(char? o) 'char]
    [(string? o) 'string]
    [(vector? o) 'vector]
    [(procedure? o) 'procedure]
    [else 'error]))

;Ausgaben
;
;> (type-of (* 2 3 4))
;'number
;> (type-of (not 42))
;'boolean
;> (type-of '(eins zwei drei))
;'pair
;> (type-of '())
;'list
;> (define (id z) z)
;> (type-of (id sin))
;'procedure
;> (type-of (string-ref "Harry Potter und der Stein der Weisen" 3))
;'char
;> (type-of (lambda (x) x))
;'procedure
;> (type-of type-of)
;'procedure
;> (type-of (type-of type-of))
;'symbol