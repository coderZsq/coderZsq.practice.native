//
//  main.m
//  15-数据结构与算法
//
//  Created by 朱双泉 on 2020/12/4.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
    }
    return 0;
}

#import "ArrayList.h"
#import "NSArray+Address.h"
#import "Dog.h"

void testInts()
{
    // 创建
    ArrayList *list = List_Create(5);
    
    // 添加数据
    for (int i = 0; i < 20; i++) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wint-to-void-pointer-cast"
        List_Add(list, (ArrayListNodeValue)i);
#pragma clang diagnostic pop
        NSLog(@"数量: %d, 首元素的地址: %p", List_Length(list), *((void **)list + 1));
    }
    
    List_Print(list, NULL);

    // 销毁
    List_Destroy(list);
    list = NULL;
}

void printDog(ArrayListNodeValue value)
{
    NSLog(@"%@", (__bridge  Dog *)value);
}

void testDogs()
{
    Dog *dog1 = [Dog dogWithName:@"dog1"];
    Dog *dog2 = [Dog dogWithName:@"dog2"];
    Dog *dog3 = [Dog dogWithName:@"dog3"];

    // 创建
    ArrayList *list = List_Create(10);
    List_Add(list, (__bridge ArrayListNodeValue)dog1);
    List_Add(list, (__bridge ArrayListNodeValue)dog2);
    List_Add(list, (__bridge ArrayListNodeValue)dog2);
    List_Add(list, (__bridge ArrayListNodeValue)dog2);
    List_Add(list, (__bridge ArrayListNodeValue)dog3);
//    List_Add(list, (ArrayListNodeValue)20);
    
    List_Print(list, printDog);
    
    List_Remove_Value(list, (__bridge ArrayListNodeValue)dog2);
    
    List_Print(list, printDog);
    
//    Dog *dog = (__bridge Dog *)List_Get(list, 2);
//    [dog run];
    
//    NSLog(@"last = %d", (int)List_Get(list, List_Length(list) - 1));
    
    // 销毁
    List_Destroy(list);
    list = NULL;
}

void testArray()
{
    NSLog(@"字符串11的地址是:%p", @"11");
    
    NSMutableArray *array = [NSMutableArray array];
    NSLog(@"数组元素的首地址: %p", array.elementsAddress);
    for (int i = 0; i < 30; i++) {
        [array addObject:@"11"];
        NSLog(@"数组元素个数: %zd, 数组元素的首地址: %p", array.count, array.elementsAddress);
    }
    NSLog(@"%zd", array.count); // 0x100004148 : 指向数组里面首元素的指针
}
