; BE04: return-from con nombre de funcion inexistente — comportamiento a verificar
; Resultado esperado: puede rechazarse (semantico) o aceptarse (el backend no verifica nombres)
; Justificacion: si el backend solo parsea sin tabla de simbolos, puede aceptarlo;
; si verifica el nombre, debe dar error semantico
(defun main ()
(return-from otra_funcion 0)
(print "ok")
)
(main)
