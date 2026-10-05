; BT08: Operadores de comparacion
; Esperado: postfijo con < > <= >= = y para /= => = 0=
; Justificacion: tabla de correspondencia Lisp-Forth del enunciado
(setq a 3)
(setq b 5)
(defun main ()
(princ (< a b))
(princ (> a b))
(princ (<= a b))
(princ (>= a b))
(princ (= a b))
(princ (/= a b))
)
(main)
