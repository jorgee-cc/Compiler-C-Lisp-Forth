/* T59: Asignacion entre elementos de vector
   Esperado: (setf (aref v (+ i 1)) (aref v i))
   Justificacion: aref como lvalue y como rvalue en la misma sentencia */
int v[10];
int i = 2;
main () {
    v[0] = 5;
    v[i] = v[i - 1] + 1;
    printf ("%d", v[i]);
}
//@ (main)
