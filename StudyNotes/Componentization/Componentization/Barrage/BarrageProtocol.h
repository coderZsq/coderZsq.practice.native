//
//  BarrageProtocol.h
//  Componentization
//
//  Created by 朱双泉 on 2019/1/7.
//  Copyright © 2019 Castie!. All rights reserved.
//

#ifndef BarrageProtocol_h
#define BarrageProtocol_h

@protocol BarrageProtocol <NSObject>

@required
@property (nonatomic, readonly) NSTimeInterval beginTime;
@property (nonatomic, readonly) NSTimeInterval liveTime;

@end

#endif /* BarrageProtocol_h */
