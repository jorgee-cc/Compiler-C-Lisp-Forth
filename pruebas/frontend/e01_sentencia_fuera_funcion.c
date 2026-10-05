/* E01: Sentencia fuera de funcion — DEBE RECHAZARSE
   Resultado esperado: error de sintaxis
   Justificacion: las sentencias solo pueden aparecer dentro del cuerpo de una funcion;
   la gramatica no admite sentencias en decl_globales ni entre funciones */
int a;
a = 5;
main () {
}
//@ (main)
