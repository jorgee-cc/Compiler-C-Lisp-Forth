; BT21: if anidado dentro de while en backend
; Esperado: begin cond while [IF cond s THEN] repeat
; Justificacion: verifica que la anidacion IF dentro de begin..repeat es correcta
(setq i 0)
(defun main ()
(loop while (< i 5) do
(if (= i 2)
(print "dos")
)
(setf i (+ i 1))
)
)
(main)
