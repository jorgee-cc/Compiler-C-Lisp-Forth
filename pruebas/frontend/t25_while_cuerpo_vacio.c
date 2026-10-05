/* T45: While con cuerpo vacio
   Esperado: (loop while condicion do nil) o equivalente
   Justificacion: borde simetrico al T44 para while */
int i = 10;
main () {
    while (i < 0) {
    }
    puts ("fin");
}
//@ (main)
