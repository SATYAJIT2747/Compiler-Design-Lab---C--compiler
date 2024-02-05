%option yylineno

%{
#include<stdio.h>
#include"project.tab.h"
#include<math.h>
%}

%%
"#include"([ ]+)?((<(\\.|[^>])+>)|(\"(\\.|[^"])+\")) { printf("HEADER: %s\n", yytext); return HEADER; }
"#define"[ ]+[a-zA-z_][a-zA-z_0-9]*                  { printf("DEFINE: %s\n", yytext); return DEFINE; }
"auto"|"register"|"static"|"extern"|"typedef"       { printf("STORAGE CLASS: %s\n", yytext); return storage_const; }
"void"|"char"|"short"|"int"|"long"|"float"|"double"|"signed"|"unsigned" { printf("TYPE: %s\n", yytext); return type_const; }
"const"|"volatile"                                { printf("TYPE QUALIFIER: %s\n", yytext); return qual_const; }
"enum"                                            { printf("ENUM: %s\n", yytext); return enum_const; }
"case"                                            { printf("CASE: %s\n", yytext); return CASE; }
"default"                                         { printf("DEFAULT: %s\n", yytext); return DEFAULT; }
"if"                                              { printf("IF: %s\n", yytext); return IF; }
"switch"                                          { printf("SWITCH: %s\n", yytext); return SWITCH; }
"else"                                            { printf("ELSE: %s\n", yytext); return ELSE; }
"for"                                             { printf("FOR: %s\n", yytext); return FOR; }
"do"                                              { printf("DO: %s\n", yytext); return DO; }
"while"                                           { printf("WHILE: %s\n", yytext); return WHILE; }
"goto"                                            { printf("GOTO: %s\n", yytext); return GOTO; }
"continue"                                        { printf("CONTINUE: %s\n", yytext); return CONTINUE; }
"break"                                           { printf("BREAK: %s\n", yytext); return BREAK; }
"struct"|"union"                                  { printf("STRUCT/UNION: %s\n", yytext); return struct_const; }
"return"                                          { printf("RETURN: %s\n", yytext); return RETURN; }
"sizeof"                                          { printf("SIZEOF: %s\n", yytext); return SIZEOF; }
"||"                                              { printf("OR: %s\n", yytext); return or_const; }
"&&"                                              { printf("AND: %s\n", yytext); return and_const; }
"..."                                             { printf("PARAMETER: %s\n", yytext); return param_const; }
"=="|"!="                                         { printf("COMPARISON: %s\n", yytext); return eq_const; }
"<="|">="                                         { printf("RELATIONAL OPERATOR: %s\n", yytext); return rel_const; }
">>"|"<<"                                         { printf("SHIFT OPERATOR: %s\n", yytext); return shift_const; }
"++"|"--"                                         { printf("INCREMENT/DECREMENT: %s\n", yytext); return inc_const; }
"->"                                              { printf("POINTER OPERATION: %s\n", yytext); return point_const; }
";"|"="|","|"{"|"}"|"("|")"|"["|"]"|"*"|"+"|"-"|"/"|"?"|":"|"&"|"|"|"^"|"!"|"~"|"%"|"<"|">" { printf("PUNCTUATION/OPERATOR: %s\n", yytext); return yytext[0]; }
"*="|"/="|"+="|"%="|">>="|"-="|"<<="|"&="|"^="|"|=" { printf("COMPOUND ASSIGNMENT: %s\n", yytext); return PUNC; }
[0-9]+                                            { printf("INTEGER CONSTANT: %s\n", yytext); return int_const; }
[0-9]+"."[0-9]+                                   { printf("FLOATING CONSTANT: %s\n", yytext); return float_const; }
"'"."'"                                           { printf("CHARACTER CONSTANT: %s\n", yytext); return char_const; }
[a-zA-z_][a-zA-z_0-9]*                            { printf("IDENTIFIER: %s\n", yytext); return id; }
\"(\\.|[^\"])*\"                                 { printf("STRING CONSTANT: %s\n", yytext); return string; }
"//"(\\.|[^\n])*[\n]                               ; // Comment, do nothing
[/][*]([^*]|[*]*[^*/])*[*]+[/]                    ; // Multiline Comment, do nothing
[ \t\n]                                           ; // Whitespace, do nothing
%%

int yywrap(void)
{
    return 1;
}
