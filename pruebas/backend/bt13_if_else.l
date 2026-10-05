; BT13: if con rama else
; Esperado: [cond] IF [then] ELSE [else] THEN
; Justificacion: (if expr s1 s2) => expr IF s1 ELSE s2 THEN
(setq a 0)
(defun main ()
(if (= a 0)
(print "cero")
(print "no cero")
)
)
(main)
