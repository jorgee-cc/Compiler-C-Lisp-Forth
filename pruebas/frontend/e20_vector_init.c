/* E20: Vector con inicializacion en declaracion — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: el enunciado NO contempla inicializacion de elementos al declarar */
int v[3] = {1, 2, 3};
main () {
    printf ("%d", v[0]);
}
//@ (main)
