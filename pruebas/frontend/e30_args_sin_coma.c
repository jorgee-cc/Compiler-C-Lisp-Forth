/* E32: Falta coma entre argumentos en llamada — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: lista de argumentos en llamada requiere comas separadoras */
f (int a, int b) {
    return a + b;
}
main () {
    printf ("%d", f (1 2));
}
//@ (main)
