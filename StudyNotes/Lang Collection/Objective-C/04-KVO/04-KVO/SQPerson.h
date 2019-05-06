//
//  SQPerson.h
//  04-KVO
//
//  Created by 朱双泉 on 2019/5/5.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQPerson : NSObject {
    @public
    int _age;
}
@property (assign, nonatomic) int age;
@property (assign, nonatomic) int height;
@end

NS_ASSUME_NONNULL_END
