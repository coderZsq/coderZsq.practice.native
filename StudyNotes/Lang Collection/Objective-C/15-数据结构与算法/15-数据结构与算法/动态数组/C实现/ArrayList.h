//
//  ArrayList.h
//  15-数据结构与算法
//
//  Created by 朱双泉 on 2020/12/10.
//

#ifndef ArrayList_h
#define ArrayList_h

#include <stdio.h>

#ifndef typedef_ArrayList
// 节点里面的数据
typedef void * ArrayListNodeValue;
// 线性表
typedef void ArrayList;
#endif

// 数据找不到返回值
extern const int ArrayListNotFound;
// 打印函数
typedef void (*ArrayListPrintFunc)(ArrayListNodeValue value);

void List_Print(ArrayList *list, ArrayListPrintFunc func); // 打印

ArrayList *List_Create(int capacity); // 创建
void List_Clear(ArrayList *list); // 清空
void List_Destroy(ArrayList *list); // 销毁

int List_Length(ArrayList *list); // 获取长度
ArrayListNodeValue List_Get(ArrayList *list, int index); // 获取index位置对应的数据
int List_Index(ArrayList *list, ArrayListNodeValue value); // 获得某个数据对应的index位置

void List_Insert(ArrayList *list, int index, ArrayListNodeValue value); // 往index位置插入数据
void List_Add(ArrayList *list, ArrayListNodeValue value); // 往最后面位置添加数据
void List_Set(ArrayList *list, int index, ArrayListNodeValue value); // 设置index位置的数据

ArrayListNodeValue List_Remove(ArrayList *list, int index); // 删除index位置的数据
void List_Remove_Value(ArrayList *list, ArrayListNodeValue value); // 删除某种数据

#endif /* ArrayList_h */
