; BT17: nil en cuerpo de while vacio
; Esperado: nil no genera codigo Forth (se consume sin traduccion)
; Justificacion: nil representa cuerpo vacio; el backend lo acepta en la gramatica
(setq a 0)
(defun main ()
(loop while (< a 0) do nil)
(print "ok")
)
(main)
