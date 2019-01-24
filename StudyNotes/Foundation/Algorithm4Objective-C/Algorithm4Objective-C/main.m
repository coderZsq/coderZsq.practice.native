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

void printObject(ArrayListNodeValue value) {
    NSLog(@"%@", (__bridge Object *)value);
}

void testObjects() {
    Object *object1 = [Object objectWithString:@"string1"];
    Object *object2 = [Object objectWithString:@"string2"];
    Object *object3 = [Object objectWithString:@"string3"];
    ArrayList *list = List_Create(10);
    List_Add(list, (__bridge ArrayListNodeValue)(object1));
    List_Add(list, (__bridge ArrayListNodeValue)(object2));
    List_Add(list, (__bridge ArrayListNodeValue)(object2));
    List_Add(list, (__bridge ArrayListNodeValue)(object2));
    List_Add(list, (__bridge ArrayListNodeValue)(object3));
//    List_Add(list, (ArrayListNodeValue)20);
    List_Print(list, printObject);
    List_Remove_Value(list, (__bridge ArrayListNodeValue)(object2));
    List_Print(list, printObject);
//    Object *object = (__bridge Object *)(List_Get(list, 2));
//    [object sendMessage];
//    NSLog(@"last = %d", (int)List_Get(list, List_Length(list) - 1));
    List_Destory(list);
    list = NULL;
}

void testInts() {
    ArrayList * list = List_Create(10);
    List_Insert(list, 0, (ArrayListNodeValue)20);
    List_Add(list, (ArrayListNodeValue)30);
    List_Add(list, (ArrayListNodeValue)40);
    List_Add(list, (ArrayListNodeValue)50);
    List_Add(list, (ArrayListNodeValue)50);
    List_Print(list, NULL);
    List_Set(list, 1, (ArrayListNodeValue)25);
    List_Print(list, NULL);
    ArrayListNodeValue value = List_Get(list, 0);
    printf("value = %d\n\n", (int)value);
    int index = List_Index(list, (ArrayListNodeValue)40);
    printf("index = %d\n\n", index);
    List_Remove(list, 1);
    List_Remove_Value(list, (ArrayListNodeValue)50);
    List_Print(list, NULL);
    List_Clear(list);
    List_Print(list, NULL);
    List_Destory(list);
    list = NULL;
}

// (lldb) x/100xb list
void testInts2() {
    ArrayList *list = List_Create(5);
    List_Add(list, (ArrayListNodeValue)1);
    List_Add(list, (ArrayListNodeValue)2);
    List_Add(list, (ArrayListNodeValue)3);
    List_Add(list, (ArrayListNodeValue)4);
    List_Add(list, (ArrayListNodeValue)5);
    List_Remove(list, 3);
    List_Print(list, NULL);
    List_Destory(list);
    list = NULL;
}

// (lldb) x/100xb array
void testArray() {
    NSArray *array = @[@"1", @"2", @"3", @"4", @"5", @"6"];
    void *address = (__bridge void *)array;
    *((NSUInteger *)address + 1) = 10;
    NSLog(@"%zd", array.count);
    
    NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:3];
    [arrayM addObject:@"11"];
    [arrayM addObject:@"22"];
    [arrayM addObject:@"33"];
    [arrayM addObject:@"44"];
    [arrayM addObject:@"55"];
    NSLog(@"%zd", arrayM.count);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        testArray();
    }
    return 0;
}
