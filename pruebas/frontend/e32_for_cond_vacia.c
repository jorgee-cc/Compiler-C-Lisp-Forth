/* E34: for con condicion vacia — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: for(init;;inc) sin condicion no esta en la gramatica */
main () {
    int i;
    for (i = 0; ; INC(i)) {
        printf ("%d", i);
    }
}
//@ (main)
