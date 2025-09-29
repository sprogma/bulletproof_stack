#include "stack.h"
#include "stdio.h"
#include "stdlib.h"
#include "math.h"


#define $(call) do {int err; if ((err = (call))) { fprintf(stderr, "stack operation returned error: %d (%s)\n", err, stack_get_error_string(err)); return 1; }} while (0)


int main()
{
    struct stack_t stk = {};

    $(stack_init(&stk));

    char command[64] = "";

    while (1)
    {
        if (scanf("%s63", command) != 1)
        {
            fprintf(stderr, "program must be stopped by hlt command.\n");
        }
        if (strcmp(command, "push") == 0)
        {
            int x = 0;
            if (scanf("%d", &x) != 1)
            {
                fprintf(stderr, "wrong push format. number expected");
            }
            $(stack_push(&stk, x));
        }
        else if (strcmp(command, "pop") == 0)
        {
            int x = 0;
            $(stack_pop(&stk, &x));
            printf("%d\n", x);
        }
        else if (strcmp(command, "dup") == 0)
        {
            int x = 0;
            $(stack_pop(&stk, &x));
            $(stack_push(&stk, x));
            $(stack_push(&stk, x));
        }
        else if (strcmp(command, "add") == 0)
        {
            int x = 0, y = 0;
            $(stack_pop(&stk, &y));
            $(stack_pop(&stk, &x));
            $(stack_push(&stk, x + y));
        }
        else if (strcmp(command, "mul") == 0)
        {
            int x = 0, y = 0;
            $(stack_pop(&stk, &y));
            $(stack_pop(&stk, &x));
            $(stack_push(&stk, x * y));
        }
        else if (strcmp(command, "sub") == 0)
        {
            int x = 0, y = 0;
            $(stack_pop(&stk, &y));
            $(stack_pop(&stk, &x));
            $(stack_push(&stk, x - y));
        }
        else if (strcmp(command, "div") == 0)
        {
            int x = 0, y = 0;
            $(stack_pop(&stk, &y));
            $(stack_pop(&stk, &x));
            if (y == 0)
            {
                fprintf(stderr, "division on zero\n");
                return 1;
            }
            $(stack_push(&stk, x / y));
        }
        else if (strcmp(command, "sqrt") == 0)
        {
            int x = 0;
            $(stack_pop(&stk, &x));
            if (x < 0)
            {
                fprintf(stderr, "sqrt from negative number\n");
                return 1;
            }
            $(stack_push(&stk, sqrt(x)));
        }
        else if (strcmp(command, "sqrt") == 0)
        {
            int x = 0;
            $(stack_pop(&stk, &x));
            $(stack_push(&stk, sqrt(x)));
        }
        else if (strcmp(command, "hlt") == 0)
        {
            return 0;
        }
        else
        {
            fprintf(stderr, "unknown command: %s\n", command);
        }
        command[0] = '\0';
    }
    
    return 0;
}
