/* T28: Vector local en funcion
   Esperado: (setq main_buf (make-array 8))
   Justificacion: vector local se prefija como variable local */
main () {
    int buf[8];
    buf[0] = 1;
    printf ("%d", buf[0]);
}
//@ (main)
