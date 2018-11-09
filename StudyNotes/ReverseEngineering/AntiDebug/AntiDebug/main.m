//
//  main.m
//  AntiDebug
//
//  Created by 朱双泉 on 2018/8/16.
//  Copyright © 2018 Castie!. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import </usr/include/sys/ptrace.h>
#import <dlfcn.h>
#import <sys/sysctl.h>
#import <mach-o/dyld.h>

typedef void (^dbCheckBlock)();

typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);

void ptrace_method0() {
    ptrace(PT_DENY_ATTACH, 0, 0, 0); //直接调用ptrace
}

void ptrace_method1() {
    void * handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW); //通过符号表提取ptrace调用
    ptrace_ptr_t ptrace_ptr = (ptrace_ptr_t)dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
}

void ptrace_method2() {
    syscall(26, 31, 0, 0, 0); //系统调用ptrace
}

//实测失败 原因不明
int myGetPid() {
    int err = 0;
    struct kinfo_proc * proc_list = NULL;
    size_t length = 0;
    static const int sysName[] = {CTL_KERN, KERN_PROC, KERN_PROC_ALL, 0};
    err = sysctl((int *)sysName, 4, proc_list, &length, NULL, 0);
    if (!err) {
        proc_list = malloc(length);
        err = sysctl((int *)sysName, 4, proc_list, &length, NULL, 0);
    }
    
    if (!err && proc_list) {
        int proc_cout = length / sizeof(struct kinfo_proc);
        char buf[17];
        NSString * appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
        NSString * procName;
        for (int i = 0; i < proc_cout; i++) {
            pid_t procPid = proc_list[i].kp_proc.p_pid;
            strlcpy(buf, proc_list[i].kp_proc.p_comm, 17);
            procName = [NSString stringWithFormat:@"%s", buf];
            if ([appName isEqualToString:procName]) {
                return procPid;
            }
        }
    }
    return -1;
}

BOOL isDebuggerPresent() {
    int name[4];
    struct kinfo_proc info;
    size_t info_size = sizeof(info);
    
    name[0] = CTL_KERN;
    name[1] = KERN_PROC;
    name[2] = KERN_PROC_PID;
    name[3] = getpid();
    
    if (sysctl(name, 4, &info, &info_size, NULL, 0) == -1) {
        NSLog(@"sysctl error ...");
        return NO;
    }
    
    return ((info.kp_proc.p_flag & P_TRACED) != 0);
}

void debugCheck(dispatch_source_t _timer, dbCheckBlock block) {
    int name[4];
    struct kinfo_proc info;
    size_t info_size = sizeof(info);
    info.kp_proc.p_flag = 0;
    name[0] = CTL_KERN;
    name[1] = KERN_PROC;
    name[2] = KERN_PROC_PID;
    name[3] = getpid();
    
    if (sysctl(name, 4, &info, &info_size, NULL, 0) == -1) {
        NSLog(@"sysctl error ...");
        return;
    }
    
    if (info.kp_proc.p_flag & P_TRACED) {
        dispatch_source_cancel(_timer);
        if (block) {
            block();
        }
    }
}

void dbgCheck(dbCheckBlock block) {
    dispatch_queue_t _queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0.0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(_timer, ^{
        debugCheck(_timer, block);
    });
    dispatch_resume(_timer);
}

BOOL isInjected0() {
    int count = _dyld_image_count();
    if (count > 0) {
        for (int i = 0; i < count; i++) {
            const char * dyld = _dyld_get_image_name(i);
            if (strstr(dyld, "DynamicLibraries")) {
                return YES;
            }
        }
    }
    return NO;
}

BOOL isInjected1() {
    char * env = getenv("DYLD_INSERT_LIBRARIES");
    if (env) {
        return YES;
    }
    return NO;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        /* 禁止调试器附加
        ptrace_method0();
        ptrace_method1();
        ptrace_method2(); */
            
        if (isDebuggerPresent()) {
            NSLog(@"检测到调试器!!!");
            ptrace_method0();
            ptrace_method1();
            ptrace_method2();
        }
        
        dbgCheck(^{
            NSLog(@"检测到调试器!!!");
            ptrace_method0();
            ptrace_method1();
            ptrace_method2();
        });
        
        if (isInjected0()) {
            NSLog(@"被注入动态库!!!");
        }
        
        if (isInjected1()) {
            NSLog(@"被注入动态库!!!");
        }
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
