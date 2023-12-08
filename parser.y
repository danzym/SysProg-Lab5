%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int yylineno;
extern int yylex();
extern void yyerror(const char *s);
extern FILE *yyin;

%}

%token PLUS MINUS TIMES DIVIDE POWER LPAREN RPAREN ENTER

%left PLUS MINUS
%left TIMES DIVIDE
%right POWER
%nonassoc UMINUS

%union {
    struct {
        double val;
    } num;
}

%type <num> expression
%token <num> NUMBER

%%

calculations:
    | calculations expression ENTER { printf("Result: %f\n", $2.val); }
    ;

expression:
    expression PLUS expression      { $$.val = $1.val + $3.val; }
  | expression MINUS expression    { $$.val = $1.val - $3.val; }
  | expression TIMES expression    { $$.val = $1.val * $3.val; }
  | expression DIVIDE expression   { $$.val = $1.val / $3.val; }
  | expression POWER expression    { $$.val = pow($1.val, $3.val); }
  | LPAREN expression RPAREN       { $$.val = $2.val; }
  | MINUS expression %prec UMINUS  { $$.val = -$2.val; }
  | NUMBER                         { $$.val = $1.val; }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error at line %d: %s\n", yylineno, s);
}

int main(void) {
    yyin = stdin;
    yyparse();
    return 0;
}
