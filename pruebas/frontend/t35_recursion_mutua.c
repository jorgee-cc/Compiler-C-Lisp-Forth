/* T60: Funciones que se llaman mutuamente (forward reference)
   Esperado: ambas generan defun; la llamada de par a impar dentro de impar
   Justificacion: verifica que las funciones se traducen independientemente
   sin importar el orden de llamada (no hay declaraciones forward en este subconjunto) */
par (int n) {
    if (n == 0) {
        return 1;
    }
    return impar (n - 1);
}
impar (int n) {
    if (n == 0) {
        return 0;
    }
    return par (n - 1);
}
main () {
    printf ("%d", par (4));
    printf ("%d", impar (3));
}
//@ (main)
