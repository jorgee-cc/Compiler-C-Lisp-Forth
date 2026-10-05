/* E24: Programa completo pero sin directiva //@ (main)
   Resultado esperado: aceptado como Lisp pero (main) no se invoca
   Justificacion: borde critico — la falta de //@ (main) no es error de sintaxis
   pero el programa Lisp resultante no se ejecutara automaticamente;
   verifica que el parser termina correctamente y solo falta la llamada */
main () {
    puts ("sin directiva");
}
