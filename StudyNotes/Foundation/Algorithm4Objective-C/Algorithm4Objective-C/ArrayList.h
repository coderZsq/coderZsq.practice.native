//
//  ArrayList.h
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/23.
//  Copyright © 2019 Castie!. All rights reserved.
//

#ifndef ArrayList_h
#define ArrayList_h

#include <stdio.h>

#ifndef typedef_ArrayList
typedef void * ArrayListNodeValue;
typedef void ArrayList;
#endif

extern const int ArrayListNotFound;

typedef void (*ArrayListPrintFunc) (ArrayListNodeValue value);

void List_Print(ArrayList * list, ArrayListPrintFunc func);

ArrayList * List_Create(int capacity);
void List_Clear(ArrayList * list);
void List_Destory(ArrayList * list);

int List_Length(ArrayList * list);
ArrayListNodeValue List_Get(ArrayList * list, int index);
int List_Index(ArrayList * list, ArrayListNodeValue value);

void List_Insert(ArrayList * list, int index, ArrayListNodeValue value);
void List_Add(ArrayList * list, ArrayListNodeValue value);
void List_Set(ArrayList * list, int index, ArrayListNodeValue value);

ArrayListNodeValue List_Remove(ArrayList * list, int index);
void List_Remove_Value(ArrayList * list, ArrayListNodeValue value);

#endif /* ArrayList_h */
