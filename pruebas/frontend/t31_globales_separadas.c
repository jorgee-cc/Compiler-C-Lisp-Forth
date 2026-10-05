/* T56: Declaraciones globales en lineas separadas (varias int)
   Esperado: un (setq ...) por cada variable, en orden de declaracion
   Justificacion: cada declaracion global produce su propio bloque setq independiente */
int a = 1;
int b = 2;
int c = 3;
main () {
    printf ("%d", a + b + c);
}
//@ (main)
