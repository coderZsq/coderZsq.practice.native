//
//  SQCallTraceCore.h
//  13-性能优化
//
//  Created by 朱双泉 on 2020/9/30.
//

#ifndef SQCallTraceCore_h
#define SQCallTraceCore_h

#include <stdio.h>
#include <objc/objc.h>

typedef struct
{
    __unsafe_unretained Class cls;
    SEL sel;
    uint64_t time; // us (1/1000 ms)
    int depth;
} SQCallRecord;

extern void SQCallTraceStart(void);
extern void SQCallTraceStop(void);

extern void SQCallConfigMinTime(uint64_t us); //default 1000
extern void SQCallConfigMaxDepth(int depth);  //default 3

extern SQCallRecord *SQGetCallRecords(int *num);
extern void SQClearCallRecords(void);

#endif /* SQCallTraceCore_h */
