//
//  SQBacktraceLogger.m
//  SQAppFluecyMonitor
//
//  Created by 朱双泉 on 2020/9/25.
//

#import "SQBacktraceLogger.h"
#import <mach/mach.h>
#include <dlfcn.h>
#include <pthread.h>
#include <sys/types.h>
#include <limits.h>
#include <string.h>
#include <mach-o/dyld.h>
#include <mach-o/nlist.h>





/*!
 *  @brief  适配不同CPU的宏定义
 *
 *  @thx    代码出自https://github.com/bestswifter/BSBacktraceLogger 加工修改
 */
#if defined(__arm64__)
#define DETAG_INSTRUCTION_ADDRESS(A) ((A) & ~(3UL))
#define SQ_THREAD_STATE_COUNT ARM_THREAD_STATE64_COUNT
#define SQ_THREAD_STATE ARM_THREAD_STATE64
#define SQ_FRAME_POINTER __fp
#define SQ_STACK_POINTER __sp
#define SQ_INSTRUCTION_ADDRESS __pc

#elif defined(__arm__)
#define DETAG_INSTRUCTION_ADDRESS(A) ((A) & ~(1UL))
#define SQ_THREAD_STATE_COUNT ARM_THREAD_STATE_COUNT
#define SQ_THREAD_STATE ARM_THREAD_STATE
#define SQ_FRAME_POINTER __r[7]
#define SQ_STACK_POINTER __sp
#define SQ_INSTRUCTION_ADDRESS __pc

#elif defined(__x86_64__)
#define DETAG_INSTRUCTION_ADDRESS(A) (A)
#define SQ_THREAD_STATE_COUNT x86_THREAD_STATE64_COUNT
#define SQ_THREAD_STATE x86_THREAD_STATE64
#define SQ_FRAME_POINTER __rbp
#define SQ_STACK_POINTER __rsp
#define SQ_INSTRUCTION_ADDRESS __rip

#elif defined(__i386__)
#define DETAG_INSTRUCTION_ADDRESS(A) (A)
#define SQ_THREAD_STATE_COUNT x86_THREAD_STATE32_COUNT
#define SQ_THREAD_STATE x86_THREAD_STATE32
#define SQ_FRAME_POINTER __ebp
#define SQ_STACK_POINTER __esp
#define SQ_INSTRUCTION_ADDRESS __eip

#endif

#if defined(__LP64__)
#define TRACE_FMT         "%-4d%-31s 0x%016lx %s + %lu"
#define POINTER_FMT       "0x%016lx"
#define POINTER_SHORT_FMT "0x%lx"
#define SQ_NLIST struct nlist_64
#else
#define TRACE_FMT         "%-4d%-31s 0x%08lx %s + %lu"
#define POINTER_FMT       "0x%08lx"
#define POINTER_SHORT_FMT "0x%lx"
#define SQ_NLIST struct nlist

#endif

#define MAX_FRAME_NUMBER 30
#define LOG_SEPERATE printf("\n");
#define FAILED_UINT_PTR_ADDRESS 0
#define CALL_INSTRUCTION_FROM_RETURN_ADDRESS(A) (DETAG_INSTRUCTION_ADDRESS((A)) - 1)


typedef struct SQStackFrameEntry{
    const struct SQStackFrameEntry * const previous;
    const uintptr_t return_address;
} SQStackFrameEntry;

static mach_port_t main_thread_id;



@implementation SQBacktraceLogger

+ (void)load {
    main_thread_id = mach_thread_self();
}


#pragma mark - Public
+ (NSString *)sq_backtraceOfAllThread {
    thread_act_array_t threads;
    mach_msg_type_number_t thread_count = 0;
    const task_t this_task = mach_task_self();
    
    kern_return_t kr = task_threads(this_task, &threads, &thread_count);
    if (kr != KERN_SUCCESS) {
        return @"Failed to get information of all threads";
    }
    NSMutableString * result = @"".mutableCopy;
    for (int idx = 0; idx < thread_count; idx++) {
        [result appendString: _sq_backtraceOfThread(threads[idx])];
    }
    return result.copy;
}

+ (NSString *)sq_backtraceOfMainThread {
    return [self sq_backtraceOfNSThread: [NSThread mainThread]];
}

+ (NSString *)sq_backtraceOfCurrentThread {
    return [self sq_backtraceOfNSThread: [NSThread currentThread]];
}

