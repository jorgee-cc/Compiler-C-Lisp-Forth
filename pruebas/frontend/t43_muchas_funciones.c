/* T70: Muchas funciones de usuario (stress de lista_funciones)
   Esperado: un defun por cada funcion, en orden de declaracion
   Justificacion: lista_funciones es recursiva; probar con 5 funciones */
inc1 (int x) { return x + 1; }
inc2 (int x) { return x + 2; }
inc3 (int x) { return x + 3; }
dobla (int x) { return x + x; }
cuadra (int x) { return x * x; }
main () {
    printf ("%d", inc1 (1));
    printf ("%d", inc2 (1));
    printf ("%d", inc3 (1));
    printf ("%d", dobla (3));
    printf ("%d", cuadra (3));
}
//@ (main)
