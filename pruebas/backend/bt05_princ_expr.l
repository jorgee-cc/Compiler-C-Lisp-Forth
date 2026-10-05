; BT05: Impresion de expresion con princ
; Esperado: valor en pila + .
; Justificacion: (princ expr) => postfijo de expr + .
(setq a 7)
(defun main ()
(princ a)
)
(main)
