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

typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        //禁止调试器附加
        ptrace(PT_DENY_ATTACH, 0, 0, 0); //直接调用ptrace
        
        void * handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW); //通过符号表提取ptrace调用
        ptrace_ptr_t ptrace_ptr = (ptrace_ptr_t)dlsym(handle, "ptrace");
        ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
        
        syscall(26, 31, 0, 0, 0); //系统调用ptrace
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
