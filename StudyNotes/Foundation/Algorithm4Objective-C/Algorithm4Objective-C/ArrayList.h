//
//  ArrayList.h
//  Algorithm4Objective-C
//
//  Created by 朱双泉 on 2019/1/23.
//  Copyright © 2019 Castie!. All rights reserved.
//

#ifndef ArrayList_h
#define ArrayList_h

#include <stdio.h>

typedef struct {
    int capacity; //容量
    int length; //长度(当前节点的数量)
    int values[10];
} ArrayList;

#endif /* ArrayList_h */
