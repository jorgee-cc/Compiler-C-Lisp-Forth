/* T68: Multiples directivas //@ seguidas
   Esperado: cada linea //@ se transcribe al Lisp en orden de aparicion
   Justificacion: el parser debe admitir varias directivas, no solo una */
main () {
    puts ("hola");
}
//@ (setq x 99)
//@ (print x)
//@ (main)
