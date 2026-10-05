; BT10: Menos unario (- expr) de un solo operando
; Esperado: expr-postfijo negate
; Justificacion: (- a) con un solo argumento => negate en Forth
(setq a 5)
(defun main ()
(princ (- a))
)
(main)
