#lang racket
(require 2htdp/image)

(define (luecke)
  (rectangle 50 1 "outline" "transparent")
  )

(define (baumteil x a)
  (isosceles-triangle x a "solid" "darkgreen")
  )

(define (stamm x)
  (rectangle (* x 0.2) (* x 0.2) "solid" "brown")
          )

(define (stern x)
  (star-polygon (/ x 3) 5 2 "solid" "gold")
          )

(define (baum breite hoehe abgerundet)
  (above/align
   "center"
   (stern breite)
   (if abgerundet
       (baum-rund breite hoehe)
       (baum-normal breite hoehe)
       )
   
   (stamm breite)
   )
  )

; Abgerundeter Baum
(define (baum-rund b h)
   (if (> b 20)
       (overlay/offset
        (baum-rund (* b 0.75) (* h 0.8))
        0
        (* b 0.3)
        (baumteil b h)
        )
       (baumteil b h)
       )
  )

; Normaler Baum
(define (baum-normal b h)
   (if (> b 20)
       (overlay/offset
        (baum-normal (* b 0.75) h)
        0
        (* b 0.25)
        (baumteil b h)
        )
       (baumteil b h)
       )
  )
  
;  (beside/align "bottom" (baum 120 70 #t) (luecke) (baum 120 70 #f))

(provide baum)
