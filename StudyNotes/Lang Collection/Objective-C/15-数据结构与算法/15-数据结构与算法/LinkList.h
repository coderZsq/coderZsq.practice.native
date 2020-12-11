//
//  LinkList.h
//  15-数据结构与算法
//
//  Created by 朱双泉 on 2020/12/10.
//

#ifndef LinkList_h
#define LinkList_h

#include <stdio.h>

#ifndef typedef_LinkList
// 节点里面的数据
typedef void * LinkListNodeValue;
// 线性表
typedef void LinkList;
#endif

// 数据找不到返回值
extern const int LinkListNotFound;
// 打印函数
typedef void (*LinkListPrintFunc)(LinkListNodeValue value);

void List_Print(LinkList *list, LinkListPrintFunc func); // 打印

LinkList *List_Create(void); // 创建
void List_Clear(LinkList *list); // 清空
void List_Destroy(LinkList *list); // 销毁

int List_Length(LinkList *list); // 获取长度
LinkListNodeValue List_Get(LinkList *list, int index); // 获取index位置对应的数据
int List_Index(LinkList *list, LinkListNodeValue value); // 获得某个数据对应的index位置

void List_Insert(LinkList *list, int index, LinkListNodeValue value); // 往index位置插入数据
void List_Add(LinkList *list, LinkListNodeValue value); // 往最后面位置添加数据
void List_Set(LinkList *list, int index, LinkListNodeValue value); // 设置index位置的数据

LinkListNodeValue List_Remove(LinkList *list, int index); // 删除index位置的数据
void List_Remove_Value(LinkList *list, LinkListNodeValue value); // 删除某种数据

#endif /* LinkList_h */
