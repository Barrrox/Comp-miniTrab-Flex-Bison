%{
#include "parser.tab.h"
%}

%option noyywrap

TRUE      true
FALSE     false
NULO      null
NUM       -?[0-9]+
STR       \"[^\"]*\"
CHAVE_ESQ \{
CHAVE_DIR \}
COLC_ESQ  \[
COLC_DIR  \]
DOIS_PONT \:
VIRG      ,

%%

{TRUE}       { return TRUE; }
{FALSE}      { return FALSE; }
{NULO}       { return NULO; }
{NUM}        { return NUM; }
{STR}        { return STR; }
{CHAVE_ESQ}  { return CHAVE_ESQ; }
{CHAVE_DIR}  { return CHAVE_DIR; }
{COLC_ESQ}   { return COLC_ESQ; }
{COLC_DIR}   { return COLC_DIR; }
{DOIS_PONT}  { return DOIS_PONT; }
{VIRG}       { return VIRG; }
[ \t\r\n]+   { /* ignora espaços, tabs e quebras de linha */ }
.            { return yytext[0]; /* caractere inválido: o parser acusa erro */ }

%%
