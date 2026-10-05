/* E30: Asignacion a literal numerico (lvalue invalido) — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: la gramatica solo permite ID o ID[expr] como lvalue;
   asignar a constante no es valido */
main () {
    5 = 3;
}
//@ (main)
