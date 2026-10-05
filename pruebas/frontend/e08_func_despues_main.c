/* E08: Funcion de usuario despues de main — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: estructura fija: decl_globales lista_funciones funcion_main;
   las funciones deben ir antes de main */
main () {
    f ();
}
f () {
    puts ("tarde");
}
//@ (main)
