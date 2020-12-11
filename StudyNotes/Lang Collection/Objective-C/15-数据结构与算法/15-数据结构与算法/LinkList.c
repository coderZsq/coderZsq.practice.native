////
////  LinkList.c
////  15-数据结构与算法
////
////  Created by 朱双泉 on 2020/12/10.
////
//
//const int LinkListNotFound = -1; // 数据找不到返回值
//typedef void * LinkListNodeValue; // 节点里面的数据
//
//typedef struct _LinkListNode LinkListNode;
//
//struct _LinkListNode {
//    LinkListNodeValue value; // 数据
//    LinkListNode *next; // 下一个节点
//};
//
//// 线性表
//typedef struct {
//    int length; // 长度(当前节点的数量)
//    LinkListNode *header; // 头结点(header->next用来指向首元素)
//} LinkList;
//
//#define typedef_LinkList
//
//#include "LinkList.h"
//#include <stdlib.h>
//
//void List_Print(LinkList *list, LinkListPrintFunc func)
//{
//    if (list == NULL) return;
//    
//    printf("length = %d\n", list->length);
//    printf("value = [");
//    for (int i = 0; i < list->length; i++) {
////        if (func) { // 如果有传递打印函数
////            func(list->values[i]);
////        } else {
////            printf("%p", list->values[i]);
////        }
////        if (i != list->length - 1) {
////            printf(", ");
////        }
//    }
//    printf("]\n\n");
//}
//
//LinkList *List_Create(void)
//{
//    // 分配线性表对象的空间
//    LinkList *list = malloc(sizeof(LinkList) + sizeof(LinkListNode));
//    if (list) {
//        list->length = 0;
//        list->header = (LinkListNode *)(list + 1);
//    }
//    return list;
//}
//
//void List_Clear(LinkList *list)
//{
//
//}
//
//void List_Destroy(LinkList *list)
//{
//
//}
//
//int List_Length(LinkList *list)
//{
//    if (list == NULL) return 0;
//    
//    return list->length;
//}
//
//LinkListNodeValue List_Get(LinkList *list, int index)
//{
//    if (list == NULL || index < 0 || index >= list->length) return NULL;
//    
//    LinkListNode *currentNode = list->header;
//    for (int i = 0; i <= index; i++) { // i的最大值是index
//        currentNode = currentNode->next;
//        // currentNode刚好是线性表中第i个节点
//    }
//    return currentNode->value;
//}
//
//void List_Insert(LinkList *list, int index, LinkListNodeValue value)
//{
//    if (list == NULL || index < 0 || index > list->length) return;
//    
//    // 创建新节点
//    LinkListNode *newNode = malloc(sizeof(LinkListNode));
//    if (newNode == NULL) return;
//    newNode->value = value;
//    
//    // 找到index - 1位置的节点
//    LinkListNode *currentNode = list->header;
//    for (int i = 0; i < index; i++) { // i的最大值是index - 1
//        currentNode = currentNode->next;
//        // currentNode刚好是线性表中第i个节点
//    }
//    
//    // 现在currentNode就是index - 1位置的节点
//    newNode->next = currentNode->next; // 新节点的next指向index位置的节点
//    currentNode->next = newNode; // index - 1位置的节点的next指向新节点
//    
//    // 数量增加
//    list->length++;
//}
//
//void List_Add(LinkList *list, LinkListNodeValue value)
//{
//    if (list == NULL) return;
//    
//    List_Insert(list, list->length, value);
//}
//
//void List_Set(LinkList *list, int index, LinkListNodeValue value)
//{
//    if (list == NULL || index < 0 || index >= list->length) return;
//    
//    list->values[index] = value;
//}
//
//LinkListNodeValue List_Remove(LinkList *list, int index)
//{
//    if (list == NULL || index < 0 || index >= list->length) return NULL;
//    
//    // 获取需要删除的数据
//    LinkListNodeValue value = list->values[index];
//    
//    // 从index+1位置开始所有的数据往前移动
//    for (int i = index + 1; i < list->length; i++) {
//        list->values[i - 1] = list->values[i];
//    }
//    
//    // 数量减少
//    list->length--;
//    return value;
//}
//
//void List_Remove_Value(LinkList *list, LinkListNodeValue value)
//{
//    if (list == NULL) return;
//    
//    // 记录所删除数据的数量
//    int removeCount = 0;
//    
//    // 遍历所有的元素
//    for (int i = 0; i < list->length; i++) {
//        if (list->values[i] == value) { // 需要删除
//            // 被删除的数量增减
//            removeCount++;
//        } else {
//            list->values[i - removeCount] = list->values[i];
//        }
//    }
//    
//    // 数量减少
//    list->length -= removeCount;
//}
//
//int List_Index(LinkList *list, LinkListNodeValue value)
//{
//    if (list == NULL) return LinkListNotFound;
//    
//    // 遍历所有的元素
//    for (int i = 0; i < list->length; i++) {
//        if (list->values[i] == value) { // 找到了
//            return i;
//        }
//    }
//    return LinkListNotFound;
//}
