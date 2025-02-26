// Programa de teste

#define MAGICNUMBER 9

int foo(int n){
    if(n<0)
        return -n; // Inverte o sinal
    else
        return n * 73 * MAGICNUMBER;
}