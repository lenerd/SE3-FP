#!/usr/bin/env racket
#lang swindle
; SE3 FP Übungsblatt 9
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Lennart Braun
; Aufgabe 2: CLOS und Vererbung

(require swindle/setf)
(require swindle/misc)


; Aufgabe 2.2: Operationen und Methodenkombination

; Medien, in denen sich ein Fahrzeug bewegen kann.
(defgeneric* medien ((f Fahrzeug))
             :combination generic-append-combination)
; Ein Subfahrzeug kann mindestens sich in allen Medien der Superfahrzeuge
; bewegen. Eine Menge wäre eventuell sinnvoller als eine Liste.

; Maximalgeschrindigkeit, mit der sich ein Fahrzeug bewegen kann.
(defgeneric* max-velocity ((f Fahrzeug))
             :combination generic-max-combination)
; Die Maximalgeschwindigkeit eines Fahrzeuges entspricht dem Maximum über den
; Maximalgeschwindigkeiten in den einzelnen Medien.

; Maximale Zuladung, so dass es sich noch flexibel bewegen kann.
(defgeneric* zuladung ((f Fahrzeug))
             :combination generic-min-combination)
; Die maximale Zuladung eines Fahrzeuges, bei der dieses sich noch in allen
; Medien bewegen kann, entspricht dem Minimum über den Maximalzuladungen in den
; einzelnen Medien.


; Obere Schranke des Verbrauchs auf 100 km.
(defgeneric* verbrauch ((f Fahrzeug))
             :combination generic-max-combination)
; Der Verbrauch wird durch das Maximum über den Verbrauchen in den einzelnen
; Medien beschränkt.


; Maximale Passagierzahl, so dass es sich noch flexibel bewegen kann.
(defgeneric* passagierzahl ((f Fahrzeug))
             :combination generic-min-combination)
; Die maximale Passagierzahl eines Fahrzeuges, bei der dieses sich noch in
; allen Medien bewegen kann, entspricht dem Minimum über den maximalen
; PAssagierzahlen in den einzelnen Medien.


; Aufgabe 2.1: Definition von Klassen
; (inklusive Slots für Aufgabe 2.3)

(defclass* Fahrzeug ()
           :printer #t
)

(defclass* LandFahrzeug (Fahrzeug)
           (max-velocity-land
             :initarg :max-velocity-land
             :initvalue 0
             :type <integer>
             :reader max-velocity
             )
           (medien-land
             :initvalue '(land)
             :type <list>
             :reader medien
             )
)

(defclass* WasserFahrzeug (Fahrzeug)
           (max-velocity-wasser
             :initarg :max-velocity-wasser
             :initvalue 0
             :type <integer>
             :reader max-velocity
             )
           (medien-wasser
             :initvalue '(wasser)
             :type <list>
             :reader medien
             )
)

(defclass* LuftFahrzeug (Fahrzeug)
           (max-velocity-luft
             :initarg :max-velocity-luft
             :initvalue 0
             :type <integer>
             :reader max-velocity
             )
           (medien-luft
             :initvalue '(luft)
             :type <list>
             :reader medien
             )
)

(defclass* SchienenFahrzeug (LandFahrzeug)
           (max-velocity-schiene
             :initarg :max-velocity-schiene
             :initvalue 0
             :type <integer>
             :reader max-velocity
             )
           (medien-schiene
             :initvalue '(schiene)
             :type <list>
             :reader medien
             )
)

(defclass* StraßenFahrzeug (LandFahrzeug)
           (max-velocity-straße
             :initarg :max-velocity-straße
             :initvalue 0
             :type <integer>
             :reader max-velocity
             )
           (medien-straße
             :initvalue '(straße)
             :type <list>
             :reader medien
             )
)

(defclass* AmphibienFahrzeug (WasserFahrzeug LandFahrzeug)
)

(defclass* AmphibienflugFahrzeug (LuftFahrzeug AmphibienFahrzeug)
)

(defclass* ZweiwegeFahrzeug (StraßenFahrzeug SchienenFahrzeug)
)

(defclass* Zeitzug (SchienenFahrzeug LuftFahrzeug)
)


; Aufgabe 2.3: Klassenpräzedenz bei Mehrfachvererbung
(define amph (make AmphibienFahrzeug :max-velocity-wasser 47
                                     :max-velocity-land 53))
(define amphluft (make AmphibienflugFahrzeug :max-velocity-wasser 59
                                             :max-velocity-land 47
                                             :max-velocity-luft 61))
(define zweiwege (make ZweiwegeFahrzeug :max-velocity-straße 67
                                        :max-velocity-schiene 47))
(define zeitzug (make Zeitzug :max-velocity-luft 71
                              :max-velocity-schiene 47
                              :max-velocity-land 73))

; max-velocity implementiert mit Slots max-velocity-...
; medien implementiert mit Slots medien-...
; (display (max-velocity amph))
; (display "\n")
; (display (medien amph))
; (display "\n")
; > 53
; > (wasser land)

; Die Klassenpräzedenzliste ist eine Ordnung über den Superklassen einer
; Klasse.  Diese ist wie folgt definiert:
; 1. Spezifischere Klassen vor allgemeineren Klassen
; 2. Superklassen in den Klassendefinitionen der Subklassen von links nach
;    rechts
; -> DFS-mäßig den Vererbungs-DAG nach oben durchgehen, dabei 1. Regel
;    beachten.

; Im Normalfall wird die Methodenimplementation der ersten Superklasse in der
; Klassenpräzedenzliste geerbt.  Mittels der Methodenkombination lassen sich
; mehrere Implementationen kombinieren.  Beispielsweise wird durch
; ":combination generic-max-combination" das Maximum der Rückgabewerte der
; geerbten Methoden gebildet (ähnlich wie foldl/r über eine Liste der
; Rückgabewerte nach der Klassenpräzedenz).
