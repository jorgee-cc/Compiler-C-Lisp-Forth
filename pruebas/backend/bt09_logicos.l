; BT09: Operadores logicos and, or, not
; Esperado: and => and, or => or, not => 0=
; Justificacion: tabla Lisp-Forth; not en Lisp => 0= en Forth
(setq a 1)
(setq b 0)
(defun main ()
(princ (and a b))
(princ (or a b))
(princ (not a))
)
(main)
