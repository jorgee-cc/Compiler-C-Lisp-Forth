/* T69: Directiva //@ intercalada entre funciones
   Esperado: se transcribe en el punto exacto donde aparece en la salida Lisp
   Justificacion: las directivas se emiten en el orden del fuente */
f () {
    puts ("f");
}
//@ (setq bandera 1)
main () {
    f ();
}
//@ (main)
