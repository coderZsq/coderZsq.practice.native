//
//  Stack.c
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

#include "Stack.h"
#include "ArrayList.h"

void Stack_Print(Stack *stack, StackPrintFunc func)
{
    ArrayList_Print(stack, func);
}

Stack *Stack_Create(int capaticy)
{
    return ArrayList_Create(capaticy);
}

void Stack_Destroy(Stack *stack)
{
    ArrayList_Destory(stack);
}

void Stack_Clear(Stack *stack)
{
    ArrayList_Clear(stack);
}

void Stack_Push(Stack *stack, StackValue value)
{
    ArrayList_Add(stack, value);
}

StackValue Stack_Pop(Stack *stack)
{
    return ArrayList_Remove(stack, ArrayList_Length(stack) - 1);
}

StackValue Stack_Top(Stack *stack)
{
    return ArrayList_Get(stack, ArrayList_Length(stack) - 1);
}

int Stack_Length(Stack *stack)
{
    return ArrayList_Length(stack);
}
