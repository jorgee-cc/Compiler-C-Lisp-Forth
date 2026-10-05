/* IT09: Pipeline completo — switch/case
   Esperado (gcc/clisp/gforth): dos
   Justificacion: verifica traduccion switch->case->CASE..OF..ENDOF..ENDCASE */
int a = 2;
main () {
    switch (a) {
        case 1:
            puts ("uno");
            break;
        case 2:
            puts ("dos");
            break;
        default:
            puts ("otro");
            break;
    }
}
//@ (main)
