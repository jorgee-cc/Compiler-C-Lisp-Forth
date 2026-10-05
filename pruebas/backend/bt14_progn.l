; BT14: progn — multiple sentencias en rama if
; Esperado: las sentencias del progn se emiten en secuencia sin estructura extra
; Justificacion: (progn s1 s2 ...) => secuencia de traducciones s1 s2 ...
(setq a 1)
(defun main ()
(if (= a 1)
(progn
(print "es uno")
(print "correcto")
)
)
)
(main)
