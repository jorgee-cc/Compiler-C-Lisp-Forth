/* E11: for con declaracion en inicializacion — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: for solo acepta asignacion simple como inicializacion,
   no declaraciones (int i=0) ni multiples sentencias */
main () {
    for (int i = 0; i < 5; INC(i)) {
        printf ("%d", i);
    }
}
//@ (main)
