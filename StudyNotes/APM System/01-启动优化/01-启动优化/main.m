//
//  main.m
//  01-启动优化
//
//  Created by 朱双泉 on 2020/9/30.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

/**
 App 的启动主要包括三个阶段：
 
 1. main() 函数执行前；
 2. main() 函数执行后；
 3. 首屏渲染完成后。
 
 +[AppDelegate load]
 +[SceneDelegate load]
 +[LaunchScreenViewController load]
   total time: 812.56 milliseconds (100.0%)
   total images loaded:  341 (334 from dyld shared cache)
   total segments mapped: 21, into 383 pages
   total images loading time: 636.46 milliseconds (78.3%)
   total load time in ObjC:  10.46 milliseconds (1.2%)
   total debugger pause time: 460.03 milliseconds (56.6%)
   total dtrace DOF registration time:   0.00 milliseconds (0.0%)
   total rebase fixups:  16,276
   total rebase fixups time:   0.33 milliseconds (0.0%)
   total binding fixups: 492,218
   total binding fixups time: 110.61 milliseconds (13.6%)
   total weak binding fixups time:   0.03 milliseconds (0.0%)
   total redo shared cached bindings time: 182.77 milliseconds (22.4%)
   total bindings lazily fixed up: 0 of 0
   total time in initializers and ObjC +load:  54.65 milliseconds (6.7%)
                          libSystem.B.dylib :   4.39 milliseconds (0.5%)
                libBacktraceRecording.dylib :   7.80 milliseconds (0.9%)
                            libobjc.A.dylib :   1.70 milliseconds (0.2%)
                             CoreFoundation :   1.02 milliseconds (0.1%)
                 libMainThreadChecker.dylib :  33.96 milliseconds (4.1%)
                            01-启动优化 :   3.10 milliseconds (0.3%)
 total symbol trie searches:    1164250
 total symbol table binary searches:    0
 total images defining weak symbols:  35
 total images using weak symbols:  89
 main
 +[AppDelegate initialize]_block_invoke
 -[AppDelegate application:didFinishLaunchingWithOptions:]
 +[SceneDelegate initialize]_block_invoke
 +[LaunchScreenViewController initialize]_block_invoke
 -[SceneDelegate scene:willConnectToSession:options:] - begin
 -[LaunchScreenViewController viewDidLoad]
 -[SceneDelegate scene:willConnectToSession:options:] - end
 -[SceneDelegate sceneWillEnterForeground:]
 -[SceneDelegate sceneDidBecomeActive:]
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
 
 方法级别的启动优化
 第一种方法是，定时抓取主线程上的方法调用堆栈，计算一段时间里各个方法的耗时。
 第二种方法是，对 objc_msgSend 方法进行 hook 来掌握所有方法的执行耗时。
 */
int main(int argc, char * argv[]) {
    NSLog(@"%s", __func__);
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
