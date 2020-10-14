//
//  main.m
//  13-性能优化
//
//  Created by 朱双泉 on 2020/9/25.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SQCallTrace.h"

/**
 App 的启动主要包括三个阶段：
 
 1. main() 函数执行前；
 2. main() 函数执行后；
 3. 首屏渲染完成后。
 */

/**
 启动阶段1
 
 在 main() 函数执行前，系统主要会做下面几件事情：
 
 1 加载可执行文件（App 的.o 文件的集合）；
 2 加载动态链接库，进行 rebase 指针调整和 bind 符号绑定；
 3 Objc 运行时的初始处理，包括 Objc 相关类的注册、category 注册、selector 唯一性检查等；
 4 初始化，包括了执行 +load() 方法、attribute((constructor)) 修饰的函数的调用、创建 C++ 静态全局变量。
 
 相应地，这个阶段对于启动速度优化来说，可以做的事情包括：
 1 减少动态库加载。每个库本身都有依赖关系，苹果公司建议使用更少的动态库，
   并且建议在使用动态库的数量较多时，尽量将多个动态库进行合并。
   数量上，苹果公司建议最多使用 6 个非系统动态库。
 2 减少加载启动后不会去使用的类或者方法。
 3 +load() 方法里的内容可以放到首屏渲染完成后再执行，或使用 +initialize() 方法替换掉。
    因为，在一个 +load() 方法里，进行运行时方法替换操作会带来 4 毫秒的消耗。
    不要小看这 4 毫秒，积少成多，执行 +load() 方法对启动速度的影响会越来越大。
 4 控制 C++ 全局变量的数量。
 */

static int s_fatal_signals[] = {
    SIGABRT,
    SIGBUS,
    SIGFPE,
    SIGILL,
    SIGSEGV,
    SIGTRAP,
    SIGTERM,
    SIGKILL,
};

static int s_fatal_signal_num = sizeof(s_fatal_signals) / sizeof(s_fatal_signals[0]);

void UncaughtExceptionHandler(NSException *exception) {
    NSArray *exceptionArray = [exception callStackSymbols]; //得到当前调用栈信息
    NSString *exceptionReason = [exception reason];       //非常重要，就是崩溃的原因
    NSString *exceptionName = [exception name];           //异常类型
}

void SignalHandler(int code)
{
    NSLog(@"signal handler = %d",code);
}

void InitCrashReport()
{
    //系统错误信号捕获
    for (int i = 0; i < s_fatal_signal_num; ++i) {
        signal(s_fatal_signals[i], SignalHandler);
    }
    
    //oc未捕获异常的捕获
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}

//// 获取数据
//NSData *lagData = [[[PLCrashReporter alloc] initWithConfiguration:[[PLCrashReporterConfig alloc] initWithSignalHandlerType:PLCrashReporterSignalHandlerTypeBSD symbolicationStrategy:PLCrashReporterSymbolicationStrategyAll]] generateLiveReport];
//// 转换成 PLCrashReport 对象
//PLCrashReport *lagReport = [[PLCrashReport alloc] initWithData:lagData error:NULL];
//// 进行字符串格式化处理
//NSString *lagReportString = [PLCrashReportTextFormatter stringValueForCrashReport:lagReport withTextFormat:PLCrashReportTextFormatiOS];
////将字符串上传服务器
//NSLog(@"lag happen, detail below: \n %@",lagReportString);


//接下来，我们就看看 iOS 10 之后，如何来获取 NSLog 日志。
//统一日志系统的方式，是把日志集中存放在内存和数据库里，并提供单一、高效和高性能的接口去获取系统所有级别的消息传递。
//macOS 10.12 开始使用了统一日志系统，我们通过控制台应用程序或日志命令行工具，就可以查看到日志消息。
//但是，新的统一日志系统没有 ASL 那样的接口可以让我们取出全部日志，所以为了兼容新的统一日志系统，你就需要对 NSLog 日志的输出进行重定向。
//对 NSLog 进行重定向，我们首先想到的就是采用 Hook 的方式。
//因为 NSLog 本身就是一个 C 函数，而不是 Objective-C 方法，所以我们就可以使用 fishhook 来完成重定向的工作。具体的实现代码如下所示：

//static void (&orig_nslog)(NSString *format, ...);
//
//void redirect_nslog(NSString *format, ...) {
//    // 可以在这里先进行自己的处理
//
//    // 继续执行原 NSLog
//    va_list va;
//    va_start(va, format);
//    NSLogv(format, va);
//    va_end(va);
//}

int main(int argc, char * argv[]) {
    InitCrashReport();
    [SQCallTrace start];
    
//    struct rebinding nslog_rebinding = {"NSLog",redirect_nslog,(void*)&orig_nslog};
//    NSLog(@"try redirect nslog %@,%d",@"is that ok?");

//    int fd = open(path, (O_RDWR | O_CREAT), 0644);
//    dup2(fd, STDERR_FILENO);
    
    NSLog(@"%s", __func__);
    NSString * appDelegateClassName;
    @autoreleasepool {
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
