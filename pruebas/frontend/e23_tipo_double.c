/* E23: Tipo double en declaracion — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis (token no reconocido)
   Justificacion: el unico tipo soportado es int; double no es un token valido */
double a = 3.14;
main () {
    printf ("%d", a);
}
//@ (main)
