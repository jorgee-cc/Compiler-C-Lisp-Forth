/* Backend: Lisp intermediate representation to Forth. */

%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

#define FF fflush(stdout);

int yylex();
void yyerror(char *);
char *my_malloc(int);
char *gen_code(char *);

typedef struct s_attr {
    int   value;
    char *code;
} t_attr;

#define YYSTYPE t_attr
%}

%token NUMBER
%token IDENTIF
%token STRING
%token MAIN
%token WHILE
%token LOOP
%token DO
%token SETQ
%token SETF
%token DEFUN
%token PRINT
%token PRINC
%token AND
%token OR
%token NOT
%token MOD
%token IF
%token PROGN
%token LEQ
%token GEQ
%token NEQ
%token NIL

%%

axiom:      exprSeq                                     { ; }
          ;

exprSeq:    expression1 r_exprSeq                       { ; }
          ;

r_exprSeq:  exprSeq                                     { ; }
          | /* lambda */                                 { ; }
          ;

expression1:
            expression                                  { ; }

          /* declaracion de variable global con valor numerico */
          | '(' SETQ IDENTIF { printf(" variable %s ", $3.code); } number ')'
            { printf(" %s ! \n", $3.code); }

          /* (make se tokeniza como IDENTIF; - y array como IDENTIF)           */
          | '(' SETQ IDENTIF '(' IDENTIF '-' IDENTIF NUMBER ')' ')'
            { /* (setq var (make-array n)): vectores no se traducen en backend */ }

          | '(' SETF IDENTIF expression ')'
            { printf(" %s ! \n", $3.code); }

          | '(' PRINT STRING ')'
            { printf(" .\" %s\" cr\n", $3.code); }

          | '(' PRINC STRING ')'
            { printf(" .\" %s\" ", $3.code); }

          /* princ con expresion numerica -> . (print entero de pila) */
          | '(' PRINC expression ')'
            { printf(" . \n"); }

          | '(' PROGN exprSeq ')'                       { ; }

          | '(' MAIN ')'
            { printf(" main\n"); }

          /* defun main: apertura de la definicion de la palabra main */
          | '(' DEFUN MAIN
            { printf(": main "); }
            '(' ')' exprSeq ')'
            { printf(" ; \n"); }

          /* defun de usuario: se parsea pero no se traduce (fuera de spec) */
          | '(' DEFUN IDENTIF
            { printf(": %s ", $3.code); }
            '(' opt_params ')' exprSeq ')'
            { printf(" ; \n"); }

          /* while -> begin [cond] while [cuerpo] repeat */
          | '(' LOOP WHILE
            { printf(" begin "); }
            expression
            { printf(" while "); }
            DO exprSeq ')'
            { printf(" repeat \n"); }

          /* if sin rama else: [cond] if [then] then */
          | '(' ifHead expression1 ')'
            { printf(" THEN\n"); }

          /* if con rama else: [cond] if [then] else [else] then */
          | '(' ifHead expression1
            { printf(" ELSE "); }
            expression1 ')'
            { printf(" THEN\n"); }
          ;

ifHead:     IF expression
            { printf(" IF "); }
          ;

expression:
            operand                                     { ; }

          | NIL                                         { ; }

          /* operadores aritmeticos */
          | '(' '+' expression expression ')'           { printf(" + "); }
          | '(' '-' expression expression ')'           { printf(" - "); }
          | '(' '*' expression expression ')'           { printf(" * "); }
          | '(' '/' expression expression ')'           { printf(" / "); }
          | '(' MOD expression expression ')'           { printf(" mod "); }

          /* operadores relacionales */
          | '(' '<' expression expression ')'           { printf(" < "); }
          | '(' '>' expression expression ')'           { printf(" > "); }
          | '(' LEQ expression expression ')'           { printf(" <= "); }
          | '(' GEQ expression expression ')'           { printf(" >= "); }
          | '(' '=' expression expression ')'           { printf(" = "); }

          /* /= en Lisp -> = 0= en Forth (igualdad + negar) */
          | '(' NEQ expression expression ')'           { printf(" = 0= "); }

          /* operadores logicos */
          | '(' AND expression expression ')'           { printf(" and "); }
          | '(' OR  expression expression ')'           { printf(" or "); }

          /* not en Lisp -> 0= en Forth */
          | '(' NOT expression ')'                      { printf(" 0= "); }

          /* menos unario */
          | '(' '-' expression ')'                      { printf(" negate "); }
          ;

operand:    IDENTIF
            { printf(" %s @ ", $1.code); }
          | number
            { ; }
          ;

number:     NUMBER
            { printf(" %d ", $1.value); }
          ;

/* parametros de funciones de usuario: se consumen sin traducir */
opt_params: /* lambda */                                { ; }
          | lista_params                                { ; }
          ;

