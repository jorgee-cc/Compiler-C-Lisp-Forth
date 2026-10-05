; BT12: if sin rama else
; Esperado: [cond] IF [then] THEN
; Justificacion: (if expr sent) => expr IF sent THEN
(setq a 5)
(defun main ()
(if (> a 0)
(print "positivo")
)
)
(main)
