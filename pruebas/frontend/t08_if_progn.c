/* T17: if con multiples sentencias en then => progn
   Esperado: (if <expr> (progn s1 s2) ...)
   Justificacion: >1 sentencia en rama => wrap_progn inserta (progn ...) */
int a = 1, b = 0;
main () {
    if (a > 0) {
        b = 1;
        puts ("positivo");
    } else {
        b = 0;
        puts ("no positivo");
    }
}
//@ (main)
