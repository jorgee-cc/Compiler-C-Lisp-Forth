/* T31: Variable local con mismo nombre que global — ambito correcto
   Esperado: dentro de main la 'x' local se prefija; fuera se usa la global
   Justificacion: la tabla local es por funcion; se resetea en cada funcion nueva */
int x = 99;
f () {
    printf ("%d", x);
}
main () {
    int x = 1;
    printf ("%d", x);
    f ();
}
//@ (main)
