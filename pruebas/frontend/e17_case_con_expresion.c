/* E17: case con expresion en lugar de constante — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: la gramatica acepta CASE NUMBER, no expresiones */
int a = 3;
main () {
    switch (a) {
        case a:
            puts ("igual");
            break;
    }
}
//@ (main)
