/* T44: For con cuerpo vacio
   Esperado: loop while con cuerpo vacio / nil
   Justificacion: borde — cuerpo vacio debe ser sintacticamente valido */
int i = 0;
main () {
    for (i = 0; i < 5; INC(i)) {
    }
    printf ("%d", i);
}
//@ (main)
