

// Compile with
// gcc -rdynamic -O3 -c -Wall -Werror -fpic d2i.c -o libd2i.o ; gcc -rdynamic -shared -o libd2i.so libd2i.o

int flo(double d)
{
    return (int)d;
}

int cei(double d)
{
    return (int){d+0.9999999};
}
