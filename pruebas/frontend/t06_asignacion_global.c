/* T09: Asignacion simple a variable global
   Esperado: (setf a 5)
   Justificacion: a = 5; => (setf a 5) cuando a es global */
int a;
main () {
    a = 5;
    printf ("%d", a);
}
//@ (main)
