/* T75: Literal 0 y 1 como condicion en if y while
   Esperado: (if 0 ...) y (loop while 0 do ...) — literales validos como condicion
   Justificacion: los literales numericos son expresiones validas como condicion */
main () {
    if (1) {
        puts ("siempre");
    }
    while (0) {
        puts ("nunca");
    }
    puts ("fin");
}
//@ (main)
