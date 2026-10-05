/* E21: return sin expresion — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: el enunciado indica RETURN expr; siempre lleva expresion;
   return void no esta en la gramatica */
f () {
    return;
}
main () {
    f ();
}
//@ (main)
