bison -d project.y         # Generates project.tab.c and project.tab.h
flex project.l             # Generates lex.yy.c

gcc -o parser lex.yy.c project.tab.c -L"C:\GnuWin32\lib" -lfl -ly -lm

parser.exe < "C:\Users\Satyajit\Desktop\CD LAB\LEXIXAL ANALYZER\input.c" > "C:\Users\Satyajit\Desktop\CD LAB\LEXIXAL ANALYZER\output.txt"
