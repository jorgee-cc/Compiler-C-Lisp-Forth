; BT25: case en backend (generado por switch/case del frontend)
; Esperado: estructura CASE ... OF ... ENDOF ... ENDCASE en Forth
; Justificacion: (case var (1 s1) (2 s2) (otherwise s3)) => CASE 1 OF s1 ENDOF ...
(setq a 2)
(defun main ()
(case a
(1 (print "uno"))
(2 (print "dos"))
(otherwise (print "otro"))
)
)
(main)
