/* T53: Constante negativa en inicializacion global
   Esperado: (setq a -5)  O bien  error segun gramatica
   Justificacion: borde — el enunciado indica NUMBER como token; -5 puede ser
   unario aplicado sobre NUMBER o bien un token NUMBER negativo */
int a = -5;
main () {
    printf ("%d", a);
}
//@ (main)
