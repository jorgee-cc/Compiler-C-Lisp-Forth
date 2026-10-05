/* T65: Switch anidado dentro de if
   Esperado: (if ... (case ...)) — anidacion correcta
   Justificacion: sentencias compuestas pueden anidarse arbitrariamente */
int a = 1, b = 2;
main () {
    if (a > 0) {
        switch (b) {
            case 1: puts ("b es uno");  break;
            case 2: puts ("b es dos");  break;
            default: puts ("b otro");   break;
        }
    }
}
//@ (main)
