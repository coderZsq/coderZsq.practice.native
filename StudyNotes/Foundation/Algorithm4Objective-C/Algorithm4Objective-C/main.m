//
//  main.m
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/23.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ArrayList.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ArrayList * list = List_Create(10);
        List_Insert(list, 0, 20);
        List_Add(list, 30);
        List_Add(list, 40);
        List_Add(list, 50);
        List_Add(list, 50);
        List_Print(list);
        List_Set(list, 1, 25);
        List_Print(list);
        ArrayListNodeValue value = List_Get(list, 0);
        printf("value = %d\n\n", value);
        int index = List_Index(list, 40);
        printf("index = %d\n\n", index);
        List_Remove(list, 1);
        List_Remove_Value(list, 50);
        List_Print(list);
        List_Clear(list);
        List_Print(list);
        List_Destory(list);
        list = NULL;
    }
    return 0;
}
