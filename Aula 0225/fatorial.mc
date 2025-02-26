// Programa para calcular n! (fatorial de n)
var n = read();
var resultado = 1;
var i = 1;

while (i <= n) {
    resultado = resultado * i;
    i = i + 1;
}

print(resultado);
