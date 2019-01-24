//
//  ArrayList.c
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/23.
//  Copyright © 2019 Castie!. All rights reserved.
//

#include "ArrayList.h"
#include <stdlib.h>

const int ArrayListNotFound = -1;

void List_Print(ArrayList * list) {
    if (list == NULL) return;
    printf("length = %d\n", list->length);
    printf("capacity = %d\n", list->capacity);
    printf("value = [");
    for (int i = 0; i < list->length; i++) {
        printf("%d", list->values[i]);
        if (i != list->length - 1) {
            printf(", ");
        }
    }
    printf("]\n\n");
}

ArrayList * List_Create(int capacity) {
    /* 错误写法
     ArrayList list;
     list.capacity = capacity;
     list.length = 0;
     list.values = NULL;
     ArrayList * pList = &list;
     return pList;
     */
    if (capacity < 0) return NULL;
    ArrayList * list = malloc(sizeof(ArrayList));
    if (list) {
        list->length = 0;
        list->capacity = capacity;
        list->values = malloc(capacity * sizeof(ArrayListNodeValue));
    }
    return list;
}

void List_Clear(ArrayList * list) {
    if (list == NULL) return;
    list->length = 0;
}

void List_Destory(ArrayList * list) {
    if (list == NULL) return;
    free(list->values);
    free(list);
}

int List_Length(ArrayList * list) {
    if (list == NULL) return 0;
    return list->length;
}

ArrayListNodeValue List_Get(ArrayList * list, int index) {
    if (list == NULL || index < 0 || index >= list->length) return NULL;
    return *(list->values + index); //list->values[index];
}

void List_Insert(ArrayList * list, int index, ArrayListNodeValue value) {
    if (list == NULL || list->length == list->capacity || index < 0 || index > list->length) return;
    for (int i = list->length - 1; i >= index; i--) {
        list->values[i + 1] = list->values[i];
    }
    list->values[index] = value;
    list->length++;
}

void List_Add(ArrayList * list, ArrayListNodeValue value) {
    if (list == NULL) return;
    List_Insert(list, list->length, value);
}

void List_Set(ArrayList * list, int index, ArrayListNodeValue value) {
    if (list == NULL  || index < 0 || index >= list->length) return;
    list->values[index] = value;
}

ArrayListNodeValue List_Remove(ArrayList * list, int index) {
    if (list == NULL  || index < 0 || index >= list->length) return NULL;
    ArrayListNodeValue value = list->values[index];
    for (int i = index + 1; i < list->length; i++) {
        list->values[i - 1] = list->values[i];
    }
    list->length--;
    return value;
}

void List_Remove_Value(ArrayList * list, ArrayListNodeValue value) {
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

int List_Index(ArrayList * list, ArrayListNodeValue value) {
    if (list == NULL) return ArrayListNotFound;
    for (int i = 0; i < list->length; i++) {
        if (list->values[i] == value) {
            return i;
        }
    }
    return ArrayListNotFound;
}
