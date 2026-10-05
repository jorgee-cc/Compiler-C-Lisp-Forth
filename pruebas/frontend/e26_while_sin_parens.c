/* E28: while sin parentesis en condicion — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: la gramatica exige WHILE '(' expr ')' */
int i = 0;
main () {
    while i < 5 {
        i = i + 1;
    }
}
//@ (main)
