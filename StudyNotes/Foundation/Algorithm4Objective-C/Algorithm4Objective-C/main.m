//
//  main.m
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/23.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArrayList.h"
#import "Object.h"
#import "NSArray+Address.h"
#import "LinkList.h"
#import "Stack.h"

void testStack() {
    Stack *stack = Stack_Create(10);
    Stack_Print(stack, NULL); // []
    Stack_Push(stack, (void *)10);
    Stack_Push(stack, (void *)2);
    Stack_Push(stack, (void *)4);
    Stack_Push(stack, (void *)5);
    Stack_Print(stack, NULL); // [10, 2, 4, 5]
    printf("%d\n", (int)Stack_Pop(stack));
    printf("%d\n", (int)Stack_Pop(stack));
    Stack_Print(stack, NULL); // [10, 2]
    printf("%d\n", (int)Stack_Top(stack)); // 2
    Stack_Pop(stack);
    Stack_Pop(stack);
    Stack_Pop(stack);
    Stack_Pop(stack);
    Stack_Print(stack, NULL); // []
    Stack_Push(stack, (void *)4);
    Stack_Clear(stack);
    Stack_Print(stack, NULL); // []
    Stack_Destroy(stack);
}

void printIntFunc(LinkListNodeValue value) {
    printf("%d", (int)value);
}

void LinkList_testInts() {
    LinkList *list = LinkList_Create(10);
    LinkList_Insert(list, 0, (LinkListNodeValue)20);
    LinkList_Add(list, (LinkListNodeValue)30);
    LinkList_Add(list, (LinkListNodeValue)50);
    LinkList_Add(list, (LinkListNodeValue)50);
    LinkList_Add(list, (LinkListNodeValue)40);
    LinkList_Add(list, (LinkListNodeValue)50);
    LinkList_Add(list, (LinkListNodeValue)50);
    
    LinkList_Print(list, printIntFunc);
    
    LinkList_Set(list, 1, (LinkListNodeValue)25);
    LinkList_Insert(list, 0, (LinkListNodeValue)77);
    
    LinkList_Print(list, printIntFunc);
    
    LinkListNodeValue value = LinkList_Get(list, 0);
    printf("value = %d\n\n", (int)value);
    
    int index = LinkList_Index(list, (LinkListNodeValue)50);
    printf("index = %d\n\n", index);
    
    LinkList_Remove(list, 1);
    LinkList_Remove_Value(list, (LinkListNodeValue)50);
    
    LinkList_Print(list, printIntFunc);
    
    LinkList_Clear(list);
    
    LinkList_Print(list, printIntFunc);
    
    LinkList_Destroy(list);
    list = NULL;
}

void printObject(ArrayListNodeValue value) {
    NSLog(@"%@", (__bridge Object *)value);
}

void testObjects() {
    Object *object1 = [Object objectWithString:@"string1"];
    Object *object2 = [Object objectWithString:@"string2"];
    Object *object3 = [Object objectWithString:@"string3"];
    ArrayList *list = ArrayList_Create(10);
    ArrayList_Add(list, (__bridge ArrayListNodeValue)(object1));
    ArrayList_Add(list, (__bridge ArrayListNodeValue)(object2));
    ArrayList_Add(list, (__bridge ArrayListNodeValue)(object2));
    ArrayList_Add(list, (__bridge ArrayListNodeValue)(object2));
    ArrayList_Add(list, (__bridge ArrayListNodeValue)(object3));
//    ArrayList_Add(list, (ArrayListNodeValue)20);
    ArrayList_Print(list, printObject);
    ArrayList_Remove_Value(list, (__bridge ArrayListNodeValue)(object2));
    ArrayList_Print(list, printObject);
//    Object *object = (__bridge Object *)(ArrayList_Get(list, 2));
//    [object sendMessage];
//    NSLog(@"last = %d", (int)List_Get(list, ArrayList_Length(list) - 1));
    ArrayList_Destory(list);
    list = NULL;
}

void ArrayList_testInts() {
    ArrayList * list = ArrayList_Create(10);
    ArrayList_Insert(list, 0, (ArrayListNodeValue)20);
    ArrayList_Add(list, (ArrayListNodeValue)30);
    ArrayList_Add(list, (ArrayListNodeValue)40);
    ArrayList_Add(list, (ArrayListNodeValue)50);
    ArrayList_Add(list, (ArrayListNodeValue)50);
    ArrayList_Print(list, NULL);
    ArrayList_Set(list, 1, (ArrayListNodeValue)25);
    ArrayList_Print(list, NULL);
    ArrayListNodeValue value = ArrayList_Get(list, 0);
    printf("value = %d\n\n", (int)value);
    int index = ArrayList_Index(list, (ArrayListNodeValue)40);
    printf("index = %d\n\n", index);
    ArrayList_Remove(list, 1);
    ArrayList_Remove_Value(list, (ArrayListNodeValue)50);
    ArrayList_Print(list, NULL);
    ArrayList_Clear(list);
    ArrayList_Print(list, NULL);
    ArrayList_Destory(list);
    list = NULL;
}

// (lldb) x/100xb list
void testInts2() {
    ArrayList *list = ArrayList_Create(5);
    ArrayList_Add(list, (ArrayListNodeValue)1);
    ArrayList_Add(list, (ArrayListNodeValue)2);
    ArrayList_Add(list, (ArrayListNodeValue)3);
    ArrayList_Add(list, (ArrayListNodeValue)4);
    ArrayList_Add(list, (ArrayListNodeValue)5);
    ArrayList_Remove(list, 3);
    ArrayList_Print(list, NULL);
    ArrayList_Destory(list);
    list = NULL;
}

void testInts3() {
    ArrayList *list = ArrayList_Create(5);
    for (int i = 0; i < 20; i++) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wint-to-void-pointer-cast"
        ArrayList_Add(list, (ArrayListNodeValue)i);
#pragma clang diagnostic pop
        NSLog(@"数量:%d, 首元素的地址:%p", ArrayList_Length(list), *((void **)list + 1));
    }
    ArrayList_Print(list, NULL);
    ArrayList_Destory(list);
    list = NULL;
}

// (lldb) x/100xb array
void testArray() {
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5", @"6"];
    void *address = (__bridge void *)array;
    *((NSUInteger *)address + 1) = 10;
    NSLog(@"%zd", array.count);
    
    NSLog(@"字符串11的地址是:%p", @"11");
    NSMutableArray * arrayM = [NSMutableArray array];
    NSLog(@"数组元素的首地址:%p", arrayM.elementsAddress);
    for (int i = 0; i < 100; i++) {
        [arrayM addObject:@"11"];
        NSLog(@"数组元素个数:%zd, 数组元素的首地址:%p", array.count, array.elementsAddress);
    }
    NSLog(@"%zd", arrayM.count);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testStack();
    }
    return 0;
}
