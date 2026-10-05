/* T50: Multiples return intermedios en la misma funcion
   Esperado: cada return no-final genera (return-from f ...) ; el ultimo no
   Justificacion: funcion con varios puntos de salida — caso real frecuente */
signo (int x) {
    if (x > 0) {
        return 1;
    }
    if (x < 0) {
        return -1;
    }
    return 0;
}
main () {
    printf ("%d", signo (5));
    printf ("%d", signo (-3));
    printf ("%d", signo (0));
}
//@ (main)
