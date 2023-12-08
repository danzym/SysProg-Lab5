%{
#include "parser.h"
%}

%%

[0-9]+(\.[0-9]+)?   { yylval.num.val = atof(yytext); return NUMBER; }

"-"                 { return MINUS; }
"+"                 { return PLUS; }
"*"                 { return TIMES; }
"/"                 { return DIVIDE; }
"^"                 { return POWER; }
"("                 { return LPAREN; }
")"                 { return RPAREN; }
"\n"                { return ENTER; }

[ \t]+
.                   { printf("Unexpected character: %s\n", yytext); }

%%

int yywrap(void) { return 1; }
