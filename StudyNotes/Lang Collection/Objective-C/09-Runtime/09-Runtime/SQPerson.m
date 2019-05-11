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

//   0010 0010
// & 1111 1101
// -------------
//   0010 0000

// | 可以用来设置特定的位
//   0010 1000
// | 0000 0010
// -------------
//   0010 1010

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
#define SQThinMask (1<<3)

@interface SQPerson () {
    union {
        char bits;
        struct {
            char tall: 1; // 最低位
            char rich: 1;
            char handsome: 1;
            char thin: 1;
        }; // 0b 0000 0111
    } _tallRichHandsome;
    
//    char _tallRichHandsome; // 0b 0000 0000
    
//    位域
//    struct {
//        char tall: 2; // 最低位
//        char rich: 2;
//        char handsome: 2;
//    } _tallRichHandsome; // 0b 0001 0101
}
@end

@implementation SQPerson

- (void)setTall:(BOOL)tall {
    if (tall) {
        _tallRichHandsome.bits |= SQTallMask;
    } else {
        _tallRichHandsome.bits &= ~SQTallMask;
    }
}

- (BOOL)isTall {
    return !!(_tallRichHandsome.bits & SQTallMask);
}

- (void)setRich:(BOOL)rich {
    if (rich) {
        _tallRichHandsome.bits |= SQRichMask;
    } else {
        _tallRichHandsome.bits &= ~SQRichMask;
    }
}

- (BOOL)isRich {
    return !!(_tallRichHandsome.bits & SQRichMask);
}

- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
        _tallRichHandsome.bits |= SQHandsomeMask;
    } else {
        _tallRichHandsome.bits &= ~SQHandsomeMask;
    }
}

- (BOOL)isHandsome {
    return !!(_tallRichHandsome.bits & SQHandsomeMask);
}

- (void)setThin:(BOOL)thin {
    if (thin) {
        _tallRichHandsome.bits |= SQThinMask;
    } else {
        _tallRichHandsome.bits &= ~SQThinMask;
    }
}

- (BOOL)isThin {
    return !!(_tallRichHandsome.bits & SQThinMask);
}

/*
- (void)setTall:(BOOL)tall {
    _tallRichHandsome.tall = tall;
}

- (BOOL)isTall {
    //    BOOL 0b1111 1111
    //    _tallRichHandsome.tall == 0b1
    //    BOOL ret = _tallRichHandsome.tall;
 
    // (lldb) p/x &ret
    // (BOOL *) $0 = 0x00007ffeefbff49f 255
    // (lldb) x 0x00007ffeefbff49f
    // 0x7ffeefbff49f: ff df af a3 70 ff 7f 00 00 50 65 b0 02 01 00 00  ....p....Pe.....
    // 0x7ffeefbff4af: 00 00 f5 bf ef fe 7f 00 00 e6 0d 00 00 01 00 00  ................
 
    // char c1 = -1;
    // unsigned char c2 = 255;
 
    // (lldb) p/x &c1
    // (char *) $0 = 0x00007ffeefbff4ef "\xffffffff \xfffffff5\xffffffbf\xffffffef\xfffffffe\x7f"
    // (lldb) p/x &c2
    // (char *) $1 = 0x00007ffeefbff4ee "\xffffffff\xffffffff \xfffffff5\xffffffbf\xffffffef\xfffffffe\x7f"
    // (lldb) x 0x00007ffeefbff4ef
    // 0x7ffeefbff4ef: ff 20 f5 bf ef fe 7f 00 00 01 00 00 00 00 00 00  . ..............
    // 0x7ffeefbff4ff: 00 10 f5 bf ef fe 7f 00 00 d5 13 57 7c ff 7f 00  ...........W|...
    // (lldb) x 0x00007ffeefbff4ee
    // 0x7ffeefbff4ee: ff ff 20 f5 bf ef fe 7f 00 00 01 00 00 00 00 00  .. .............
    // 0x7ffeefbff4fe: 00 00 10 f5 bf ef fe 7f 00 00 d5 13 57 7c ff 7f  ............W|..
 
    return !!_tallRichHandsome.tall;
}

- (void)setRich:(BOOL)rich {
    _tallRichHandsome.rich = rich;
}

- (BOOL)isRich {
    //    return _tallRichHandsome.rich;
    return !!_tallRichHandsome.rich;
}

- (void)setHandsome:(BOOL)handsome {
    _tallRichHandsome.handsome = handsome;
}

- (BOOL)isHandsome {
    return !!_tallRichHandsome.handsome;
}
*/

/*
- (instancetype)init {
    if (self = [super init]) {
        _tallRichHandsome = 0b00000011;
    }
    return self;
}

- (void)setTall:(BOOL)tall {
    if (tall) {
        _tallRichHandsome |= SQTallMask;
    } else {
        _tallRichHandsome &= ~SQTallMask;
    }
}

- (BOOL)isTall {
    return !!(_tallRichHandsome & SQTallMask);
}

- (void)setRich:(BOOL)rich {
    if (rich) {
        _tallRichHandsome |= SQRichMask;
    } else {
        _tallRichHandsome &= ~SQRichMask;
    }
}

- (BOOL)isRich {
    return !!(_tallRichHandsome & SQRichMask);
}

- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
        _tallRichHandsome |= SQHandsomeMask;
    } else {
        _tallRichHandsome &= ~SQHandsomeMask;
    }
}

- (BOOL)isHandsome {
    return !!(_tallRichHandsome & SQHandsomeMask);
}
*/

@end
