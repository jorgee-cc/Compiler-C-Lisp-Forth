; BE06: Operador no reconocido en expresion — DEBE RECHAZARSE
; Resultado esperado: error de sintaxis
; Justificacion: (bitand a b) no es un operador del subconjunto Lisp definido
(setq a 3)
(setq b 5)
(defun main ()
(princ (bitand a b))
)
(main)
