%{
#include <stdlib.h>
#include "y.tab.h"

void yyerror(char *);
%}

INTEGER  0|\-?[1-9]([[:digit:]]+)?
FRACTION [[:digit:]]+
NAN      {INTEGER},{FRACTION}
FLOAT    {INTEGER}.{FRACTION}
EXPONENT ({INTEGER}|{FLOAT})[eE][+-]?{FRACTION}
NUMBER   {INTEGER}|{FLOAT}|{EXPONENT}
STRING   \"[^\"\\\/\b\f\n\r\t]+\"

%%

{STRING}            return string;
{NAN}               return nan;
{NUMBER}            return number;
true                return true;
false               return false;
null                return null;
\:                  return colon;
\,                  return comma;
\{                  return open_curly;
\}                  return close_curly;
\[                  return open_square;
\]                  return close_square;
[[:space:]]         ;
[[:^space:]]        ;

%%

int yywrap() {
  return 1;
}
