/* T18: Variables locales con prefijo funcion_var
   Esperado: variable local 'a' en main => main_a
   Justificacion: variables locales se prefijan con nombre_funcion_ */
int a = 10;
main () {
    int a = 4;
    a = a + 1;
    printf ("%d", a);
}
//@ (main)
