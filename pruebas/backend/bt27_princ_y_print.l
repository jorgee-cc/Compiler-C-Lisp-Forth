; BT27: Mezcla de princ y print en la misma funcion
; Esperado: cada uno genera su Forth correcto de forma independiente
; Justificacion: ambas instrucciones pueden coexistir en cualquier orden
(defun main ()
(princ 42)
(print "fin")
(princ 0)
)
(main)
