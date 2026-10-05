// E05: Variable global inicializada con expresion (no constante) — DEBE RECHAZARSE
//   Resultado esperado: error de sintaxis
//   Justificacion: globales solo admiten <cte> (NUMBER), no expresiones evaluables
int a = 3 + 2;
main () {
    printf ("%d", a);
}
//@ (main)
