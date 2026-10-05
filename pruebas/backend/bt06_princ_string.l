; BT06: princ con cadena (sin salto de linea, sin comillas)
; Esperado: ." texto" (sin cr)
; Justificacion: (princ "texto") => ." texto" sin cr, distinto de print
(defun main ()
(princ "sin salto")
)
(main)
