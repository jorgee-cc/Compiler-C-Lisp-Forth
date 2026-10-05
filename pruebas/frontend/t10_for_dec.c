/* T20: Bucle for con DEC
   Esperado: setf + (loop while cond do cuerpo (setf var (- var 1)))
   Justificacion: DEC(x) => (setf x (- x 1)) al final del cuerpo */
#define DEC(x) x=x-1
int n = 5;
main () {
    int i;
    for (i = n; i > 0; DEC(i)) {
        printf ("%d", i);
    }
}
//@ (main)
