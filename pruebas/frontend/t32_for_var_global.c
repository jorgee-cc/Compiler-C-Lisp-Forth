/* T57: for cuya variable de iteracion es global (no local)
   Esperado: setf (no setq) en asignacion inicial y en increment del for
   Justificacion: distincion setq (declaracion) vs setf (asignacion) segun ambito */
int i = 0;
main () {
    for (i = 0; i < 3; INC(i)) {
        printf ("%d", i);
    }
}
//@ (main)
