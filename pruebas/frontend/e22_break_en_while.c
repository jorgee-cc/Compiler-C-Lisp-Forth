/* E22: break fuera de switch — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: break solo esta definido dentro de los case; en while/for
   no esta contemplado (el enunciado no incluye break en bucles) */
int i = 0;
main () {
    while (i < 5) {
        if (i == 3) {
            break;
        }
        i = i + 1;
    }
}
//@ (main)
