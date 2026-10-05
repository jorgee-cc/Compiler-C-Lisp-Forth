; BT23: return-from en backend
; Esperado: EXIT en Forth dentro de IF ... THEN para salida anticipada
; Justificacion: (return-from f expr) => expr EXIT (sale de la palabra Forth)
(defun f (x)
(if (< x 0)
(return-from f 0)
)
x
)
(defun main ()
(princ (f -1))
(princ (f 5))
)
(main)
