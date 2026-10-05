/* Frontend: C source to Lisp intermediate representation. */

%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <stdarg.h>

int   yylex () ;
void  yyerror (char *) ;
char *my_malloc (int) ;
char *gen_code (char *) ;
char *emit (const char *, ...) ;
void  begin_function (char *) ;
char *current_function () ;
void  add_local (char *) ;
int   is_local  (char *) ;
char *resolve_identif (char *) ;
char *wrap_progn (char *, int) ;
char *call_lisp (char *, char *) ;
char *incdec_op (char *, int) ;
char *strip_last_return (char *, char *) ;
int   line_number (int) ;

typedef struct s_attr { int value ; char *code ; } t_attr ;
#define YYSTYPE t_attr

static void concat_body (t_attr *, char *, int, t_attr *) ;
%}

%token NUMBER IDENTIF INTEGER STRING MAIN WHILE IF ELSE PUTS PRINTF FOR INC DEC
%token SWITCH CASE DEFAULT BREAK RETURN
%token EQ NEQ LEQ GEQ AND OR

%nonassoc IF_THEN
%nonassoc ELSE
%right '='
%left  OR
%left  AND
%left  EQ  NEQ
%left  '<' '>' LEQ GEQ
%left  '+' '-'
%left  '*' '/' '%'
%right UNARY_SIGN UNARY_NOT
%%

axioma : decl_globales lista_funciones funcion_main ;

/* ---------- Variables globales ---------- */

decl_globales : /* vacio */
              | decl_global decl_globales
              ;

decl_global : INTEGER lista_decl_g ';'    { printf ("%s", $2.code) ; } ;

lista_decl_g : decl_var_g
             | decl_var_g ',' lista_decl_g { $$.code = emit ("%s%s", $1.code, $3.code) ; }
             ;

decl_var_g : IDENTIF                  { $$.code = emit ("(setq %s 0)\n", $1.code) ; }
           | IDENTIF '=' expresion    { $$.code = emit ("(setq %s %s)\n", $1.code, $3.code) ; }
           | IDENTIF '[' NUMBER ']'   { $$.code = emit ("(setq %s (make-array %d))\n", $1.code, $3.value) ; }
           ;

/* ---------- Funciones de usuario ---------- */

lista_funciones : /* vacio */
                | funcion_usuario lista_funciones
                ;

funcion_usuario : IDENTIF
                  { begin_function ($1.code) ; }
                  '(' opt_params ')' bloque
                  {
                      char *b = strip_last_return ($6.code, $1.code) ;
                      if ($4.code [0])
                          printf ("(defun %s (%s)\n%s\n)\n\n", $1.code, $4.code, b) ;
                      else
                          printf ("(defun %s ()\n%s\n)\n\n", $1.code, b) ;
                  }
                ;

opt_params : /* vacio */     { $$.code = gen_code ("") ; }
           | lista_params
           ;

/* Los parametros formales NO son variables locales: no se prefijan */
lista_params : INTEGER IDENTIF                      { $$.code = $2.code ; }
             | INTEGER IDENTIF ',' lista_params     { $$.code = emit ("%s %s", $2.code, $4.code) ; }
             ;

funcion_main : MAIN '(' ')'
               { begin_function ("main") ; }
               bloque
               { printf ("(defun main ()\n%s\n)\n", strip_last_return ($5.code, "main")) ; }
             ;

/* ---------- Bloque y cuerpo (recursividad derecha) ---------- */

bloque : '{' cuerpo '}'    { $$ = $2 ; } ;

cuerpo : /* vacio */           { $$.code = gen_code ("") ; $$.value = 0 ; }
       | sentencia ';' cuerpo  { concat_body (&$$, $1.code, 1,        &$3) ; }
       | ctrl_sent cuerpo      { concat_body (&$$, $1.code, $1.value, &$2) ; }
       | decl_local cuerpo     { concat_body (&$$, $1.code, $1.value, &$2) ; }
       ;

/* ---------- Variables locales ---------- */

decl_local : INTEGER lista_decl_l ';'   { $$ = $2 ; } ;

