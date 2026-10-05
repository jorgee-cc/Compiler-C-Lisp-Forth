/* T40: for con condicion compuesta (expresion logica)
   Esperado: condicion se traduce como expresion logica en (loop while ...)
   Justificacion: la condicion del for puede ser cualquier expr booleana */
int i = 0, n = 5, flag = 1;
main () {
    for (i = 0; i < n && flag; INC(i)) {
        printf ("%d", i);
    }
}
//@ (main)
