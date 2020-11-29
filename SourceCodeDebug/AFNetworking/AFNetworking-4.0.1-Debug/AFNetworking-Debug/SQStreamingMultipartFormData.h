//
//  SQStreamingMultipartFormData.h
//  AFNetworking-Debug
//
//  Created by 朱双泉 on 2020/11/29.
//

#import <Foundation/Foundation.h>
#import "SQMultipartFormData.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQStreamingMultipartFormData : NSObject <SQMultipartFormData>
- (instancetype)initWithURLRequest:(NSMutableURLRequest *)urlRequest stringEncoding:(NSStringEncoding)encoding;

- (NSMutableURLRequest *)requestByFinalizingMultipartFormData;
@end

NS_ASSUME_NONNULL_END
