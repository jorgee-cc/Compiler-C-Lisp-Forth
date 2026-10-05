/* E19: for con asignacion arbitraria en tercer campo — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: el enunciado limita el tercer campo EXCLUSIVAMENTE a INC(x) o DEC(x) */
main () {
    int i;
    for (i = 0; i < 5; i = i + 2) {
        printf ("%d", i);
    }
}
//@ (main)
