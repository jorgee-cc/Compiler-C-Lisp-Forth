/* E10: Expresion sola como sentencia — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: el enunciado elimina explicitamente la sentencia que contiene
   unicamente una expresion (ej: 1+2;) para evitar conflictos */
int a = 3;
main () {
    a + 1;
}
//@ (main)