lista_decl_l : decl_var_l
             | decl_var_l ',' lista_decl_l
               {
                   $$.code  = emit ("%s\n%s", $1.code, $3.code) ;
                   $$.value = $1.value + $3.value ;
               }
             ;

decl_var_l : IDENTIF
             { add_local ($1.code) ;
               $$.code  = emit ("(setq %s_%s 0)", current_function (), $1.code) ;
               $$.value = 1 ; }
           | IDENTIF '=' expresion
             { add_local ($1.code) ;
               $$.code  = emit ("(setq %s_%s %s)", current_function (), $1.code, $3.code) ;
               $$.value = 1 ; }
           | IDENTIF '[' NUMBER ']'
             { add_local ($1.code) ;
               $$.code  = emit ("(setq %s_%s (make-array %d))", current_function (), $1.code, $3.value) ;
               $$.value = 1 ; }
           ;

/* ---------- Sentencias ---------- */

sentencia : IDENTIF '=' expresion
            { $$.code = emit ("(setf %s %s)", resolve_identif ($1.code), $3.code) ; }
          | IDENTIF '[' expresion ']' '=' expresion
            { $$.code = emit ("(setf (aref %s %s) %s)", resolve_identif ($1.code), $3.code, $6.code) ; }
          | PUTS '(' STRING ')'            { $$.code = emit ("(print \"%s\")", $3.code) ; }
          | PRINTF '(' STRING ')'          { $$.code = gen_code ("") ; }
          | PRINTF '(' STRING ',' lista_printf ')'   { $$.code = wrap_progn ($5.code, $5.value) ; }
          | IDENTIF '(' opt_args ')'       { $$.code = call_lisp ($1.code, $3.code) ; }
          | RETURN expresion
            { $$.code = emit ("(return-from %s %s)", current_function (), $2.code) ; }
          ;

opt_args : /* vacio */    { $$.code = gen_code ("") ; }
         | lista_args
         ;

lista_args : expresion
           | expresion ',' lista_args    { $$.code = emit ("%s %s", $1.code, $3.code) ; }
           ;

lista_printf : elem
               { $$.code = emit ("(princ %s)", $1.code) ; $$.value = 1 ; }
             | elem ',' lista_printf
               { $$.code  = emit ("(princ %s)\n%s", $1.code, $3.code) ;
                 $$.value = $3.value + 1 ; }
             ;

elem : expresion
     | STRING       { $$.code = emit ("\"%s\"", $1.code) ; }
     ;

/* ---------- Sentencias de control ---------- */

ctrl_sent : WHILE '(' expresion ')' bloque
            { $$.code  = emit ("(loop while %s do %s)",
                               $3.code, $5.value ? $5.code : "nil") ;
              $$.value = 1 ; }
          | IF '(' expresion ')' bloque  %prec IF_THEN
            { $$.code  = emit ("(if %s %s)", $3.code, wrap_progn ($5.code, $5.value)) ;
              $$.value = 1 ; }
          | IF '(' expresion ')' bloque ELSE bloque
            { $$.code  = emit ("(if %s %s %s)", $3.code,
                               wrap_progn ($5.code, $5.value),
                               wrap_progn ($7.code, $7.value)) ;
              $$.value = 1 ; }
          | FOR '(' IDENTIF '=' expresion ';' expresion ';' inc_dec ')' bloque
            {
                char *var  = resolve_identif ($3.code) ;
                char *loop = $11.value == 0
                    ? emit ("(loop while %s do %s)",    $7.code, $9.code)
                    : emit ("(loop while %s do %s\n%s)", $7.code, $11.code, $9.code) ;
                $$.code  = emit ("(setf %s %s)\n%s", var, $5.code, loop) ;
                $$.value = 2 ;
            }
          | SWITCH '(' expresion ')' '{' casos_switch '}'
            { $$.code  = emit ("(case %s\n%s)", $3.code, $6.code) ;
              $$.value = 1 ; }
          ;

un_case : CASE NUMBER ':' cuerpo BREAK ';'
          { $$.code = emit ("(%d %s)", $2.value, $4.value ? $4.code : "nil") ; }
        ;

