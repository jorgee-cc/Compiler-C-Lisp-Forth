/* T64: Switch con muchos cases (stress de lista de cases)
   Esperado: (case a (1 ...) (2 ...) (3 ...) (4 ...) (5 ...) (otherwise ...))
   Justificacion: la lista de cases es recursiva; verifica con 5 casos */
int a = 3;
main () {
    switch (a) {
        case 1: puts ("uno");   break;
        case 2: puts ("dos");   break;
        case 3: puts ("tres");  break;
        case 4: puts ("cuatro");break;
        case 5: puts ("cinco"); break;
        default: puts ("otro"); break;
    }
}
//@ (main)
