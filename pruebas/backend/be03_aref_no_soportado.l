; BE03: aref (acceso a vector) no soportado en backend — DEBE RECHAZARSE
; Esperado: error de sintaxis
; Justificacion: el enunciado excluye vectores del backend
(setq v (make-array 5))
(defun main ()
(princ (aref v 0))
)
(main)