lista_cases : un_case
            | un_case lista_cases   { $$.code = emit ("%s\n%s", $1.code, $2.code) ; }
            ;

opt_default : /* vacio */   { $$.code = gen_code ("") ; }
            | default_case
            ;

casos_switch : lista_cases opt_default
               { $$.code = emit ("%s%s%s", $1.code, $2.code [0] ? "\n" : "", $2.code) ; }
             | default_case
             ;

default_case : DEFAULT ':' cuerpo BREAK ';'
               { $$.code = emit ("(otherwise %s)", $3.value ? $3.code : "nil") ; }
             ;

inc_dec : INC '(' IDENTIF ')'   { $$.code = incdec_op ($3.code, 1) ; }
        | DEC '(' IDENTIF ')'   { $$.code = incdec_op ($3.code, 0) ; }
        ;

/* ---------- Expresiones (doble recursividad para precedencias) ---------- */

expresion : termino
          | expresion '+' expresion   { $$.code = emit ("(+ %s %s)",  $1.code, $3.code) ; }
          | expresion '-' expresion   { $$.code = emit ("(- %s %s)",  $1.code, $3.code) ; }
          | expresion '*' expresion   { $$.code = emit ("(* %s %s)",  $1.code, $3.code) ; }
          | expresion '/' expresion   { $$.code = emit ("(/ %s %s)",  $1.code, $3.code) ; }
          | expresion '%' expresion   { $$.code = emit ("(mod %s %s)",$1.code, $3.code) ; }
          | expresion '<' expresion   { $$.code = emit ("(< %s %s)",  $1.code, $3.code) ; }
          | expresion '>' expresion   { $$.code = emit ("(> %s %s)",  $1.code, $3.code) ; }
          | expresion LEQ expresion   { $$.code = emit ("(<= %s %s)", $1.code, $3.code) ; }
          | expresion GEQ expresion   { $$.code = emit ("(>= %s %s)", $1.code, $3.code) ; }
          | expresion EQ  expresion   { $$.code = emit ("(= %s %s)",  $1.code, $3.code) ; }
          | expresion NEQ expresion   { $$.code = emit ("(/= %s %s)", $1.code, $3.code) ; }
          | expresion AND expresion   { $$.code = emit ("(and %s %s)",$1.code, $3.code) ; }
          | expresion OR  expresion   { $$.code = emit ("(or %s %s)", $1.code, $3.code) ; }
          ;

termino : operando
        | '+' operando  %prec UNARY_SIGN   { $$ = $2 ; }
        | '-' operando  %prec UNARY_SIGN   { $$.code = emit ("(- %s)",   $2.code) ; }
        | '!' operando  %prec UNARY_NOT    { $$.code = emit ("(not %s)", $2.code) ; }
        ;

operando : IDENTIF                      { $$.code = resolve_identif ($1.code) ; }
         | NUMBER                       { $$.code = emit ("%d", $1.value) ; }
         | '(' expresion ')'            { $$ = $2 ; }
         | IDENTIF '(' opt_args ')'     { $$.code = call_lisp ($1.code, $3.code) ; }
         | IDENTIF '[' expresion ']'
           { $$.code = emit ("(aref %s %s)", resolve_identif ($1.code), $3.code) ; }
         ;
%%

/* =================== Funciones auxiliares =================== */

#define MAX_LOCALS 256
typedef struct s_context {
    char *local_vars [MAX_LOCALS] ;
    int   n_locals ;
    char  current_func [256] ;
} t_context ;

t_context *context ()
{
    static t_context ctx ;
    return &ctx ;
}

/* Unifica concat sentencia|ctrl|decl + cuerpo: preserva orden y contador. */
static void concat_body (t_attr *r, char *ac, int an, t_attr *b)
{
    if (an == 0 || ac [0] == '\0') { *r = *b ; return ; }
    if (b->value == 0) { r->code = ac ; r->value = an ; return ; }
    r->code  = emit ("%s\n%s", ac, b->code) ;
    r->value = an + b->value ;
}

void yyerror (char *mensaje)
{
    fprintf (stderr, "%s en la linea %d\n", mensaje, line_number (0)) ;
}

