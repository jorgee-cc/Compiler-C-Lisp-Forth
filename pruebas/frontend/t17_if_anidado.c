/* T33: if anidado (else if simulado)
   Esperado: if anidado en rama else correctamente
   Justificacion: (if e1 s1 (if e2 s2 s3)) */
int x = 0;
main () {
    if (x > 0) {
        puts ("positivo");
    } else {
        if (x < 0) {
            puts ("negativo");
        } else {
            puts ("cero");
        }
    }
}
//@ (main)
