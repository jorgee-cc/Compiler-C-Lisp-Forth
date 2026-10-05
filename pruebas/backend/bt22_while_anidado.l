; BT22: While anidado en backend — dos begin..while..repeat anidados
; Esperado: begin e1 while begin e2 while cuerpo repeat repeat
; Justificacion: los repeat deben cerrarse en orden LIFO correcto
(setq i 0)
(setq j 0)
(defun main ()
(loop while (< i 3) do
(loop while (< j 3) do
(princ i)
(setf j (+ j 1))
)
(setf i (+ i 1))
)
)
(main)
