/* E35: Vector global con tamano no constante — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: int v[n] con n variable no es admitido; solo NUMBER */
int n = 5;
int v[n];
main () {
    printf ("%d", v[0]);
}
//@ (main)
