/* T58: printf con literal numerico como argumento (no variable)
   Esperado: (princ 42)
   Justificacion: la expresion argumento puede ser una constante entera directa */
main () {
    printf ("%d", 42);
    printf ("%d", 0);
    printf ("%d", -1);
}
//@ (main)
