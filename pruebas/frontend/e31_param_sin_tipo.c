/* E33: Parametro formal sin tipo — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: la gramatica exige INT ID para cada parametro formal */
f (a, b) {
    return a + b;
}
main () {
    printf ("%d", f (1, 2));
}
//@ (main)
