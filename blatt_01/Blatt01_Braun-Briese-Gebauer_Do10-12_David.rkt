#lang racket

;1.1 Grad in Bogenmaß und Bogenmaß in Grad
(define (grad-bogenmass g)
  (* g (/ (* 2 pi) 360)))

(define (bogenmass-grad b)
  (* b (/ 360 (* 2 pi))))

;1.2 acos

(define (my-acos c)
  (atan
   (/
    (sqrt
     (-
      1
      (sqr c)))
    c)))

;1.3 Nm in Km
(define (nm-km n)
  (* n 1.852))

;2.1 Entfernungen

(define (Grosskreis la ba lb bb)
  (my-acos
   (+
    (* (sin (grad-bogenmass ba)) (sin (grad-bogenmass bb)))
    (* (cos (grad-bogenmass ba)) (cos (grad-bogenmass bb)) (cos (grad-bogenmass (- la lb)))))))

(define (Grosskreis-nm g)
  (* (bogenmass-grad g) 60))

(define (entfernung-nm la ba lb bb)
  (Grosskreis-nm (Grosskreis la ba lb bb)))

(define (entfernung-km la ba lb bb)
  (nm-km (entfernung-nm la ba lb bb)))

(display "Oslo (59.93N, 10.75E) nach Hongkong (22.20N, 114.10E): \t\t\t")
(entfernung-km 59.93 10.75 22.2 114.1) ; = -9061.382558497597 km ???

(display "San Francisco(37.75N, 122.45W) nach Honolulu (21.32N, 157.83W): \t")
(entfernung-km 37.75 -122.45 21.32 -157.83) ; = 4149.330526503713

(display "Osterinsel (27.10S, 109.40W) nach Lima (12.10S, 77.05W): \t\t")
(entfernung-km -27.1 -109.4 -12.1 -77.05) ; = 3564.439060326203

;2.2

(define (Anfangskurs_kurs la ba lb bb)
  (bogenmass-grad
   (my-acos
    (/
     (- (sin (grad-bogenmass bb)) (* (cos (Grosskreis la ba lb bb)) (sin (grad-bogenmass ba))))
     (* (cos (grad-bogenmass ba)) (sin (Grosskreis la ba lb bb)))))))

(define (Anfangskurs la ba lb bb dir)
  (if (string=? dir "w")
      (- 360 (Anfangskurs_kurs la ba lb bb))
      (Anfangskurs_kurs la ba lb bb)))

(display "Oslo (59.93N, 10.75E) nach Hongkong (22.20N, 114.10E): \t\t\t")
(Anfangskurs 59.93 10.75 22.2 114.1 "e") ; = -9061.382558497597 km ???

(display "San Francisco(37.75N, 122.45W) nach Honolulu (21.32N, 157.83W): \t")
(Anfangskurs 37.75 -122.45 21.32 -157.83 "w") ; = 4149.330526503713

(display "Osterinsel (27.10S, 109.40W) nach Lima (12.10S, 77.05W): \t\t")
(Anfangskurs -27.1 -109.4 -12.1 -77.05 "w") ; = 3564.439060326203
  

;2.3 Himmelsrichtung
