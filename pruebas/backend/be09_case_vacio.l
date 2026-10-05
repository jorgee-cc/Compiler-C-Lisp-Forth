; BE09: case completamente vacio — DEBE RECHAZARSE
; Resultado esperado: error de sintaxis
; Justificacion: (case a) sin ninguna rama no esta en la gramatica
(setq a 1)
(defun main ()
(case a)
)
(main)
