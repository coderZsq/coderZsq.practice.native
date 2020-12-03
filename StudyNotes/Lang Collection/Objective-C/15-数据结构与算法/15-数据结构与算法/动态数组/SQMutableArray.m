//
//  SQMutableArray.m
//  15-数据结构与算法
//
//  Created by 朱双泉 on 2020/12/2.
//

#import "SQMutableArray.h"

static const NSUInteger DEFAULT_CAPACITY = 10;
static const NSInteger ELEMENT_NOT_FOUND = -1;

@interface SQMutableArray<ObjectType> () {
    /// 元素的数量
    NSUInteger size;
    /// 所有的数量
    id elements;
}

@end

@implementation SQMutableArray

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    if (!self) {
        return nil;
    }
    capacity = (capacity < DEFAULT_CAPACITY) ? DEFAULT_CAPACITY : capacity;
    elements = (__bridge id)malloc(DEFAULT_CAPACITY * sizeof(id));
    return self;
}

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    return [self initWithCapacity:DEFAULT_CAPACITY];
}

/// 清除所有元素
- (void)removeAllObjects {
    for (NSUInteger i = 0; i < size; i++) {
        elements[i] = nil;
    }
    size = 0;
}

/// 元素的数量
- (NSUInteger)count {
    return size;
}

/// 是否为空
- (BOOL)isEmpty {
    return size == 0;
}


/// 是否包含某个元素
/// @param element 元素
- (BOOL)containsObject:(id)element {
    return [self indexOfObject:element] != ELEMENT_NOT_FOUND;
}

/// 获取index位置的元素
/// @param index 索引
- (id)objectAtIndex:(NSUInteger)index {
    [self rangeCheck:index];
    return elements[index];
}

/// 设置index位置的元素
/// @param element 元素
/// @param index 索引
- (id)setObject:(id)element atIndexedSubscript:(NSUInteger)index {
    [self rangeCheck:index];
    
    id old = elements[index];
    element[index] = element;
    return old;
}


/// 在index位置插入一个元素
/// @param anObject 元素
/// @param index 索引
- (void)addObject:(id)anObject atIndex:(NSUInteger)index {
    [self rangeCheckForAdd:index];
    
}


/// 删除index位置的元素
/// @param index 索引
- (id)removeObjectAtIndex:(NSUInteger)index {
    [self rangeCheck:index];
    
    id old = elements[index];
    // 从索引位置的后一位开始遍历
    for (NSUInteger i = index + 1; i < size; i++) {
        // 遍历索引位置的后一位覆盖索引位置的元素
        elements[i - 1] = elements[i];
    }
    elements[--size] = nil;
    return old;
}


/// 查看元素的索引
/// @param element 元素
- (NSUInteger)indexOfObject:(id)element {
    if (element == nil) {
        for (int i = 0; i < size; i++) {
            if (elements[i] == nil) return i;
        }
    } else {
        for (int i = 0; i < size; i++) {
            if ([element isEqualTo:elements[i]]) return i;
        }
    }
    return ELEMENT_NOT_FOUND;
}

- (void)ensureCapacity:(NSUInteger)capacity {
    NSUInteger oldCapacity = sizeof(elements) / sizeof(elements[0]);
    if (oldCapacity >= capacity) return;
    
    // 新容量为旧容量的1.5倍
    NSUInteger newCapacity = oldCapacity + (oldCapacity >> 1);
    id newElements[newCapacity];
    for (NSUInteger i = 0; i < size; i++) {
        newElements[i] = elements[i];
    }
//    elements = newElements;
}

- (void)outOfBounds:(NSUInteger)index {
    @throw [[NSException alloc] initWithName:@"IndexOutOfBoundsExpetion" reason:[NSString stringWithFormat:@"Index: %zd, Size: %zd", index, size] userInfo:nil];
}

- (void)rangeCheck:(NSUInteger)index {
    if (index < 0 || index >= size) {
        [self outOfBounds:index];
    }
}

- (void)rangeCheckForAdd:(NSUInteger)index {
    if (index < 0 || index > size) {
        [self outOfBounds:index];
    }
}

@end
