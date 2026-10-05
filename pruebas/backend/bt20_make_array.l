; BT20: make-array debe consumirse sin traduccion
; Esperado: no hay salida Forth para la declaracion del vector
; Justificacion: vectores no se traducen en backend segun el enunciado
(setq v (make-array 10))
(defun main ()
(print "vector declarado")
)
(main)
