#include "stack.h"
#include "stdio.h"
#include "stdlib.h"


#define START_TESTING_FUNCTION printf("------------------ testing function %s ------------------\n", __FUNCTION__)
#define END_TESTING_FUNCTION do{printf("WRONG BEHAVIOUR: TESTING FUNCTION %s WAS NOT FAILED\n", __FUNCTION__); abort(); } while (0)

#define $(f) do{enum stack_error_code err = 0; if ((err = f) != 0) { printf("OK: CodeLine %s:%s:%d [%s] returned error %d (%s)\n", __FILE__, __FUNCTION__, __LINE__, #f, err, stack_get_error_string(err)); return; }}while(0)

void test_100()
{
    START_TESTING_FUNCTION;

    struct stack_t stk1;

    $(stack_init(&stk1));

    END_TESTING_FUNCTION;
}

void test_112()
{
    START_TESTING_FUNCTION;

    struct stack_t stk1;
    
    $(stack_destroy(&stk1));

    END_TESTING_FUNCTION;
}

void test_125()
{
    START_TESTING_FUNCTION;

    struct stack_t stk1 = {};
    
    $(stack_destroy(&stk1));

    END_TESTING_FUNCTION;
}

void test_137()
{
    START_TESTING_FUNCTION;

    struct stack_t stk1;
    
    $(stack_push(&stk1, 0));

    END_TESTING_FUNCTION;
}

void test_138()
{
    START_TESTING_FUNCTION;

    struct stack_t stk1 = {};
    
    $(stack_push(&stk1, 0));

    END_TESTING_FUNCTION;
}

void test_143()
{
    START_TESTING_FUNCTION;

    struct stack_t stk1;
    
    $(stack_pop(&stk1, NULL));

    END_TESTING_FUNCTION;
}

void test_144()
{
    START_TESTING_FUNCTION;

    struct stack_t stk1 = {};
    
    $(stack_pop(&stk1, NULL));

    END_TESTING_FUNCTION;
}

void test_150()
{
    START_TESTING_FUNCTION;

    struct stack_t stk1 = {};

    $(stack_init(&stk1));
    
    $(stack_destroy(&stk1));
    
    $(stack_destroy(&stk1));

    END_TESTING_FUNCTION;
}

void test_175()
{
    START_TESTING_FUNCTION;

    struct stack_t stk1 = {};

    $(stack_init(&stk1));
    
    $(stack_init(&stk1));
    
    $(stack_destroy(&stk1));

    END_TESTING_FUNCTION;
}

void test_200()
{
    START_TESTING_FUNCTION;
    
    struct stack_t stk1 = {};

    $(stack_init(&stk1));

    $(stack_pop(&stk1, NULL));
    
    END_TESTING_FUNCTION;
}

void test_300()
{
    START_TESTING_FUNCTION;
    
    struct stack_t stk1 = {};

    $(stack_init(&stk1));

    for (int i = 0; i < 128; ++i)
    {
        $(stack_push(&stk1, i));
    }
    for (int i = 128 - 1; i >= 0; --i)
    {
        stack_value_t out = 0;
        $(stack_pop(&stk1, &out));
        if (out != i)
        {
            printf("ERROR: Push and pop order is wrong; get %d instead of %d\n", out, i);
        }
    }
    printf("OK: Test passed\n");
}

void test_325()
{
    START_TESTING_FUNCTION;
    
    struct stack_t stk1 = {};

    $(stack_init(&stk1));
    
    $(stack_push(&stk1, 1));
    $(stack_push(&stk1, 2));

    stk1.data[0] += 1;

    $(stack_destroy(&stk1));
    
    END_TESTING_FUNCTION;
}

void test_337()
{
    START_TESTING_FUNCTION;
    
    struct stack_t stk1 = {};

    $(stack_init(&stk1));

    stk1.data_len = 1;

    $(stack_destroy(&stk1));
    
    END_TESTING_FUNCTION;
}

void test_350()
{
    START_TESTING_FUNCTION;
    
    struct stack_t stk1 = {};

    $(stack_init(&stk1));

    stack_value_t x = 1;
    
    $(stack_push(&stk1, x));
    
    $(stack_push(&stk1, x + 1));
    
    $(stack_push(&stk1, x + 2));
    
    $(stack_push(&stk1, x + 3));

    stk1.data[0] = 0;

    $(stack_pop(&stk1, &x));

    $(stack_destroy(&stk1));
    
    END_TESTING_FUNCTION;
}

void test_375()
{
    START_TESTING_FUNCTION;
    
    struct stack_t stk1 = {};

    $(stack_init(&stk1));

    stack_value_t x = 1;

    for (int i = 0; i < 1024; ++i)
    {
        $(stack_push(&stk1, x + i));
    }

    stk1.data[0] = 0;

    $(stack_pop(&stk1, &x));

    $(stack_destroy(&stk1));
    
    END_TESTING_FUNCTION;
}

void test_400()
{
    START_TESTING_FUNCTION;
    
    struct stack_t stk1 = {};

    $(stack_init(&stk1));

    stk1.data[0] = 0;

    $(stack_destroy(&stk1));
    
    END_TESTING_FUNCTION;
}

void test_500()
{
    START_TESTING_FUNCTION;
    
    struct stack_t stk1 = {};

    stk1.data = calloc(16, sizeof(*stk1.data));
    stk1.data_len = 1;
    stk1.data_alloc = 16;
    stk1.data[0] = 0;

    $(stack_destroy(&stk1));
    
    END_TESTING_FUNCTION;
}



int main()
{
    test_100();
    test_112();
    test_125();
    test_137();
    test_138();
    test_143();
    test_144();
    test_150();
    test_175();
    test_200();
    test_300();
    test_325();
    test_337();
    test_350();
    test_375();
    test_400();    
    test_500();    
    return 0;
}
