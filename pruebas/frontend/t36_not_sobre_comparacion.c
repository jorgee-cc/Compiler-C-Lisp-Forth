/* T63: ! aplicado sobre resultado de comparacion
   Esperado: (not (< a b))  —  NOT agrupa sobre la comparacion completa
   Justificacion: unario ! tiene mayor precedencia que los relacionales pero
   se aplica al atomo mas cercano; !(a<b) vs !a<b son distintos */
int a = 3, b = 5;
main () {
    printf ("%d", !(a < b));
    printf ("%d", !(a == b));
    printf ("%d", !a < b);
}
//@ (main)
