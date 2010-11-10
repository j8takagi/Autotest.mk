%{
#define YYSTYPE double          /* data type of yacc stack */
#include <stdio.h>
#include <ctype.h>
%}

%token  NUMBER
%left   '+' '-'                 /* left associative, same precedence */
%left   '*' '/' '%'             /* left associative, higher precedence */
%left   UNARYMINUS UNARYPLUS
%%
list:                           /* nothing */
        | list '\n'
        | list expr '\n'        { printf("\t%.8g\n", $2); }
;
expr:   NUMBER          { $$ = $1; }
        | expr '+' expr { $$ = $1 + $3; }
        | expr '-' expr { $$ = $1 - $3; }
        | expr '*' expr { $$ = $1 * $3; }
        | expr '/' expr { $$ = $1 / $3; }
        | expr '%' expr { $$ = (int)$1 % (int)$3; }
        | '(' expr ')'{ $$ = $2; }
        | '-' expr %prec UNARYMINUS { $$ = -$2; }
        | '+' expr %prec UNARYPLUS { $$ = $2; }
;
%%                              /* end of grammer */

char *progname;                 /* for error messages */
int lineno = 1;

int main(int argc, char *argv[]) {
    progname = argv[0];
    yyparse();
}

int yylex(){
    int c;
    while((c = getchar()) == ' ' || c == '\t') {
        ;
    }
    if(c == EOF) {
        return 0;
    }
    /* number */
    if(c == '.' || isdigit(c)) {
        ungetc(c, stdin);
        scanf("%lf", &yylval);
        return NUMBER;
    }
    if(c == '\n') {
        lineno++;
    }
    return c;
}

/* called for yacc syntax error */
int yyerror(char *s) {
    warning(s, (char *)0);
}

/* print warning message */
int warning(char *s, char *t) {
    fprintf(stderr, "%s: %s", progname, s);
    if(t) {
        fprintf(stderr, " %s", t);
    }
    fprintf(stderr, " near line %d\n", lineno);
}
