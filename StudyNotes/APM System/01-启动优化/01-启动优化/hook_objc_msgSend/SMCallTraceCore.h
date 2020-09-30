//
//  SMCallTraceCore.h
//  01-启动优化
//
//  Created by 朱双泉 on 2020/9/30.
//

#ifndef SMCallTraceCore_h
#define SMCallTraceCore_h

#include <stdio.h>
#include <objc/objc.h>

typedef struct
{
    __unsafe_unretained Class cls;
    SEL sel;
    uint64_t time; // us (1/1000 ms)
    int depth;
} SMCallRecord;

extern void SMCallTraceStart(void);
extern void SMCallTraceStop(void);

extern void SMCallConfigMinTime(uint64_t us); //default 1000
extern void SMCallConfigMaxDepth(int depth);  //default 3

extern SMCallRecord *SMGetCallRecords(int *num);
extern void SMClearCallRecords(void);

#endif /* SMCallTraceCore_h */
