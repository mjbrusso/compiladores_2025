
  

# Aula de 25/02

  
## Instalação das Ferramentas
  

``` 
sudo apt update
sudo apt install flex bison clang
```
  

# Etapas da compilação
 

### 1. Invocar apenas o pré-processor

```
clang -E filename.c -o filename.i
```

### 2. Compilar sem passar pelo pré-processor
  

```
clang -x c filename.i -c
```
  

### 3. Saída do Scanner (tokens)
 
```
clang -Xclang -dump-tokens -fsyntax-only filename.c
```
  
 
### 4. Saída do Parser (AST)

```
clang -Xclang -ast-dump -fsyntax-only filename.c
```
    
### 5. Gerar IR (representação intermediária LLVM)

```
clang -S -emit-llvm filename.c
```
   

### 6. Gerar Assembly (notação Intel)

```
 clang -S -masm=intel filename.c
```
   

### 7. Gerar código objeto (.o)

``` 
clang -c filename.c
```
  
### 8. Linker

```
clang filename.o -o programname
```
