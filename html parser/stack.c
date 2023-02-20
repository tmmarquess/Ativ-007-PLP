#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Stack
{
    char *value;
    struct Stack *next;
} Stack;

Stack *create_item(char *value)
{
    Stack *new_item = malloc(sizeof(Stack));
    new_item->value = value;
    new_item->next = NULL;
    return new_item;
}

void add_value(Stack **stack, char *value)
{
    if ((*stack) == NULL)
    {
        (*stack) = create_item(value);
        return;
    }
    Stack *first_value = (*stack);
    Stack *new_item = create_item(value);
    new_item->next = (*stack);
    (*stack) = new_item;
}

char *remove_value(Stack **stack)
{
    if ((*stack) == NULL)
    {
        return NULL;
    }
    Stack *item = (*stack);
    char *value = item->value;
    (*stack) = item->next;
    free(item);
    return value;
}

void show_stack(Stack *stack)
{
    Stack *first_item = stack;
    while (first_item != NULL)
    {
        printf("%s -> ", first_item->value);
        first_item = first_item->next;
    }
    printf("\n");
}

void check_tag_match(Stack **stack, char *close_tag)
{
    char *open_tag = remove_value(stack);
    char *closing = "</";
    open_tag = open_tag + 1;
    char *new_tag = malloc(strlen(closing) + strlen(open_tag) + 1);
    strcpy(new_tag, closing);
    strcat(new_tag, open_tag);

    if (strcmp(new_tag, close_tag))
    {
        printf("false\n");
        exit(1);
    }
}

void finish_code(Stack **stack)
{
    char *last_tag = remove_value(stack);
    if (last_tag == NULL)
    {
        printf("false\n");
        exit(1);
    }

    if (!strcmp(last_tag, "<!DOCTYPE html>"))
    {
        printf("true\n");
    }
    else
    {
        printf("false\n");
        exit(1);
    }
}

// int main()
// {
//     Stack *stack = NULL;
//     add_value(&stack, "<!DOCTYPE html>");
//     add_value(&stack, "<h1>");
//     check_tag_match(&stack, "</h1>");
//     add_value(&stack, "<h1>");
//     check_tag_match(&stack, "</h1>");
//     finish_code(&stack);
// }