/* T37: Expresion aritmetica profundamente anidada (stress de recursion)
   Esperado: arbol de operaciones correcto sin desbordamiento de pila del parser
   Justificacion: verifica que la gramatica no falla con anidamiento profundo */
int a = 1, b = 2, c = 3, d = 4, e = 5;
main () {
    printf ("%d", a + b * c - d / e + (a - b) * (c + d));
    printf ("%d", ((a + b) * (c - d) + e) / (a + b));
}
//@ (main)
