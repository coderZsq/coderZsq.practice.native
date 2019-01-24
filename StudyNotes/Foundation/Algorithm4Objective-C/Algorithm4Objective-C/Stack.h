//
//  Stack.h
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

#ifndef Stack_h
#define Stack_h

typedef void * StackValue;
typedef void Stack;
typedef void (*StackPrintFunc)(StackValue value);

#include <stdio.h>

void Stack_Print(Stack *stack, StackPrintFunc func);

Stack *Stack_Create(int capaticy);
void Stack_Destroy(Stack *stack);
void Stack_Clear(Stack *stack);

void Stack_Push(Stack *stack, StackValue value);
StackValue Stack_Pop(Stack *stack);
StackValue Stack_Top(Stack *stack);
int Stack_Length(Stack *stack);

#endif /* Stack_h */
