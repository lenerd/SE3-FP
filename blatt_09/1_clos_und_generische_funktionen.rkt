#!/usr/bin/env racket
#lang swindle
; SE3 FP Übungsblatt 9
; Gruppe 14 (Do. 10-12 Uhr R-031) bei David Mosteller
; Lennart Braun
; Aufgabe 1: CLOS und generische Funktionen

(require swindle/setf)
(require swindle/misc)

; Aufgabe 1.1: Definition von Klassen

(defclass* Veröffentlichung ()
    (Schlüssel
        :type <string>
        :initarg :Schlüssel
    )
    (Titel
        :type <string>
        :initarg :Titel
        :reader Titel
    )
    (Autoren
        :type <list>
        :initarg :Autoren
        :reader Autoren
    )
    (Jahr
        :type <integer>
        :initarg :Jahr
        :reader Jahr
    )
    :printer #t
    :documentation "Repräsentiert eine wissenschaftliche Veröffentlichung."
)

(defclass* Buch (Veröffentlichung)
    (Verlag
        :type <string>
        :initarg :Verlag
        :reader Verlag
    )
    (Verlagsort
        :type <string>
        :initarg :Verlagsort
        :reader Verlagsort
    )
    (Reihe
        :type <string>
        :initarg :Reihe
        :reader Reihe
    )
    (Seriennummer
        :type <integer>
        :initarg :Seriennummer
        :reader Seriennummer
    )
    :documentation "Repräsentiert ein Buch."
)

(defclass* Sammelband (Buch)
    (Herausgeber
        :type <string>
        :initarg :Herausgeber
        :reader Herausgeber
    )
    (Seitenangabe
        :type <integer>
        :initarg :Seitenangabe
        :reader Seitenangabe
    )
    :documentation "Repräsentiert einen Sammelband."
)

(defclass* Zeitschriftenartikel (Veröffentlichung)
    (Zeitschrift
        :type <string>
        :initarg :Zeitschrift
        :reader Zeitschrift
    )
    (Bandnummer
        :type <integer>
        :initarg :Bandnummer
        :reader Bandnummer
    )
    (Heftnummer
        :type <integer>
        :initarg :Heftnummer
        :reader Heftnummer
    )
    (Monat
        :type <integer>
        :initarg :Monat
        :reader Monat
    )
    :documentation "Repräsentiert einen Zeitschriftenartikel."
)

(define Nessie1790
        (make Buch
              :Schlüssel "Nessie1790"
              :Titel "Mein Leben im Loch Ness: Verfolgt als Ungeheuer"
              :Autoren '("Nessie")
              :Jahr 1790
              :Verlag "Minority-Verlag"
              :Verlagsort "Inverness"
              :Reihe "Die besondere Biographie"
              :Seriennummer 2
))
(define Prefect1979
        (make Sammelband
              :Schlüssel "Prefect1979"
              :Titel "Mostly harmless -- some observations concerning the third planet of the solar system"
              :Autoren '("Prefect, Ford")
              :Jahr 1799
              :Verlag "Galaxy Press"
              :Verlagsort "Vega-System, 3. Planet"
              :Reihe "Travel in Style"
              :Seriennummer 5
              :Herausgeber "Adams, Douglas, editor, The Hitchhiker's Guide to the Galaxy"
              :Seitenangabe 420
              ; leet edition?
))
(define Wells3200
        (make Zeitschriftenartikel
              :Schlüssel "Wells3200"
              :Titel "Zeitmaschinen leicht gemacht"
              :Autoren '("Wells, H. G.")
              :Jahr 3200
              :Zeitschrift "Heimwerkerpraxis für Anfänger"
              :Bandnummer 550
              :Heftnummer 3
))


; Aufgabe 1.2: Generische Funktionen und Methoden

; Generiert einen Zitatstring zu einer Veröffentlichung
(defgeneric* cite ((pub Veröffentlichung)))


(defmethod cite ((pub Veröffentlichung))
  (string-append
    (car (Autoren pub))
    (if (null? (cdr (Autoren pub))) "" " et al.")
    " ("
    (number->string (Jahr pub))
    "). "
    (Titel pub)
  ))

(defmethod cite ((pub Buch))
  (string-append
    (call-next-method)
    ", Band "
    (number->string (Seriennummer pub))
    " der Reihe: "
    (Reihe pub)
    ". "
    (Verlag pub)
    ", "
    (Verlagsort pub)
    "."
  ))

(defmethod cite ((pub Sammelband))
  (string-append
    (call-next-method)
    " Herausgegeben von "
    (Herausgeber pub)
    "."
  ))

(defmethod cite ((pub Zeitschriftenartikel))
  (string-append
    (call-next-method)
    ". "
    (Zeitschrift pub)
    ", "
    (number->string (Bandnummer pub))
    "("
    (number->string (Heftnummer pub))
    ")"
    "."
  ))

; (display (cite Nessie1790))
; (display "\n\n")
; (display (cite Prefect1979))
; (display "\n\n")
; (display (cite Wells3200))
; (display "\n\n")

; Nessie (1790). Mein Leben im Loch Ness: Verfolgt als Ungeheuer, Band 2 der
; Reihe: Die besondere Biographie. Minority-Verlag, Inverness.

; Prefect, Ford (1799). Mostly harmless -- some observations concerning the
; third planet of the solar system, Band 5 der Reihe: Travel in Style. Galaxy
; Press, Vega-System, 3. Planet. Herausgegeben von Adams, Douglas, editor, The
; Hitchhiker's Guide to the Galaxy.

; Wells, H. G. (3200). Zeitmaschinen leicht gemacht. Heimwerkerpraxis für
; Anfänger, 550(3).


; Aufgabe 1.3: Ergänzungsmethoden
; Ergänzungsmethoden werden durch die Schlüsselwörter :before, :after und
; :around gekennzeichnet.  Sie werden vor oder nach dem Aufruf der eigentlichen
; Methode ausgeführt.  Während die normalen oder Primärmethoden überschrieben
; werden, bleiben die mit :before und :after gekennzeochneten
; Ergänzungsmethoden bestehen.  So können Superklassen dafür sorgen, dass Code
; ausgeführt wird, währen Super Calls leicht vergessen werden können.

; Sollte die Methode cite den Zitatstring nicht zurückgeben sondern ausgeben,
; so könnte elegant mit Ergänzungsmethoden gearbeitet werden.
