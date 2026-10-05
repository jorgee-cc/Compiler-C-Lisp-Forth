/* T03: Declaracion multiple de variables globales en una sola linea
   Esperado: (setq x 3) (setq y 0) (setq z 1)
   Justificacion: int x=3, y, z=1; => secuencia de setq individuales en orden */
int x = 3, y, z = 1;
main () {
    printf ("%d", x);
    printf ("%d", y);
    printf ("%d", z);
}
//@ (main)
