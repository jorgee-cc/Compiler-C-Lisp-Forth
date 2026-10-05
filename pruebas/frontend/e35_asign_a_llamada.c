/* E37: Asignacion a una llamada de funcion (lvalue invalido) — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: solo ID y ID[expr] son lvalues validos */
f () { return 1; }
main () {
    f () = 5;
}
//@ (main)
