; BT33: Multiples defun que se invocan entre si
; Esperado: cada : nombre ... ; independiente; las llamadas usan el nombre Forth
; Justificacion: verifica que el orden de definicion en Forth es correcto
(defun doble (x)
(+ x x)
)
(defun triple (x)
(+ x (doble x))
)
(defun main ()
(princ (doble 4))
(princ (triple 3))
)
(main)