+ (NSString *)sq_backtraceOfNSThread:(NSThread *)thread {
    return _sq_backtraceOfThread(sq_machThreadFromNSThread(thread));
}

+ (void)sq_logMain {
    LOG_SEPERATE
    NSLog(@"%@", [self sq_backtraceOfMainThread]);
    LOG_SEPERATE
}

+ (void)sq_logCurrent {
    LOG_SEPERATE
    NSLog(@"%@", [self sq_backtraceOfCurrentThread]);
    LOG_SEPERATE
}

+ (void)sq_logAllThread {
    LOG_SEPERATE
    NSLog(@"%@", [self sq_backtraceOfAllThread]);
    LOG_SEPERATE
}


#pragma mark - Generate
thread_t sq_machThreadFromNSThread(NSThread * nsthread) {
    char name[256];
    thread_act_array_t list;
    mach_msg_type_number_t count;
    task_threads(mach_task_self(), &list, &count);
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSString * originName = nsthread.name;
    [nsthread setName: [NSString stringWithFormat: @"%f", timeStamp]];
    
    if ([nsthread isMainThread]) { return (thread_t)main_thread_id; }
    
    for (int idx = 0; idx < count; idx++) {
        pthread_t pt = pthread_from_mach_thread_np(list[idx]);
        if ([nsthread isMainThread] && list[idx] == main_thread_id) { return list[idx]; }
        if (pt) {
            name[0] = '\0';
            pthread_getname_np(pt, name, sizeof(name));
            if (!strcmp(name, [nsthread name].UTF8String)) {
                [nsthread setName: originName];
                return list[idx];
            }
        }
    }
    [nsthread setName: originName];
    return mach_thread_self();
}

NSString * _sq_backtraceOfThread(thread_t thread) {
    uintptr_t backtraceBuffer[MAX_FRAME_NUMBER];
    int idx = 0;
    NSMutableString * result = [NSString stringWithFormat: @"Backtrace of Thread %u:\n======================================================================================\n", thread].mutableCopy;
    
    _STRUCT_MCONTEXT machineContext;
    if (!sq_fillThreadStateIntoMachineContext(thread, &machineContext)) {
        return [NSString stringWithFormat: @"Failed to get information abount thread: %u", thread];
    }
    const uintptr_t instructionAddress = sq_mach_instructionAddress(&machineContext);
    backtraceBuffer[idx++] = instructionAddress;
    
    uintptr_t linkRegister = sq_mach_linkRegister(&machineContext);
    if (linkRegister) {
        backtraceBuffer[idx++] = linkRegister;
    }
    if (instructionAddress == FAILED_UINT_PTR_ADDRESS) { return @"Failed to get instruction address"; }
    
    SQStackFrameEntry frame = { 0 };
    const uintptr_t framePtr = sq_mach_framePointer(&machineContext);
    if (framePtr == FAILED_UINT_PTR_ADDRESS ||
        sq_mach_copyMem((void *)framePtr, &frame, sizeof(frame)) != KERN_SUCCESS) {
        return @"failed to get frame pointer";
    }
    
    for (; idx < MAX_FRAME_NUMBER; idx++) {
        backtraceBuffer[idx] = frame.return_address;
        if (backtraceBuffer[idx] == FAILED_UINT_PTR_ADDRESS ||
            frame.previous == NULL ||
            sq_mach_copyMem(frame.previous, &frame, sizeof(frame)) != KERN_SUCCESS) {
            break;
        }
    }
    
    int backtraceLength = idx;
    Dl_info symbolicated[backtraceLength];
    sq_symbolicate(backtraceBuffer, symbolicated, backtraceLength, 0);
    for (int idx = 0; idx < backtraceLength; idx++) {
        [result appendFormat: @"%@", sq_logBacktraceEntry(idx, backtraceBuffer[idx], &symbolicated[idx])];
    }
    [result appendString: @"\n"];
    [result appendString: @"======================================================================================"];
    return result.copy;
}


#pragma mark - operate machine context
bool sq_fillThreadStateIntoMachineContext(thread_t thread, _STRUCT_MCONTEXT * machineContext) {
    mach_msg_type_number_t state_count = SQ_THREAD_STATE_COUNT;
    kern_return_t kr = thread_get_state(thread, SQ_THREAD_STATE, (thread_state_t)&machineContext->__ss, &state_count);
    return (kr == KERN_SUCCESS);
}

