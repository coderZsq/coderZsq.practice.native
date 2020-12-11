//
//  SQMutableArray.m
//  15-数据结构与算法
//
//  Created by 朱双泉 on 2020/12/2.
//

#import "SQMutableArray.h"

static const NSUInteger DEFAULT_CAPACITY = 10;
static const NSInteger ELEMENT_NOT_FOUND = -1;

typedef void * Element;

@interface SQMutableArray () {
    /// 数组容量
    NSUInteger capacity;
    /// 元素的数量
    NSUInteger size;
    /// 所有的数量
    Element *elements;
}

@end

@implementation SQMutableArray

- (void)dealloc {
    free(elements);
    elements = nil;
}

- (instancetype)initWithCapacity:(NSUInteger)capacity {
    self = [super init];
    if (!self) {
        return nil;
    }
    self->capacity = (capacity < DEFAULT_CAPACITY) ? DEFAULT_CAPACITY : capacity;
    elements = self->capacity ? malloc(capacity * sizeof(Element)) : NULL;
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
- (BOOL)containsObject:(NSObject *)element {
    return [self indexOfObject:element] != ELEMENT_NOT_FOUND;
}

/// 添加元素到最后面
/// @param anObject 元素
- (void)addObject:(NSObject *)anObject {
    [self addObject:anObject atIndex:size];
}

/// 获取index位置的元素
/// @param index 索引
- (NSObject *)objectAtIndex:(NSUInteger)index {
    [self rangeCheck:index];
    return (__bridge NSObject * _Nonnull)(elements[index]);
}

/// 设置index位置的元素
/// @param element 元素
/// @param index 索引
- (NSObject *)setObject:(NSObject *)element atIndexedSubscript:(NSUInteger)index {
    [self rangeCheck:index];
    
    NSObject *old = (__bridge NSObject *)(elements[index]);
    elements[index] = (__bridge Element)(element);
    return old;
}

/// 在index位置插入一个元素
/// @param anObject 元素
/// @param index 索引
- (void)addObject:(NSObject *)anObject atIndex:(NSUInteger)index {
    [self rangeCheckForAdd:index];
    
    [self ensureCapacity:size + 1];
    
    for (NSUInteger i = size; i > index; i--) {
        elements[i] = elements[i - 1];
    }
    elements[index] = (__bridge Element)(anObject);
    size++;
}

/// 删除index位置的元素
/// @param index 索引
- (NSObject *)removeObjectAtIndex:(NSUInteger)index {
    [self rangeCheck:index];
    
    NSObject *old = (__bridge NSObject *)(elements[index]);
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
- (NSUInteger)indexOfObject:(NSObject *)element {
    if (element == nil) {
        for (int i = 0; i < size; i++) {
            if (elements[i] == nil) return i;
        }
    } else {
        for (int i = 0; i < size; i++) {
            if (element == elements[i]) return i;
        }
    }
    return ELEMENT_NOT_FOUND;
}

- (void)ensureCapacity:(NSUInteger)capacity {
    NSUInteger oldCapacity = self->capacity;
    if (oldCapacity >= capacity) return;
    
    // 新容量为旧容量的1.5倍
    NSUInteger newCapacity = oldCapacity + (oldCapacity >> 1);
    Element *newElements = malloc(newCapacity * sizeof(Element));
    if (newElements == nil) return;
    for (NSUInteger i = 0; i < size; i++) {
        newElements[i] = elements[i];
    }
    free(elements);
    elements = newElements;
    self->capacity = newCapacity;
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

- (NSString *)description {
    NSMutableString *string = [NSMutableString string];
    [string appendString:@"size="];
    [string appendString:[NSString stringWithFormat:@"%zd", size]];
    [string appendString:@", ["];
    for (NSUInteger i = 0; i < size; i++) {
        if (i != 0) {
            [string appendString:@", "];
        }
        [string appendFormat:@"%@", elements[i]];
    }
    [string appendString:@"]"];
    return string;
}

@end
