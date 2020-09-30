//
//  SMCallTraceModel.h
//  01-启动优化
//
//  Created by 朱双泉 on 2020/9/30.
//

#import <Foundation/Foundation.h>

@interface SMCallTraceModel : NSObject

@property(nonatomic, strong) NSString *className;     //类名
@property(nonatomic, strong) NSString *methodName;    //方法名
@property(nonatomic, assign) BOOL isClasSMethod;      //是否是类方法
@property(nonatomic, assign) NSTimeInterval timeCost; //时间消耗
@property(nonatomic, assign) NSUInteger callDepth;    //Call 层级
@property(nonatomic, copy) NSString *path;            //路径
@property(nonatomic, assign) BOOL lastCall;           //是否是最后一个 Call
@property(nonatomic, assign) NSUInteger frequency;    //访问频次
@property(nonatomic, strong) NSArray<SMCallTraceModel *> *subCosts;

- (NSString *)des;

@end
