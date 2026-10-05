/* E03: Falta punto y coma tras sentencia — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: sentencia en cuerpo requiere ';' segun la gramatica */
int a;
main () {
    a = 5
    printf ("%d", a);
}
//@ (main)
