; BT26: Llamada a funcion con argumentos en backend
; Esperado: argumentos en postfijo antes del nombre de la palabra Forth
; Justificacion: (f a b) => a @ b @ f  en Forth (args en pila, luego nombre)
(setq x 3)
(setq y 4)
(defun suma (a b)
(+ a b)
)
(defun main ()
(princ (suma x y))
)
(main)
