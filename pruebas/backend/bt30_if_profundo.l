; BT30: if profundamente anidado (3 niveles) en backend
; Esperado: IF..IF..IF..THEN..THEN..THEN correctamente cerrados
; Justificacion: cada IF necesita exactamente un THEN; verifica el anidamiento
(setq a 1)
(setq b 1)
(setq c 1)
(defun main ()
(if (= a 1)
(if (= b 1)
(if (= c 1)
(print "todo uno")
(print "c distinto")
)
(print "b distinto")
)
(print "a distinto")
)
)
(main)
