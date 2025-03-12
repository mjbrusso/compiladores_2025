
  

# Aula de 11/03

  
## Instalação do Gnu Flex
  

``` 
sudo apt update
sudo apt install flex
```
  
# Usando o flex
```
flex filename.l
gcc lex.yy.c -lfl
./a.out < input.txt
```
