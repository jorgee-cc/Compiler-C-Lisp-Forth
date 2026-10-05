/* E15: main con parametros — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: la gramatica define funcion_main como MAIN '(' ')' bloque;
   no admite parametros en main */
main (int argc) {
    puts ("hola");
}
//@ (main)
