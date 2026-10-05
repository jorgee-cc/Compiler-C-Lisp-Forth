/* T67: for dentro de while
   Esperado: loop while ... do (setf + loop while ...) repeat
   Justificacion: mezcla de tipos de bucle anidados */
int i = 0, j = 0, n = 2;
main () {
    while (i < n) {
        for (j = 0; j < n; INC(j)) {
            printf ("%d", i + j);
        }
        i = i + 1;
    }
}
//@ (main)
