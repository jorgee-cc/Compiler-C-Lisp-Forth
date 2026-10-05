; BT16: Multiples variables globales en secuencia
; Esperado: una declaracion variable + asignacion por cada setq
; Justificacion: cada (setq x v) genera variable x  v x ! independientemente
(setq x 1)
(setq y 2)
(setq z 3)
(defun main ()
(princ (+ x (+ y z)))
)
(main)