uintptr_t sq_mach_linkRegister(_STRUCT_MCONTEXT * const machineContext){
#if defined(__i386__) || defined(__x86_64__)
    return FAILED_UINT_PTR_ADDRESS;
#else
    return machineContext->__ss.__lr;
#endif
}

uintptr_t sq_mach_framePointer(_STRUCT_MCONTEXT * const machineContext) {
    return machineContext->__ss.SQ_FRAME_POINTER;
}

uintptr_t sq_mach_instructionAddress(_STRUCT_MCONTEXT * const machineContext) {
    return machineContext->__ss.SQ_INSTRUCTION_ADDRESS;
}

kern_return_t sq_mach_copyMem(const void * src, const void * dst, const size_t numBytes) {
    vm_size_t bytesCopied = 0;
    return vm_read_overwrite(mach_task_self(), (vm_address_t)src, (vm_size_t)numBytes, (vm_address_t)dst, &bytesCopied);
}


#pragma mark - handle symbolicate
void sq_symbolicate(const uintptr_t * const backtraceBuffer, Dl_info * const symbolsBuffer, const int numEntries, const int skippedEntries) {
    int idx = 0;
    if (!skippedEntries && idx < numEntries) {
        sq_dladdr(backtraceBuffer[idx], &symbolsBuffer[idx]);
        idx++;
    }
    
    for (; idx < numEntries; idx++) {
        sq_dladdr(CALL_INSTRUCTION_FROM_RETURN_ADDRESS(backtraceBuffer[idx]), &symbolsBuffer[idx]);
    }
}

bool sq_dladdr(const uintptr_t address, Dl_info * const info) {
    info->dli_fname = NULL;
    info->dli_fbase = NULL;
    info->dli_sname = NULL;
    info->dli_saddr = NULL;
    
    const uint32_t idx = sq_imageIndexContainingAddress(address);
    if (idx == UINT_MAX) { return false; }
    
    const struct mach_header * header = _dyld_get_image_header(idx);
    const uintptr_t imageVMAddressSlide = (uintptr_t)_dyld_get_image_vmaddr_slide(idx);
    const uintptr_t addressWithSlide = address - imageVMAddressSlide;
    const uintptr_t segmentBase = sq_segmentBaseOfImageIndex(idx) + imageVMAddressSlide;
    if (segmentBase == FAILED_UINT_PTR_ADDRESS) { return false; }
    
    info->dli_fbase = (void *)header;
    info->dli_fname = _dyld_get_image_name(idx);
    
    const SQ_NLIST * bestMatch = NULL;
    uintptr_t bestDistance = ULONG_MAX;
    uintptr_t cmdPtr = sq_firstCmdAfterHeader(header);
    if (cmdPtr == FAILED_UINT_PTR_ADDRESS) { return false; }
    
    for (uint32_t iCmd = 0; iCmd < header->ncmds; iCmd++) {
        const struct load_command * loadCmd = (struct load_command *)cmdPtr;
        if (loadCmd->cmd == LC_SYMTAB) {
            const struct symtab_command * symtabCmd = (struct symtab_command *)cmdPtr;
            const SQ_NLIST * symbolTable = (SQ_NLIST *)(segmentBase + symtabCmd->symoff);
            const uintptr_t stringTable = segmentBase + symtabCmd->stroff;
            
            for (uint32_t iSym = 0; iSym < symtabCmd->nsyms; iSym++) {
                if (symbolTable[iSym].n_value == FAILED_UINT_PTR_ADDRESS) { continue; }
                uintptr_t symbolBase = symbolTable[iSym].n_value;
                uintptr_t currentDistance = addressWithSlide - symbolBase;
                if ( (addressWithSlide >= symbolBase && currentDistance <= bestDistance) ) {
                    bestMatch = symbolTable + iSym;
                    bestDistance = currentDistance;
                }
            }
            if (bestMatch != NULL) {
                info->dli_saddr = (void *)(bestMatch->n_value + imageVMAddressSlide);
                info->dli_sname = (char *)((intptr_t)stringTable + (intptr_t)bestMatch->n_un.n_strx);
                if (*info->dli_sname == '_') {
                    info->dli_sname++;
                }
                if (info->dli_saddr == info->dli_fbase && bestMatch->n_type == 3) {
                    info->dli_sname = NULL;
                }
                break;
            }
        }
        cmdPtr += loadCmd->cmdsize;
    }
    return true;
}

