/* E12: while sin llaves — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: al igual que if, while requiere bloque con llaves obligatorias */
int i = 0;
main () {
    while (i < 3)
        i = i + 1;
}
//@ (main)
