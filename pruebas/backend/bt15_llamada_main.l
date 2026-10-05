; BT15: Llamada a (main) mediante directiva //@
; Esperado: main  (palabra Forth que invoca la definicion)
; Justificacion: (main) => main en Forth; NO debe auto-imprimirse
(setq a 10)
(defun main ()
(princ a)
)
(main)
