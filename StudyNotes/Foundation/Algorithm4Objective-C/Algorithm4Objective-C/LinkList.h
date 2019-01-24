//
//  LinkList.h
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

#ifndef LinkList_h
#define LinkList_h

#include <stdio.h>

#ifndef typedef_LinkList
typedef void * LinkListNodeValue;
typedef void LinkList;
#endif

extern const int LinkListNotFound;
typedef void (*LinkListPrintFunc)(LinkListNodeValue value);

void LinkList_Print(LinkList *list, LinkListPrintFunc func);

LinkList *LinkList_Create();
void LinkList_Clear(LinkList *list);
void LinkList_Destroy(LinkList *list);

int LinkList_Length(LinkList *list);
LinkListNodeValue LinkList_Get(LinkList *list, int index);
int LinkList_Index(LinkList *list, LinkListNodeValue value);

void LinkList_Insert(LinkList *list, int index, LinkListNodeValue value);
void LinkList_Add(LinkList *list, LinkListNodeValue value);
void LinkList_Set(LinkList *list, int index, LinkListNodeValue value);

LinkListNodeValue LinkList_Remove(LinkList *list, int index);
void LinkList_Remove_Value(LinkList *list, LinkListNodeValue value);


#endif /* LinkList_h */
