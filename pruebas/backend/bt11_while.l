; BT11: Bucle while
; Esperado: begin [cond] while [cuerpo] repeat
; Justificacion: (loop while expr do codigo) => begin expr while codigo repeat
(setq i 0)
(defun main ()
(loop while (< i 3) do
(princ i)
(setf i (+ i 1))
)
)
(main)
