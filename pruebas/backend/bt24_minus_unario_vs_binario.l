; BT24: Distincion (-a) unario vs (- a b) binario en backend
; Esperado: (- a) => a @ negate  ;  (- a b) => a @ b @ -
; Justificacion: el numero de argumentos determina el operador Forth
(setq a 5)
(setq b 3)
(defun main ()
(princ (- a))
(princ (- a b))
)
(main)
