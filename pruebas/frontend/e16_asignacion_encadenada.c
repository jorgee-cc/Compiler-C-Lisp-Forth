/* E16: Asignacion encadenada a=b=5 — comportamiento a verificar
   Resultado esperado: segun la gramatica actual, puede rechazarse o aceptarse
   Justificacion: el enunciado menciona posibilidad de anadir asignaciones encadenadas
   pero no es obligatorio; verificar el comportamiento real */
int a, b;
main () {
    a = b = 5;
    printf ("%d", a);
}
//@ (main)
