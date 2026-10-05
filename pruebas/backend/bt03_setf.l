; BT03: Asignacion con setf
; Esperado: expresion en postfijo seguida de a !
; Justificacion: (setf a expr) => expr-postfija a !
(setq a 0)
(defun main ()
(setf a 42)
(princ a)
)
(main)
