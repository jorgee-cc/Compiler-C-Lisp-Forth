/* E38: Switch sin parentesis — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: SWITCH '(' expr ')' exige parentesis obligatorios */
int a = 1;
main () {
    switch a {
        case 1: puts ("uno"); break;
    }
}
//@ (main)
