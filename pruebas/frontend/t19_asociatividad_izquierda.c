/* T36: Asociatividad izquierda de operadores con igual precedencia
   Esperado: a - b - c => (- (- a b) c)  NO (- a (- b c))
   Justificacion: -, /, % son asociativos por la izquierda en C y deben
   traducirse correctamente; error comun en gramaticas recursivas por la derecha */
int a = 10, b = 3, c = 2;
main () {
    printf ("%d", a - b - c);
    printf ("%d", a / b / c);
    printf ("%d", a % b % c);
}
//@ (main)
