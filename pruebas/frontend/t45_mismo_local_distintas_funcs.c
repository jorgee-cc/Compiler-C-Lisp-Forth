/* T73: Variable local con el mismo nombre en dos funciones distintas
   Esperado: f_x y g_x son independientes — no hay colision
   Justificacion: el prefijado por nombre de funcion garantiza unicidad */
f () {
    int x = 10;
    printf ("%d", x);
}
g () {
    int x = 20;
    printf ("%d", x);
}
main () {
    f ();
    g ();
}
//@ (main)
