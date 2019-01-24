//
//  LinkList.c
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/24.
//  Copyright © 2019 Castie!. All rights reserved.
//

const int LinkListNotFound = -1;
typedef void * LinkListNodeValue;

typedef struct _LinkListNode LinkListNode;
struct _LinkListNode {
    LinkListNodeValue value;
    LinkListNode *next;
};

typedef struct {
    int length;
    LinkListNode *header;
} LinkList;

#define typedef_LinkList

#include "LinkList.h"
#include <stdlib.h>

void LinkList_Print(LinkList *list, LinkListPrintFunc func) {
    if(list == NULL) return;
    printf("length = %d\n", list->length);
    printf("value = [");
    LinkListNode *currentNode = list->header;
    for (int i = 0; i < list->length; i++) {
        currentNode = currentNode->next;
        if (func) {
            func(currentNode->value);
        } else {
            printf("%p", currentNode->value);
        }
        if (i != list->length - 1) {
            printf(", ");
        }
    }
    printf("]\n\n");
}

LinkList *LinkList_Create() {
    LinkList *list = malloc(sizeof(LinkList) + sizeof(LinkListNode));
    if (list) {
        list->length = 0;
        list->header = (LinkListNode *)(list + 1);
    }
    return list;
}

void LinkList_Clear(LinkList *list) {
    if (list == NULL) return;
    LinkListNode *currentNode = list->header;
    while (currentNode) {
        LinkListNode *nextNode = currentNode->next;
        if (nextNode == NULL) break;
        currentNode->next = nextNode->next;
        free(nextNode);
        nextNode = NULL;
    }
    list->header->next = NULL;
    list->length = 0;
}

void LinkList_Destroy(LinkList *list) {
    if (list == NULL) return;
    LinkList_Clear(list);
    free(list);
    list = NULL;
}

int LinkList_Length(LinkList *list) {
    if (list == NULL) return 0;
    return list->length;
}

LinkListNodeValue LinkList_Get(LinkList *list, int index) {
    if (list == NULL || index < 0 || index >= list->length) return NULL;
    LinkListNode *currentNode = list->header;
    for (int i = 0; i <= index; i++) {
        currentNode = currentNode->next;
    }
    return currentNode->value;
}

void LinkList_Insert(LinkList *list, int index, LinkListNodeValue value) {
    if (list == NULL || index < 0 || index > list->length) return;
    LinkListNode *newNode = malloc(sizeof(LinkListNode));
    newNode->value = value;
    if (newNode == NULL) return;
    LinkListNode *currentNode = list->header;
    for (int i = 0; i < index; i++) {
        currentNode = currentNode->next;
    }
    newNode->next = currentNode->next;
    currentNode->next = newNode;
    list->length++;
}

void LinkList_Add(LinkList *list, LinkListNodeValue value) {
    if (list == NULL) return;
    LinkList_Insert(list, list->length, value);
}

void LinkList_Set(LinkList *list, int index, LinkListNodeValue value) {
    if (list == NULL || index < 0 || index >= list->length) return;
    LinkListNode *currentNode = list->header;
    for (int i = 0; i <= index; i++) {
        currentNode = currentNode->next;
    }
    currentNode->value = value;
}

LinkListNodeValue LinkList_Remove(LinkList *list, int index) {
    if (list == NULL || index < 0 || index >= list->length) return NULL;
    LinkListNode *currentNode = list->header;
    for (int i = 0; i < index; i++) {
        currentNode = currentNode->next;
    }
    LinkListNode *removeNode = currentNode->next;
    currentNode->next = removeNode->next;
    LinkListNodeValue value = removeNode->value;
    free(removeNode);
    removeNode = NULL;
    list->length--;
    return value;
}

void LinkList_Remove_Value(LinkList *list, LinkListNodeValue value) {
    if (list == NULL) return;
    LinkListNode *currentNode = list->header;
    while (currentNode) {
        LinkListNode *nextNode = currentNode->next;
        if (nextNode->value == value) {
            currentNode->next = nextNode->next;
            free(nextNode);
            nextNode = NULL;
            list->length--;
        } else {
            currentNode = nextNode;
        }
    }
}

int LinkList_Index(LinkList *list, LinkListNodeValue value) {
    if (list == NULL) return LinkListNotFound;
    LinkListNode *currentNode = list->header;
    for (int i = 0; i < list->length; i++) {
        currentNode = currentNode->next;
        if (currentNode->value == value) return i;
    }
    return LinkListNotFound;
}
