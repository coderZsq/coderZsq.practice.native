//
//  ArrayList.c
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/23.
//  Copyright © 2019 Castie!. All rights reserved.
//

typedef void * ArrayListNodeValue;

typedef struct {
    int capacity;
    int length;
    ArrayListNodeValue * values;
} ArrayList;

#define typedef_ArrayList

#include "ArrayList.h"
#include <stdlib.h>
#include <string.h>

const static int ExpandCapacity = 10;
const int ArrayListNotFound = -1;

void ArrayList_Print(ArrayList * list, ArrayListPrintFunc func) {
    if (list == NULL) return;
    printf("length = %d\n", list->length);
    printf("capacity = %d\n", list->capacity);
    printf("value = [");
    for (int i = 0; i < list->length; i++) {
        if (func) {
            func(list->values[i]);
        } else {
            printf("%p", list->values[i]);
        }
        if (i != list->length - 1) {
            printf(", ");
        }
    }
    printf("]\n\n");
}

ArrayList * ArrayList_Create(int capacity) {
    /* 错误写法
     ArrayList list;
     list.capacity = capacity;
     list.length = 0;
     list.values = NULL;
     ArrayList * pList = &list;
     return pList;
     */
    if (capacity < 0) return NULL;
    ArrayList * list = malloc(sizeof(ArrayList/* + capacity * sizeof(ArrayListNodeValue)*/));
    if (list) {
        list->length = 0;
        list->capacity = capacity;
        list->values = capacity ? malloc(capacity * sizeof(ArrayListNodeValue)) : NULL; //list + 1;
    }
    return list;
}

void ArrayList_Clear(ArrayList * list) {
    if (list == NULL) return;
    list->length = 0;
}

void ArrayList_Destory(ArrayList * list) {
    if (list == NULL) return;
    free(list->values);
    list->values = NULL;
    free(list);
    list->values = NULL;
}

int ArrayList_Length(ArrayList * list) {
    if (list == NULL) return 0;
    return list->length;
}

ArrayListNodeValue ArrayList_Get(ArrayList * list, int index) {
    if (list == NULL || index < 0 || index >= list->length) return NULL;
    return *(list->values + index); //list->values[index];
}

void ArrayList_Insert(ArrayList * list, int index, ArrayListNodeValue value) {
    if (list == NULL || index < 0 || index > list->length) return;
    if (list->length == list->capacity) {
        int newCapacity = list->capacity + ExpandCapacity;
        ArrayListNodeValue *newValues = malloc(sizeof(ArrayListNodeValue) * newCapacity);
        if (newValues == NULL) return;
        memcpy(newValues, list->values, sizeof(ArrayListNodeValue) * list->capacity);
        free(list->values);
        list->values = newValues;
        list->capacity = newCapacity;
    }
    for (int i = list->length - 1; i >= index; i--) {
        list->values[i + 1] = list->values[i];
    }
    list->values[index] = value;
    list->length++;
}

void ArrayList_Add(ArrayList * list, ArrayListNodeValue value) {
    if (list == NULL) return;
    ArrayList_Insert(list, list->length, value);
}

void ArrayList_Set(ArrayList * list, int index, ArrayListNodeValue value) {
    if (list == NULL  || index < 0 || index >= list->length) return;
    list->values[index] = value;
}

ArrayListNodeValue ArrayList_Remove(ArrayList * list, int index) {
    if (list == NULL  || index < 0 || index >= list->length) return NULL;
    ArrayListNodeValue value = list->values[index];
    for (int i = index + 1; i < list->length; i++) {
        list->values[i - 1] = list->values[i];
    }
    list->length--;
    return value;
}

void ArrayList_Remove_Value(ArrayList * list, ArrayListNodeValue value) {
    if (list == NULL) return;
    int removeCount = 0;
    for (int i = 0; i < list->length; i++) {
        if (list->values[i] == value) {
            removeCount++;
        } else {
            list->values[i - removeCount] = list->values[i];
        }
    }
    list->length -= removeCount;
}

int ArrayList_Index(ArrayList * list, ArrayListNodeValue value) {
    if (list == NULL) return ArrayListNotFound;
    for (int i = 0; i < list->length; i++) {
        if (list->values[i] == value) {
            return i;
        }
    }
    return ArrayListNotFound;
}
