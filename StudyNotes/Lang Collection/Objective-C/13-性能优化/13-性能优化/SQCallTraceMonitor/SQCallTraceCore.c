//
//  SQCallTraceCore.c
//  13-性能优化
//
//  Created by 朱双泉 on 2020/9/30.
//

#include "SQCallTraceCore.h"
#include "fishhook.h"

#ifdef __aarch64__

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stddef.h>
#include <stdint.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <objc/message.h>
#include <objc/runtime.h>
#include <dispatch/dispatch.h>
#include <pthread.h>

static bool _call_record_enabled = true;
static uint64_t _min_time_cost = 1000; //us
static int _max_call_depth = 3;
static pthread_key_t _thread_key;
__unused static id (*orig_objc_msgSend)(id, SEL, ...);

static SQCallRecord *_SQCallRecords;
static int _SQRecordNum;
static int _SQRecordAlloc;

/**
 第一步，设计两个结构体：CallRecord 记录调用方法详细信息，包括 obj 和 SEL 等；
 ThreadCallStack 里面，需要用 index 记录当前调用方法树的深度。
 有了 SEL 再通过 NSStringFromSelector 就能够取得方法名，有了 obj 通过 object_getClass 能够得到 Class ，再用 NSStringFromClass 就能够获得类名。
 */

typedef struct
{
    id self; //通过 object_getClass 能够得到 Class 再通过 NSStringFromClass 能够得到类名
    Class cls;
    SEL cmd;       //通过 NSStringFromSelector 方法能够得到方法名
    uint64_t time; //us
    uintptr_t lr;  // link register
} thread_call_record;

typedef struct
{
    thread_call_record *stack;
    int allocated_length;
    int index;
    bool is_main_thread;
} thread_call_stack;


/**
 第二步，pthread_setspecific() 可以将私有数据设置在指定线程上，pthread_getspecific() 用来读取这个私有数据。
 利用这个特性，我们就可以将 ThreadCallStack 的数据和该线程绑定在一起，随时进行数据存取。
 */
static inline thread_call_stack *get_thread_call_stack()
{
    thread_call_stack *cs = (thread_call_stack *)pthread_getspecific(_thread_key);
    if (cs == NULL)
    {
        cs = (thread_call_stack *)malloc(sizeof(thread_call_stack));
        cs->stack = (thread_call_record *)calloc(128, sizeof(thread_call_record));
        cs->allocated_length = 64;
        cs->index = -1;
        cs->is_main_thread = pthread_main_np();
        pthread_setspecific(_thread_key, cs);
    }
    return cs;
}

static void release_thread_call_stack(void *ptr)
{
    thread_call_stack *cs = (thread_call_stack *)ptr;
    if (!cs)
        return;
    if (cs->stack)
        free(cs->stack);
    free(cs);
}

/**
 第三步，因为要记录深度，而一个方法的调用里会有更多的方法调用，所以我们可以在方法的调用里增加两个方法 pushCallRecord 和 popCallRecord，分别记录方法调用的开始时间和结束时间，这样才能够在开始时对深度加一、在结束时减一。
 */
static inline void push_call_record(id _self, Class _cls, SEL _cmd, uintptr_t lr)
{
    thread_call_stack *cs = get_thread_call_stack();
    if (cs)
    {
        int nextIndex = (++cs->index);
        if (nextIndex >= cs->allocated_length)
        {
            cs->allocated_length += 64;
            cs->stack = (thread_call_record *)realloc(cs->stack, cs->allocated_length * sizeof(thread_call_record));
        }
        thread_call_record *newRecord = &cs->stack[nextIndex];
        newRecord->self = _self;
        newRecord->cls = _cls;
        newRecord->cmd = _cmd;
        newRecord->lr = lr;
        if (cs->is_main_thread && _call_record_enabled)
        {
            struct timeval now;
            gettimeofday(&now, NULL);
            newRecord->time = (now.tv_sec % 100) * 1000000 + now.tv_usec;
        }
    }
}

static inline uintptr_t pop_call_record()
{
    thread_call_stack *cs = get_thread_call_stack();
    int curIndex = cs->index;
    int nextIndex = cs->index--;
    thread_call_record *pRecord = &cs->stack[nextIndex];
    
    if (cs->is_main_thread && _call_record_enabled)
    {
        struct timeval now;
        gettimeofday(&now, NULL);
        uint64_t time = (now.tv_sec % 100) * 1000000 + now.tv_usec;
        if (time < pRecord->time)
        {
            time += 100 * 1000000;
        }
        uint64_t cost = time - pRecord->time;
        if (cost > _min_time_cost && cs->index < _max_call_depth)
        {
            if (!_SQCallRecords)
            {
                _SQRecordAlloc = 1024;
                _SQCallRecords = malloc(sizeof(SQCallRecord) * _SQRecordAlloc);
            }
            _SQRecordNum++;
            if (_SQRecordNum >= _SQRecordAlloc)
            {
                _SQRecordAlloc += 1024;
                _SQCallRecords = realloc(_SQCallRecords, sizeof(SQCallRecord) * _SQRecordAlloc);
            }
            SQCallRecord *log = &_SQCallRecords[_SQRecordNum - 1];
            log->cls = pRecord->cls;
            log->depth = curIndex;
            log->sel = pRecord->cmd;
            log->time = cost;
        }
    }
    return pRecord->lr;
}

