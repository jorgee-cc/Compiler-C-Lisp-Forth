/* T30: Prueba de integracion compleja
   Esperado: traduccion completa y correcta con variables locales, globales, funcion, while
   Justificacion: combina multiples aspectos de la practica */
int n = 10;
suma_hasta (int lim) {
    int acc = 0, i = 0;
    while (i <= lim) {
        acc = acc + i;
        i = i + 1;
    }
    return acc;
}
main () {
    printf ("%d", suma_hasta (n));
}
//@ (main)
