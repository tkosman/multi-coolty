#!/bin/sh
cat > bf2c_tmp.py <<'PY_EOF'
import sys
bf = sys.stdin.read()
print("#include <stdio.h>")
print("void hello_world(void) {")
print("    unsigned char t[30000] = {0};")
print("    unsigned char *p = t;")
for c in bf:
    if c == '>':
        print("    ++p;")
    elif c == '<':
        print("    --p;")
    elif c == '+':
        print("    ++*p;")
    elif c == '-':
        print("    --*p;")
    elif c == '.':
        print("    putchar(*p);")
    elif c == ',':
        print("    *p = getchar();")
    elif c == '[':
        print("    while (*p) {")
    elif c == ']':
        print("    }")
print("}")
PY_EOF
python3 bf2c_tmp.py < hello_brainfuck.bf > brainfuck_gen.c
gcc -fPIC -shared brainfuck_gen.c -o hello_brainfuck.so
