/* T11: Operadores unarios - y !
   Esperado: (- a) y (not flag)
   Justificacion: -a => (- a), !flag => (not flag) */
int a = 5, flag = 0;
main () {
    printf ("%d", -a);
    printf ("%d", !flag);
    printf ("%d", +a);
}
//@ (main)
