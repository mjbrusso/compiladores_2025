#include <assert.h>
#include <stdio.h>
#include "symtab.h"
#include "symtab.c"

int main(void) {
    // Criação da tabela de símbolos
    Symtab *table = symtab_create();
    assert(table != NULL);

    // Inserção de um novo símbolo "a"
    SymtabEntry *entry_a = symtab_insert(table, "a");
    assert(entry_a != NULL);
    assert(entry_a->defined == 0);
    assert(entry_a->value == 0);

    // Inserção de "a" novamente; deve retornar o mesmo ponteiro
    SymtabEntry *entry_a_again = symtab_insert(table, "a");
    assert(entry_a == entry_a_again);

    // Inserção de outro símbolo "b"
    SymtabEntry *entry_b = symtab_insert(table, "b");
    assert(entry_b != NULL);
    assert(entry_b != entry_a);

    // Modificando valores do símbolo "b" para testar a integridade dos dados
    entry_b->defined = 1;
    entry_b->value = 42;
    assert(entry_b->defined == 1);
    assert(entry_b->value == 42);

    // Mensagem de sucesso se todos os testes passarem
    printf("Todos os testes passaram com sucesso.\n");

    // Libera a memória da tabela
    symtab_destroy(table);

    return 0;
}
