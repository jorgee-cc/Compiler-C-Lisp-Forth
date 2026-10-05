/* E31: Falta coma entre parametros formales — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: lista de parametros requiere comas separadoras */
f (int a int b) {
    return a + b;
}
main () {
    printf ("%d", f (1, 2));
}
//@ (main)
