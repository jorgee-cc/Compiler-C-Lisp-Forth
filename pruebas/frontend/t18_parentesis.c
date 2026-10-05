/* T35: Expresion parentizada cambia precedencia
   Esperado: (* (+ a b) c) en lugar de (+ a (* b c))
   Justificacion: (a + b) * c agrupa correctamente */
int a = 2, b = 3, c = 4;
main () {
    printf ("%d", (a + b) * c);
}
//@ (main)
