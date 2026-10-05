/* T66: if anidado dentro de un case
   Esperado: cada case puede contener cualquier sentencia, incluyendo if
   Justificacion: verifica que el cuerpo de case acepta sentencias compuestas */
int a = 1, b = 5;
main () {
    switch (a) {
        case 1:
            if (b > 3) {
                puts ("uno y b grande");
            } else {
                puts ("uno y b pequeno");
            }
            break;
        default:
            puts ("otro");
            break;
    }
}
//@ (main)
