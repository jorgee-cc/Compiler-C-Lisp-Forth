/* E04: for con i++ (no implementado) — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: el enunciado NO implementa i++, ++i ni i+=1; solo INC/DEC */
main () {
    int i;
    for (i = 0; i < 5; i++) {
        printf ("%d", i);
    }
}
//@ (main)
