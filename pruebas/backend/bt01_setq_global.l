; BT01: Declaracion de variable global con setq
; Esperado: variable a  1 a !
; Justificacion: (setq a 1) => variable a + valor inicial a !
(setq a 1)
(defun main ()
(princ a)
)
(main)
