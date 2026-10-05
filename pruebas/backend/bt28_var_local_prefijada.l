; BT28: Variable local prefijada dentro de defun de usuario
; Esperado: main_x se usa como nombre de variable Forth local
; Justificacion: las variables prefijadas se tratan igual que globales en Forth
(setq main_x 0)
(defun main ()
(setf main_x 7)
(princ main_x)
)
(main)
