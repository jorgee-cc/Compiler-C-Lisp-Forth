/* T46: if con bloque then vacio
   Esperado: (if expr nil) o similar — el bloque vacio es valido
   Justificacion: borde — cuerpo vacio de then debe ser sintacticamente aceptado */
int a = 0;
main () {
    if (a > 0) {
    }
    puts ("ok");
}
//@ (main)
