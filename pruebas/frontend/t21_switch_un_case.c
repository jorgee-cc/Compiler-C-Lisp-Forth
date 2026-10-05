/* T38: Switch con un unico case y sin default
   Esperado: (case a (1 (print "uno")))
   Justificacion: caso limite — switch con minimo viable (1 case, 0 default) */
int a = 1;
main () {
    switch (a) {
        case 1:
            puts ("uno");
            break;
    }
}
//@ (main)
