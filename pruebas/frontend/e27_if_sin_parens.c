/* E29: if sin parentesis en condicion — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: la gramatica exige IF '(' expr ')' */
int a = 1;
main () {
    if a > 0 {
        puts ("positivo");
    }
}
//@ (main)
