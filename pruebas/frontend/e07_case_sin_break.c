/* E07: case sin break — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: la gramatica exige BREAK ';' tras cada case */
int a = 1;
main () {
    switch (a) {
        case 1:
            puts ("uno");
        case 2:
            puts ("dos");
            break;
    }
}
//@ (main)
