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

void ArrayList_Print(ArrayList * list, ArrayListPrintFunc func);

ArrayList * ArrayList_Create(int capacity);
void ArrayList_Clear(ArrayList * list);
void ArrayList_Destory(ArrayList * list);

int ArrayList_Length(ArrayList * list);
ArrayListNodeValue ArrayList_Get(ArrayList * list, int index);
int ArrayList_Index(ArrayList * list, ArrayListNodeValue value);

void ArrayList_Insert(ArrayList * list, int index, ArrayListNodeValue value);
void ArrayList_Add(ArrayList * list, ArrayListNodeValue value);
void ArrayList_Set(ArrayList * list, int index, ArrayListNodeValue value);

ArrayListNodeValue ArrayList_Remove(ArrayList * list, int index);
void ArrayList_Remove_Value(ArrayList * list, ArrayListNodeValue value);

#endif /* ArrayList_h */
