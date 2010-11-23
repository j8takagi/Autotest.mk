%{
#define YYSTYPE double          /* data type of yacc stack */
#include <stdio.h>
#include <ctype.h>
#include <math.h>
%}

%token  NUMBER EOL
%left   '+' '-'                 /* left associative, same precedence */
%left   '*' '/' '%'             /* left associative, higher precedence */
%left   UNARYMINUS UNARYPLUS
%right  '^'
%%
list:                           /* nothing */
        | list EOL
        | list expr EOL        { printdouble($2); }
;
expr:   NUMBER          { $$ = $1; }
        | expr '+' expr { $$ = $1 + $3; }
        | expr '-' expr { $$ = $1 - $3; }
        | expr '*' expr { $$ = $1 * $3; }
        | expr '/' expr { $$ = $1 / $3; }
        | expr '%' expr { $$ = (int)$1 % (int)$3; }
        | expr '^' expr { $$ = pow($1, $3); }
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

int printdouble(double f) {
    if((f > 0 && f < 1e-15) || (f < 0 && f > -1e-15)) {
        printf("\t%.20e\n", f);
    } else {
        printf("\t%.20f\n", f);
    }
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
    if(c == '\n' || c == ';') {
        if(c == '\n') {
            lineno++;
        }
        return EOL;
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
