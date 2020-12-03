//
//  SQMutableArray.h
//  15-数据结构与算法
//
//  Created by 朱双泉 on 2020/12/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQMutableArray<ObjectType : NSObject*> : NSObject

/// 元素的数量
@property (nonatomic, assign, readonly) NSUInteger count;

/// 是否为空
@property (nonatomic, assign, readonly, getter=isEmpty) BOOL empty;

/// 是否包含某个元素
/// @param anObject 元素
- (BOOL)containsObject:(ObjectType)anObject;

/// 添加元素到最后面
/// @param anObject 元素
- (void)addObject:(ObjectType)anObject;

/// 返回index位置对应的元素
/// @param index 索引
- (ObjectType)objectAtIndex:(NSUInteger)index;

/// 设置index位置的元素
/// @param obj 元素
/// @param idx 索引
- (ObjectType)setObject:(ObjectType)obj atIndexedSubscript:(NSUInteger)idx;

/// 在index位置插入一个元素
/// @param anObject 元素
/// @param index 索引
- (void)addObject:(id)anObject atIndex:(NSUInteger)index;

/// 删除index位置对应的元素
/// @param index 索引
- (ObjectType)removeObjectAtIndex:(NSUInteger)index;

/// 查看元素的位置
/// @param anObject 元素
- (NSUInteger)indexOfObject:(ObjectType)anObject;

/// 清除所有元素
- (void)removeAllObjects;

@end

NS_ASSUME_NONNULL_END
