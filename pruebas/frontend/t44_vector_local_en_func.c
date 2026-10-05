/* T72: Vector local en funcion de usuario (no main)
   Esperado: (setq f_buf (make-array 4))  — prefijado con nombre de funcion
   Justificacion: el prefijado debe funcionar igual en cualquier funcion, no solo en main */
procesa () {
    int buf[4];
    buf[0] = 1;
    buf[1] = 2;
    printf ("%d", buf[0] + buf[1]);
}
main () {
    procesa ();
}
//@ (main)
