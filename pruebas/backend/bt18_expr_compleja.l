; BT18: Expresion aritmetica compleja anidada
; Esperado: traduccion postfija correcta de expresion multinivel
; Justificacion: (+ (* a b) (- c d)) => a @ b @ * c @ d @ - +
(setq a 2)
(setq b 3)
(setq c 10)
(setq d 4)
(defun main ()
(princ (+ (* a b) (- c d)))
)
(main)
