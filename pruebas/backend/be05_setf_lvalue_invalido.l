; BE05: setf con lvalue que no es un identificador — DEBE RECHAZARSE
; Resultado esperado: error de sintaxis
; Justificacion: (setf 5 expr) no es valido; solo (setf ID expr) o (setf (aref ...) expr)
(defun main ()
(setf 5 42)
)
(main)
