//
//  ArrayList.c
//  15-数据结构与算法
//
//  Created by 朱双泉 on 2020/12/10.
//

const static int ExpandCapacity = 10; // 每次扩容的数量
const int ArrayListNotFound = -1; // 数据找不到返回值
typedef void * ArrayListNodeValue; // 节点里面的数据
// 线性表
typedef struct {
    int capacity; // 容量
    int length; // 长度(当前节点的数量)
    ArrayListNodeValue *values;
} ArrayList;

#define typedef_ArrayList

#include "ArrayList.h"
#include <stdlib.h>
#include <string.h>

void List_Print(ArrayList *list, ArrayListPrintFunc func)
{
    if (list == NULL) return;
    
    printf("length = %d\n", list->length);
    printf("capacity = %d\n", list->capacity);
    printf("value = [");
    for (int i = 0; i < list->length; i++) {
        if (func) { // 如果有传递打印函数
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

ArrayList *List_Create(int capacity)
{
    /* 错误写法
     ArrayList list;
     list.capacity = capacity;
     list.length = 0;
     list.values = NULL;
     
     ArrayList *pList = &list;
     return pList;
     */
    if (capacity < 0) return NULL;
    
    // 分配线性表对象的空间
    ArrayList *list = malloc(sizeof(ArrayList));
    if (list) {
        list->length = 0;
        list->capacity = capacity;
        list->values = capacity ? malloc(capacity * sizeof(ArrayListNodeValue)) : NULL;
    }
    return list;
}

void List_Clear(ArrayList *list)
{
    if (list == NULL) return;
    
    list->length = 0;
}

void List_Destroy(ArrayList *list)
{
    if (list == NULL) return;
    
    free(list->values);
    list->values = NULL;
    free(list);
    list = NULL;
}

int List_Length(ArrayList *list)
{
    if (list == NULL) return 0;
    
    return list->length;
}

ArrayListNodeValue List_Get(ArrayList *list, int index)
{
    if (list == NULL || index < 0 || index >= list->length) return NULL;
    
    return list->values[index];
}

void List_Insert(ArrayList *list, int index, ArrayListNodeValue value)
{
    if (list == NULL || index < 0 || index > list->length) return;
    
    // 判断需不需要扩容
    if (list->length == list->capacity) { // 需要扩容
        // 新的容量大小
        int newCapacity = list->capacity + ExpandCapacity;
        
        // 分配新的空间
        ArrayListNodeValue *newValues = malloc(sizeof(ArrayListNodeValue) * newCapacity);
        if (newValues == NULL) return;
        
        // 拷贝旧空间的数据 -> 新空间
        memcpy(newValues, list->values, sizeof(ArrayListNodeValue) * list->capacity);
        
        // 释放旧空间
        free(list->values);
        list->values = newValues;

        // 设置新的capacity
        list->capacity = newCapacity;
    }
    
    // 从index位置开始所有的数据往后移动
    for (int i = list->length - 1; i >= index; i--) {
        list->values[i + 1] = list->values[i];
    }
    // 设置新数据到index位置
    list->values[index] = value;
    // 数量增加
    list->length++;
}

void List_Add(ArrayList *list, ArrayListNodeValue value)
{
    if (list == NULL) return;
    
    List_Insert(list, list->length, value);
}

void List_Set(ArrayList *list, int index, ArrayListNodeValue value)
{
    if (list == NULL || index < 0 || index >= list->length) return;
    
    list->values[index] = value;
}

ArrayListNodeValue List_Remove(ArrayList *list, int index)
{
    if (list == NULL || index < 0 || index >= list->length) return NULL;
    
    // 获取需要删除的数据
    ArrayListNodeValue value = list->values[index];
    
    // 从index+1位置开始所有的数据往前移动
    for (int i = index + 1; i < list->length; i++) {
        list->values[i - 1] = list->values[i];
    }
    
    // 数量减少
    list->length--;
    return value;
}

void List_Remove_Value(ArrayList *list, ArrayListNodeValue value)
{
    if (list == NULL) return;
    
    // 记录所删除数据的数量
    int removeCount = 0;
    
    // 遍历所有的元素
    for (int i = 0; i < list->length; i++) {
        if (list->values[i] == value) { // 需要删除
            // 被删除的数量增减
            removeCount++;
        } else {
            list->values[i - removeCount] = list->values[i];
        }
    }
    
    // 数量减少
    list->length -= removeCount;
}

int List_Index(ArrayList *list, ArrayListNodeValue value)
{
    if (list == NULL) return ArrayListNotFound;
    
    // 遍历所有的元素
    for (int i = 0; i < list->length; i++) {
        if (list->values[i] == value) { // 找到了
            return i;
        }
    }
    return ArrayListNotFound;
}
