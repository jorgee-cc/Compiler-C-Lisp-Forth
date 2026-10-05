/* T29: Directiva de codigo embebido //@
   Esperado: la linea se transcribe literal al Lisp sin modificar
   Justificacion: //@ transcribe la linea tal cual a la salida */
int a = 5;
main () {
    printf ("%d", a);
}
//@ (print "directiva embebida")
//@ (main)