int line_number (int inc)
{
    static int n_line = 1 ;
    n_line += inc ;
    return n_line ;
}

char *emit (const char *fmt, ...)
{
    static char buf [2048] ;
    va_list ap ;
    va_start (ap, fmt) ;
    vsnprintf (buf, sizeof(buf), fmt, ap) ;
    va_end (ap) ;
    return gen_code (buf) ;
}

void add_local (char *name)
{
    t_context *ctx = context () ;
    if (ctx->n_locals < MAX_LOCALS)
        ctx->local_vars [ctx->n_locals++] = gen_code (name) ;
}

int is_local (char *name)
{
    int i ;
    t_context *ctx = context () ;
    for (i = 0 ; i < ctx->n_locals ; i++)
        if (strcmp (ctx->local_vars [i], name) == 0) return 1 ;
    return 0 ;
}

void begin_function (char *name)
{
    t_context *ctx = context () ;
    strcpy (ctx->current_func, name) ;
    ctx->n_locals = 0 ;
}

char *current_function ()
{
    return context ()->current_func ;
}

char *resolve_identif (char *name)
{
    return is_local (name) ? emit ("%s_%s", current_function (), name) : gen_code (name) ;
}

char *wrap_progn (char *code, int count)
{
    if (count == 0) return gen_code ("nil") ;
    if (count == 1) return code ;
    return emit ("(progn %s)", code) ;
}

char *call_lisp (char *name, char *args)
{
    return args [0] ? emit ("(%s %s)", name, args) : emit ("(%s)", name) ;
}

char *incdec_op (char *id, int inc)
{
    char *var = resolve_identif (id) ;
    return emit ("(setf %s (%s %s 1))", var, inc ? "+" : "-", var) ;
}
/* Simplifica el ultimo (return-from fn <expr>) si esta en la ultima */
/* posicion top-level del cuerpo de una funcion (spec: return final).  */
char *strip_last_return (char *body, char *fn)
{
    char  prefix [64], *res ;
    int   plen, n, end, i, depth = 0, start = -1 ;

    plen = snprintf (prefix, sizeof(prefix), "(return-from %s ", fn) ;
    n    = strlen (body) ;

    for (i = 0 ; i < n ; i++) {
        if (body [i] == '(') {
            if (depth == 0 && strncmp (body + i, prefix, plen) == 0) start = i ;
            depth++ ;
        } else if (body [i] == ')') depth-- ;
    }
    if (start < 0) return body ;

    for (end = n - 1 ; end >= 0 && isspace ((unsigned char) body [end]) ; end--) ;
    for (i = start, depth = 0 ; i <= end ; i++) {
        if      (body [i] == '(') depth++ ;
        else if (body [i] == ')' && --depth == 0) break ;
    }
    if (i != end) return body ;

    res = my_malloc (n + 1) ;
    memcpy (res, body, start) ;
    memcpy (res + start, body + start + plen, end - start - plen) ;
    res [start + end - start - plen] = '\0' ;
    return res ;
}

char *my_malloc (int nbytes)
{
    char *p = malloc (nbytes) ;
    if (p == NULL) {
        fprintf (stderr, "No queda memoria para %d bytes mas\n", nbytes) ;
        exit (0) ;
    }
    return p ;
}

char *gen_code (char *name)
{
    char *p = my_malloc (strlen (name) + 1) ;
    strcpy (p, name) ;
    return p ;
}

/* =================== Palabras reservadas y lexico =================== */

typedef struct s_keyword { char *name ; int token ; } t_keyword ;

t_keyword *search_keyword (char *symbol_name)
{
    static t_keyword keywords [] = {
        "main",     MAIN,     "int",      INTEGER,  "while",    WHILE,
        "if",       IF,       "else",     ELSE,     "puts",     PUTS,
        "printf",   PRINTF,   "for",      FOR,      "inc",      INC,
        "dec",      DEC,      "switch",   SWITCH,   "case",     CASE,
        "default",  DEFAULT,  "break",    BREAK,    "return",   RETURN,
        "==",       EQ,       "!=",       NEQ,      "<=",       LEQ,
        ">=",       GEQ,      "&&",       AND,      "||",       OR,
        NULL,       0
    } ;
    int i ;
    for (i = 0 ; keywords [i].name != NULL ; i++)
        if (strcmp (keywords [i].name, symbol_name) == 0) return &keywords [i] ;
    return NULL ;
}

