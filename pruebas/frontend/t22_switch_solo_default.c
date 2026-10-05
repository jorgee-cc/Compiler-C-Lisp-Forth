/* T39: Switch con solo default (sin ningun case)
   Esperado: (case a (otherwise (print "otro")))  O  error segun gramatica
   Justificacion: borde — la gramatica puede o no admitir default sin cases previos */
int a = 5;
main () {
    switch (a) {
        default:
            puts ("otro");
            break;
    }
}
//@ (main)
