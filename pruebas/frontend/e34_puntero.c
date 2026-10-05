/* E36: Puntero — NOT soportado, DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: el enunciado solo contempla int y vectores; int* no existe */
int a = 5;
main () {
    int *p;
    p = a;
    printf ("%d", p);
}
//@ (main)