int yylex ()
{
// NO MODIFICAR ESTA FUNCION SIN PERMISO
    int i ;
    unsigned char c ;
    unsigned char cc ;
    char ops_expandibles [] = "!<=|>%&/+-*" ;
    char temp_str [256] ;
    t_keyword *symbol ;

    do {
        c = getchar () ;

        if (c == '#') {	// Ignora las lineas que empiezan por #  (#define, #include)
            do {		//	OJO que puede funcionar mal si una linea contiene #
                c = getchar () ;
            } while (c != '\n') ;
        }

        if (c == '/') {	// Si la linea contiene un / puede ser inicio de comentario
            cc = getchar () ;
            if (cc != '/') {   // Si el siguiente char es /  es un comentario, pero...
                ungetc (cc, stdin) ;
            } else {
                c = getchar () ;	// ...
                if (c == '@') {	// Si es la secuencia //@  ==> transcribimos la linea
                    do {		// Se trata de codigo inline (Codigo embebido en C)
                        c = getchar () ;
                        putchar (c) ;
                    } while (c != '\n') ;
                } else {		// ==> comentario, ignorar la linea
                    while (c != '\n') {
                        c = getchar () ;
                    }
                }
            }
        } else if (c == '\\') c = getchar () ;
		
        if (c == '\n')
            line_number (1) ;

    } while (c == ' ' || c == '\n' || c == 10 || c == 13 || c == '\t') ;

    if (c == '\"') {
        i = 0 ;
        do {
            c = getchar () ;
            temp_str [i++] = c ;
        } while (c != '\"' && i < 255) ;
        if (i == 256) {
            printf ("AVISO: string con mas de 255 caracteres en linea %d\n", line_number (0)) ;
        }		 	// habria que leer hasta el siguiente " , pero, y si falta?
        temp_str [--i] = '\0' ;
        yylval.code = gen_code (temp_str) ;
        return (STRING) ;
    }

    if (c == '.' || (c >= '0' && c <= '9')) {
        ungetc (c, stdin) ;
        scanf ("%d", &yylval.value) ;
//         printf ("\nDEV: NUMBER %d\n", yylval.value) ;        // PARA DEPURAR
        return NUMBER ;
    }

    if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z')) {
        i = 0 ;
        while (((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') ||
            (c >= '0' && c <= '9') || c == '_') && i < 255) {
            temp_str [i++] = tolower (c) ;
            c = getchar () ;
        }
        temp_str [i] = '\0' ;
        ungetc (c, stdin) ;

        yylval.code = gen_code (temp_str) ;
        symbol = search_keyword (yylval.code) ;
        if (symbol == NULL) {    // no es palabra reservada -> identificador antes vrariabre
//               printf ("\nDEV: IDENTIF %s\n", yylval.code) ;    // PARA DEPURAR
            return (IDENTIF) ;
        } else {
//               printf ("\nDEV: OTRO %s\n", yylval.code) ;       // PARA DEPURAR
            return (symbol->token) ;
        }
    }

    if (strchr (ops_expandibles, c) != NULL) { // busca c en ops_expandibles
        cc = getchar () ;
        sprintf (temp_str, "%c%c", (char) c, (char) cc) ;
        symbol = search_keyword (temp_str) ;
        if (symbol == NULL) {
            ungetc (cc, stdin) ;
            yylval.code = NULL ;
            return (c) ;
        } else {
            yylval.code = gen_code (temp_str) ; // aunque no se use
            return (symbol->token) ;
        }
    }

//    printf ("\nDEV: LITERAL %d #%c#\n", (int) c, c) ;      // PARA DEPURAR
    if (c == EOF || c == 255 || c == 26) {
//         printf ("tEOF ") ;                                // PARA DEPURAR
        return (0) ;
    }

    return c ;
}

int main ()
{
    yyparse () ;
}
