/* IT06: Verificacion critica — NO se imprime (main) automaticamente
   Esperado: la salida Lisp NO contiene (main) al final del cuerpo del defun
   Justificacion: requisito critico del enunciado; (main) solo via //@ (main) */
main () {
    puts ("solo una vez");
}
//@ (main)
