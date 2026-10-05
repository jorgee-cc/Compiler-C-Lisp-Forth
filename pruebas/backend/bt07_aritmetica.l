; BT07: Operaciones aritmeticas en postfijo
; Esperado: operandos antes del operador en Forth
; Justificacion: (+ a b) => a @ b @ + ; (* a b) => a @ b @ *
(setq a 3)
(setq b 4)
(defun main ()
(princ (+ a b))
(princ (* a b))
(princ (- a b))
(princ (/ b a))
(princ (mod b a))
)
(main)
