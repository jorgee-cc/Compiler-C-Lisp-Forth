/* T21: Switch/case basico con break
   Esperado: (case var (1 ...) (2 ...) (otherwise ...))
   Justificacion: switch/case => (case var (val exprs) ... (otherwise exprs)) */
int a = 1;
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
