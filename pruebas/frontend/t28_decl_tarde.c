/* T51: Declaracion de variable local NO al inicio del bloque
   Esperado: aceptado o rechazado segun si la gramatica exige orden
   Justificacion: borde — en C89 las declaraciones van al principio del bloque;
   verificar si la gramatica del enunciado impone o no ese orden */
main () {
    puts ("antes");
    int x = 5;
    printf ("%d", x);
}
//@ (main)