lista_params:
            IDENTIF                                     { ; }
          | lista_params IDENTIF                        { ; }
          ;

%%

int n_line = 1;

void yyerror(char *message)
{
    fprintf(stderr, "%s in line %d\n", message, n_line);
}

char *gen_code(char *name)
{
    char *p;
    int l;

    l = strlen(name) + 1;
    p = (char *) my_malloc(l);
    strcpy(p, name);
    return p;
}

char *my_malloc(int nbytes)
{
    char *p;
    static long int nb = 0;
    static int nv = 0;

    p = malloc(nbytes);
    if (p == NULL) {
        fprintf(stderr, "No memory left for additional %d bytes\n", nbytes);
        fprintf(stderr, "%ld bytes reserved in %d calls\n", nb, nv);
        exit(0);
    }
    nb += (long) nbytes;
    nv++;
    return p;
}

/***************************************************************************/
/***************************** Keyword Section *****************************/
/***************************************************************************/

typedef struct s_keyword {
    char *name;
    int   token;
} t_keyword;

t_keyword keywords[] = {
    "main",    MAIN,
    "defun",   DEFUN,
    "print",   PRINT,
    "princ",   PRINC,
    "loop",    LOOP,
    "while",   WHILE,
    "do",      DO,
    "setq",    SETQ,
    "setf",    SETF,
    "and",     AND,
    "or",      OR,
    "not",     NOT,
    "mod",     MOD,
    "if",      IF,
    "progn",   PROGN,
    "nil",     NIL,
    "<=",      LEQ,
    ">=",      GEQ,
    "/=",      NEQ,
    NULL,      0
};

t_keyword *search_keyword(char *symbol_name)
{
    int i;
    t_keyword *sim;

    i = 0;
    sim = keywords;
    while (sim[i].name != NULL) {
        if (strcmp(sim[i].name, symbol_name) == 0)
            return &(sim[i]);
        i++;
    }
    return NULL;
}

/***************************************************************************/
/******************** Section for the Lexical Analyzer  ********************/
/***************************************************************************/

int yylex()
{
    int i;
    unsigned char c;
    unsigned char cc;
    char expandable_ops[] = "!<>=|%&/-*+";
    char temp_str[256];
    t_keyword *symbol;

    do {
        c = getchar();
        if (c == '#') {
            do { c = getchar(); } while (c != '\n');
        }
        if (c == '/') {
            cc = getchar();
            if (cc != '/') {
                ungetc(cc, stdin);
            } else {
                c = getchar();
                if (c == '@') {
                    do {
                        c = getchar();
                        putchar(c);
                    } while (c != '\n' && c != EOF);
                    if (c == EOF)
                        ungetc(c, stdin);
                } else {
                    while (c != '\n')
                        c = getchar();
                }
            }
        }
        if (c == '\n')
            n_line++;
    } while (c == ' ' || c == '\n' || c == 10 || c == 13 || c == '\t');

    if (c == '\"') {
        i = 0;
        do {
            c = getchar();
            temp_str[i++] = c;
        } while (c != '\"' && i < 255);
        if (i == 256)
            fprintf(stderr, "WARNING: string with more than 255 characters in line %d\n", n_line);
        temp_str[--i] = '\0';
        yylval.code = gen_code(temp_str);
        return STRING;
    }

    if (c == '-') {
        cc = getchar();
        if (cc >= '0' && cc <= '9') {
            ungetc(cc, stdin);
            ungetc(c, stdin);
            scanf("%d", &yylval.value);
            return NUMBER;
        }
        ungetc(cc, stdin);
    }

    if (c == '.' || (c >= '0' && c <= '9')) {
        ungetc(c, stdin);
        scanf("%d", &yylval.value);
        return NUMBER;
    }

    if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z')) {
        i = 0;
        while (((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') ||
                (c >= '0' && c <= '9') || c == '_') && i < 255) {
            temp_str[i++] = tolower(c);
            c = getchar();
        }
        temp_str[i] = '\0';
        ungetc(c, stdin);

        yylval.code = gen_code(temp_str);
        symbol = search_keyword(yylval.code);
        if (symbol == NULL) {
            snprintf(temp_str, sizeof(temp_str), "v_%s", yylval.code);
            yylval.code = gen_code(temp_str);
            return IDENTIF;
        } else
            return symbol->token;
    }

    if (strchr(expandable_ops, c) != NULL) {
        cc = getchar();
        sprintf(temp_str, "%c%c", (char) c, (char) cc);
        symbol = search_keyword(temp_str);
        if (symbol == NULL) {
            ungetc(cc, stdin);
            yylval.code = NULL;
            return c;
        } else {
            yylval.code = gen_code(temp_str);
            return symbol->token;
        }
    }

    if (c == EOF || c == 255 || c == 26)
        return 0;

    return c;
}

int main()
{
    yyparse();
}
