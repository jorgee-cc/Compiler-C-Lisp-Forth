/* E25: Dos funciones main — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis (segundo main inesperado)
   Justificacion: la gramatica admite exactamente una funcion_main al final */
main () {
    puts ("primera");
}
main () {
    puts ("segunda");
}
//@ (main)