uintptr_t sq_firstCmdAfterHeader(const struct mach_header * const header) {
    switch (header->magic) {
        case MH_MAGIC:
        case MH_CIGAM:
            return (uintptr_t)(header + 1);
        case MH_MAGIC_64:
        case MH_CIGAM_64:
            return (uintptr_t)(((struct mach_header_64*)header) + 1);
        default:
            return 0;
    }
}

uintptr_t sq_segmentBaseOfImageIndex(const uint32_t idx) {
    const struct mach_header * header = _dyld_get_image_header(idx);
    
    uintptr_t cmdPtr = sq_firstCmdAfterHeader(header);
    if (cmdPtr == FAILED_UINT_PTR_ADDRESS) { return FAILED_UINT_PTR_ADDRESS; }
    for (uint32_t idx = 0; idx < header->ncmds; idx++) {
        const struct load_command * loadCmd = (struct load_command *)cmdPtr;
        if (loadCmd->cmd == LC_SEGMENT) {
            const struct segment_command * segCmd = (struct segment_command *)cmdPtr;
            if (strcmp(segCmd->segname, SEG_LINKEDIT) == 0) {
                return segCmd->vmaddr - segCmd->fileoff;
            }
        } else if (loadCmd->cmd == LC_SEGMENT_64) {
            const struct segment_command_64 * segCmd = (struct segment_command_64 *)cmdPtr;
            if (strcmp(segCmd->segname, SEG_LINKEDIT) == 0) {
                return segCmd->vmaddr - segCmd->fileoff;
            }
        }
        cmdPtr += loadCmd->cmdsize;
    }
    return FAILED_UINT_PTR_ADDRESS;
}

uint32_t sq_imageIndexContainingAddress(const uintptr_t address) {
    const uint32_t imageCount = _dyld_image_count();
    const struct mach_header * header = FAILED_UINT_PTR_ADDRESS;
    
    for (uint32_t iImg = 0; iImg < imageCount; iImg++) {
        header = _dyld_get_image_header(iImg);
        if (header != NULL) {
            uintptr_t addressWSlide = address - (uintptr_t)_dyld_get_image_vmaddr_slide(iImg);
            uintptr_t cmdPtr = sq_firstCmdAfterHeader(header);
            if (cmdPtr == FAILED_UINT_PTR_ADDRESS) { continue; }
            
            for (uint32_t iCmd = 0; iCmd < header->ncmds; iCmd++) {
                const struct load_command * loadCmd = (struct load_command *)cmdPtr;
                if (loadCmd->cmd == LC_SEGMENT) {
                    const struct segment_command * segCmd = (struct segment_command *)cmdPtr;
                    if (addressWSlide >= segCmd->vmaddr &&
                        addressWSlide < segCmd->vmaddr + segCmd->vmsize) {
                        return iImg;
                    }
                } else if (loadCmd->cmd == LC_SEGMENT_64) {
                    const struct segment_command_64 * segCmd = (struct segment_command_64 *)cmdPtr;
                    if (addressWSlide >= segCmd->vmaddr &&
                        addressWSlide < segCmd->vmaddr + segCmd->vmsize) {
                        return iImg;
                    }
                }
                cmdPtr += loadCmd->cmdsize;
            }
        }
    }
    return UINT_MAX;
}


#pragma mark - generate backtrace entry
const char * sq_lastPathEntry(const char * const path) {
    if (path == NULL) { return NULL; }
    char * lastFile = strrchr(path, '/');
    return lastFile == NULL ? path: lastFile + 1;
}

NSString * sq_logBacktraceEntry(const int entryNum, const uintptr_t address, const Dl_info * const dlInfo) {
    char faddrBuffer[20];
    char saddrBuffer[20];
    
    const char * fname = sq_lastPathEntry(dlInfo->dli_fname);
    if (fname == NULL) {
        sprintf(faddrBuffer, POINTER_FMT, (uintptr_t)dlInfo->dli_fbase);
        fname = faddrBuffer;
    }
    
    uintptr_t offset = address - (uintptr_t)dlInfo->dli_saddr;
    const char * sname = dlInfo->dli_sname;
    if (sname == NULL) {
        sprintf(saddrBuffer, POINTER_SHORT_FMT, (uintptr_t)dlInfo->dli_fbase);
        sname = saddrBuffer;
        offset = address - (uintptr_t)dlInfo->dli_fbase;
    }
    return [NSString stringWithFormat: @"%-30s 0x%08" PRIxPTR " %s + %lu\n", fname, (uintptr_t)address, sname, offset];
}


@end
