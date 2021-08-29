//
//  SQListItem.m
//  App
//
//  Created by 朱双泉 on 2021/1/10.
//

#import "SQListItem.h"

@implementation SQListItem

- (void)configWithDictionary:(NSDictionary *)dictionary {
#warning 类型是否匹配
    self.category = [dictionary objectForKey:@"category"];
    self.picUrl = [dictionary objectForKey:@"thumbnail_pic_s"];
    self.uniqueKey = [dictionary objectForKey:@"uniqueKey"];
    self.title = [dictionary objectForKey:@"title"];
    self.date = [dictionary objectForKey:@"date"];
    self.authorName = [dictionary objectForKey:@"author_name"];
    self.articleUrl = [dictionary objectForKey:@"url"];
}

@end