void before_objc_msgSend(id self, SEL _cmd, uintptr_t lr)
{
    push_call_record(self, object_getClass(self), _cmd, lr);
}

uintptr_t after_objc_msgSend()
{
    return pop_call_record();
}

/**
 编写一个可保留未知参数并跳转到 c 中任意函数指针的汇编代码，实现对 objc_msgSend 的 Hook。
 arm64 有 31 个 64 bit 的整数型寄存器，分别用 x0 到 x30 表示。主要的实现思路是：
 
 1 入栈参数，参数寄存器是 x0~ x7。对于 objc_msgSend 方法来说，x0 第一个参数是传入对象，x1 第二个参数是选择器 _cmd。syscall 的 number 会放到 x8 里。
 2 交换寄存器中保存的参数，将用于返回的寄存器 lr 中的数据移到 x1 里。
 3 使用 bl label 语法调用 pushCallRecord 函数。执行原始的 objc_msgSend，保存返回值。
 4 使用 bl label 语法调用 popCallRecord 函数。
 */

//replacement objc_msgSend (arm64)
// https://blog.nelhage.com/2010/10/amd64-and-va_arg/
// http://infocenter.arm.com/help/topic/com.arm.doc.ihi0055b/IHI0055B_aapcs64.pdf
// https://developer.apple.com/library/ios/documentation/Xcode/Conceptual/iPhoneOSABIReference/Articles/ARM64FunctionCallingConventions.html
#define call(b, value)                            \
__asm volatile("stp x8, x9, [sp, #-16]!\n");  \
__asm volatile("mov x12, %0\n" ::"r"(value)); \
__asm volatile("ldp x8, x9, [sp], #16\n");    \
__asm volatile(#b " x12\n");

#define save()                      \
__asm volatile(                 \
"stp x8, x9, [sp, #-16]!\n" \
"stp x6, x7, [sp, #-16]!\n" \
"stp x4, x5, [sp, #-16]!\n" \
"stp x2, x3, [sp, #-16]!\n" \
"stp x0, x1, [sp, #-16]!\n");

#define load()                    \
__asm volatile(               \
"ldp x0, x1, [sp], #16\n" \
"ldp x2, x3, [sp], #16\n" \
"ldp x4, x5, [sp], #16\n" \
"ldp x6, x7, [sp], #16\n" \
"ldp x8, x9, [sp], #16\n");

#define link(b, value)                           \
__asm volatile("stp x8, lr, [sp, #-16]!\n"); \
__asm volatile("sub sp, sp, #16\n");         \
call(b, value);                              \
__asm volatile("add sp, sp, #16\n");         \
__asm volatile("ldp x8, lr, [sp], #16\n");

#define ret() __asm volatile("ret\n");

__attribute__((__naked__)) static void hook_Objc_msgSend()
{
    // Save parameters.
    save()
    
    __asm volatile("mov x2, lr\n");
    __asm volatile("mov x3, x4\n");
    
    // Call our before_objc_msgSend.
    call(blr, &before_objc_msgSend)
    
    // Load parameters.
    load()
    
    // Call through to the original objc_msgSend.
    call(blr, orig_objc_msgSend)
    
    // Save original objc_msgSend return value.
    save()
    
    // Call our after_objc_msgSend.
    call(blr, &after_objc_msgSend)
    
    // restore lr
    __asm volatile("mov lr, x0\n");
    
    // Load original objc_msgSend return value.
    load()
    
    // return
    ret()
}

void SQCallTraceStart()
{
    _call_record_enabled = true;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        pthread_key_create(&_thread_key, &release_thread_call_stack);
        // 使用fishhook hook objc)msgSend
        rebind_symbols((struct rebinding[6]){
            {"objc_msgSend", (void *)hook_Objc_msgSend, (void **)&orig_objc_msgSend},
        },
                       1);
    });
}

void SQCallTraceStop()
{
    _call_record_enabled = false;
}

void SQCallConfigMinTime(uint64_t us)
{
    _min_time_cost = us;
}
void SQCallConfigMaxDepth(int depth)
{
    _max_call_depth = depth;
}

SQCallRecord *SQGetCallRecords(int *num)
{
    if (num)
    {
        *num = _SQRecordNum;
    }
    return _SQCallRecords;
}

void SQClearCallRecords()
{
    if (_SQCallRecords)
    {
        free(_SQCallRecords);
        _SQCallRecords = NULL;
    }
    _SQRecordNum = 0;
}

#else

void SQCallTraceStart() {}
void SQCallTraceStop() {}
void SQCallConfigMinTime(uint64_t us)
{
}
void SQCallConfigMaxDepth(int depth)
{
}
SQCallRecord *SQGetCallRecords(int *num)
{
    if (num)
    {
        *num = 0;
    }
    return NULL;
}
void SQClearCallRecords() {}

#endif
