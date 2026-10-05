/* T52: Multiples declaraciones locales en el mismo bloque
   Esperado: cada una genera su propia setq local prefijada
   Justificacion: varias declaraciones locales en funcion con setq propios */
main () {
    int a = 1;
    int b = 2;
    int c;
    c = a + b;
    printf ("%d", c);
}
//@ (main)
