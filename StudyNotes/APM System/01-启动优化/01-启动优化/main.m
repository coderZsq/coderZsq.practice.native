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
int main(int argc, char * argv[]) {
    NSLog(@"%s", __func__);
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
