; BE07: loop sin palabra while — DEBE RECHAZARSE
; Resultado esperado: error de sintaxis
; Justificacion: la gramatica exige (loop while expr do codigo); otras formas no validas
(defun main ()
(loop do
(print "bucle")
)
)
(main)
