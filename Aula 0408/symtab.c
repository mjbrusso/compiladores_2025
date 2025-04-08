#include "symtab.h"
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

// Função hash baseada no algoritmo djb2
static unsigned int hash(const char *str, int table_size) {
    unsigned int hash = 5381;
    int c;
    while ((c = *str++))
        hash = ((hash << 5) + hash) + c;  // hash * 33 + c
    return hash % table_size;
}

// Cria a tabela de símbolos
Symtab *symtab_create(void) {
    Symtab *table = malloc(sizeof(Symtab));
    if (!table) {
        fprintf(stderr, "Erro ao alocar memória para a tabela de símbolos.\n");
        return NULL;
    }
    table->size = SYMTAB_SIZE;
    table->buckets = calloc(table->size, sizeof(SymtabEntry *));
    if (!table->buckets) {
        fprintf(stderr, "Erro ao alocar memória para os buckets da tabela.\n");
        free(table);
        return NULL;
    }
    return table;
}

// Insere um símbolo na tabela. Se a chave já existir, retorna o ponteiro para essa entrada.
// Caso contrário, cria uma nova entrada com a chave e com os valores default (0).
SymtabEntry *symtab_insert(Symtab *tab, const char *key) {
    if (!tab || !key)
        return NULL;

    unsigned int index = hash(key, tab->size);
    SymtabEntry *entry = tab->buckets[index];

    // Percorre a lista do bucket para verificar se a chave já existe
    while (entry) {
        if (strcmp(entry->key, key) == 0) {
            // Símbolo já está na tabela, retorna a entrada existente
            return entry;
        }
        entry = entry->next;
    }

    // Se não encontrou, cria uma nova entrada
    entry = malloc(sizeof(SymtabEntry));
    if (!entry) {
        fprintf(stderr, "Erro ao alocar memória para nova entrada.\n");
        return NULL;
    }
    entry->key = strdup(key);
    if (!entry->key) {
        fprintf(stderr, "Erro ao alocar memória para a chave.\n");
        free(entry);
        return NULL;
    }
    entry->defined = 0;
    entry->value = 0;
    // Insere a nova entrada no início da lista encadeada do bucket
    entry->next = tab->buckets[index];
    tab->buckets[index] = entry;

    return entry;
}

// Libera a memória utilizada pela tabela de símbolos e todas as suas entradas
void symtab_destroy(Symtab *tab) {
    if (!tab)
        return;

    for (int i = 0; i < tab->size; i++) {
        SymtabEntry *entry = tab->buckets[i];
        while (entry) {
            SymtabEntry *temp = entry;
            entry = entry->next;
            free(temp->key);
            free(temp);
        }
    }
    free(tab->buckets);
    free(tab);
}
