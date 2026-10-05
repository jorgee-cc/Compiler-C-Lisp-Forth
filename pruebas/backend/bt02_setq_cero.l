; BT02: Variable global inicializada a cero
; Esperado: variable a  0 a !
; Justificacion: (setq a 0) => variable a + 0 a !
(setq a 0)
(defun main ()
(princ a)
)
(main)
