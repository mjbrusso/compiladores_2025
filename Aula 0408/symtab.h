#ifndef SYMTAB_H
#define SYMTAB_H

#include <stdlib.h>

#define SYMTAB_SIZE 101  // Tamanho da tabela hash

// Estrutura para cada entrada (símbolo) na tabela
typedef struct symtab_entry {
    char *key;                // Chave (nome do símbolo)
    int defined;              // Flag para indicar se o símbolo foi definido (inicialmente 0)
    int value;                // Valor associado ao símbolo (inicialmente 0)
    struct symtab_entry *next;// Ponteiro para a próxima entrada (lista encadeada para colisões)
} SymtabEntry;

// Estrutura da tabela de símbolos (tabela hash)
typedef struct symtab {
    int size;               // Tamanho da tabela (número de buckets)
    SymtabEntry **buckets;  // Vetor de ponteiros para as listas encadeadas
} Symtab;

// Cria e inicializa a tabela de símbolos
Symtab *symtab_create(void);

// Insere o símbolo na tabela. Se a chave já existir, retorna o ponteiro para a entrada existente;
// caso contrário, insere a nova chave (com os demais valores zerados) e retorna o ponteiro para a nova entrada.
SymtabEntry *symtab_insert(Symtab *tab, const char *key);

// Libera a memória associada à tabela de símbolos, incluindo todas as entradas.
void symtab_destroy(Symtab *tab);

#endif // SYMTAB_H
