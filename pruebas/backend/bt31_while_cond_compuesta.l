; BT31: Condicion compuesta (and/or/not) en loop while
; Esperado: begin [cond-postfija-compleja] while cuerpo repeat
; Justificacion: la condicion de while puede ser cualquier expresion booleana
(setq i 0)
(setq flag 1)
(defun main ()
(loop while (and (< i 5) (= flag 1)) do
(princ i)
(setf i (+ i 1))
)
)
(main)
