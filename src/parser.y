%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
void yyerror(const char *s);

extern FILE *yyin;
int erro = 0;
%}


%token TRUE FALSE NULO NUM STR
%token CHAVE_ESQ CHAVE_DIR COLC_ESQ COLC_DIR DOIS_PONT VIRG

%% /*REGRAS GRAMATICAIS*/

json : value ;

value : STR
      | NUM
      | TRUE
      | FALSE
      | NULO
      | object
      | array
      ;

object : CHAVE_ESQ pairs CHAVE_DIR
       | CHAVE_ESQ CHAVE_DIR
       ;

pairs : pairs VIRG pair
      | pair
      ;

pair : STR DOIS_PONT value ;

array : COLC_ESQ values COLC_DIR
      | COLC_ESQ COLC_DIR
      ;

values : values VIRG value
       | value
       ;

%%

void yyerror(const char *s) {
    erro = 1;
}

int main(int argc, char **argv) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Erro ao abrir arquivo");
            return 1;
        }
    }

    if (yyparse() == 0 && !erro)
        printf("JSON VÁLIDO\n");
    else
        printf("JSON INVÁLIDO\n");

    if (yyin && yyin != stdin) fclose(yyin);
    return 0;
}
