//
//  SQListLoader.h
//  App
//
//  Created by 朱双泉 on 2021/1/9.
//

#import <Foundation/Foundation.h>

@class SQListItem;

NS_ASSUME_NONNULL_BEGIN

typedef void(^SQListLoaderFinishBlock)(BOOL success, NSArray<SQListItem *> *dataArray);

/// 列表请求
@interface SQListLoader : NSObject

- (void)loadListDataWithFinishBlock:(SQListLoaderFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END
