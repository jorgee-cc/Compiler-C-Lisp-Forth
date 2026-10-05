; BT32: Literal numerico como argumento de princ
; Esperado: 42 .   (solo el numero apilado + punto)
; Justificacion: los literales no necesitan @ (no son variables)
(defun main ()
(princ 42)
(princ 0)
(princ -1)
)
(main)
