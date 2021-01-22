//
//  SQListItem.h
//  App
//
//  Created by 朱双泉 on 2021/1/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 列表结构化数据
@interface SQListItem : NSObject <NSSecureCoding>

@property (nonatomic, copy, readwrite) NSString *category;
@property (nonatomic, copy, readwrite) NSString *picUrl;
@property (nonatomic, copy, readwrite) NSString *uniqueKey;
@property (nonatomic, copy, readwrite) NSString *title;
@property (nonatomic, copy, readwrite) NSString *date;
@property (nonatomic, copy, readwrite) NSString *authorName;
@property (nonatomic, copy, readwrite) NSString *articleUrl;

- (void)configWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
