/* T22: Switch sin default (opcional)
   Esperado: (case var (1 ...) (2 ...)) sin otherwise
   Justificacion: default es opcional segun enunciado */
int a = 2;
main () {
    switch (a) {
        case 1:
            puts ("uno");
            break;
        case 2:
            puts ("dos");
            break;
    }
}
//@ (main)
