; BT19: defun de funcion de usuario (fuera de spec del backend, pero parseable)
; Esperado: la gramatica la acepta y emite : nombre ... ;
; Justificacion: el enunciado indica que defun de usuario se parsea aunque sea out of spec
(defun suma (a b)
(+ a b)
)
(defun main ()
(print "ok")
)
(main)
