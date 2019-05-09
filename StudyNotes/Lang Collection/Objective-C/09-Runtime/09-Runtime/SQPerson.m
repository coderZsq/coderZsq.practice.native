//
//  SQPerson.m
//  09-Runtime
//
//  Created by 朱双泉 on 2019/5/9.
//  Copyright © 2019 Castie!. All rights reserved.
//

#import "SQPerson.h"

// & 可以用来取出特定的位
//   0000 0011
// & 0000 0010
// -------------
//   0000 0010

// 掩码, 一般用来按位与(&)运算的
//#define SQTallMask 1
//#define SQRichMask 2
//#define SQHandsomeMask 4

//#define SQTallMask 0b00000001
//#define SQRichMask 0b00000010
//#define SQHandsomeMask 0b00000100

#define SQTallMask (1<<0)
#define SQRichMask (1<<1)
#define SQHandsomeMask (1<<2)

@interface SQPerson ()
{
    char _tallRichHandsome; // 0b 0000 0000
}
@end

@implementation SQPerson

- (instancetype)init {
    if (self = [super init]) {
        _tallRichHandsome = 0b00000011;
    }
    return self;
}

- (void)setTall:(BOOL)tall {
    
}

- (BOOL)isTall {
    return !!(_tallRichHandsome & SQTallMask);
}

- (void)setRich:(BOOL)rich {
    
}

- (BOOL)isRich {
    return !!(_tallRichHandsome & SQRichMask);
}

- (void)setHandsome:(BOOL)handsome {
    
}

- (BOOL)isHandsome {
    return !!(_tallRichHandsome & SQHandsomeMask);;
}

@end
