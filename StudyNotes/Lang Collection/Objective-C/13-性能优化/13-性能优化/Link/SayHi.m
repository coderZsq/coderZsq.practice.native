//
//  SayHi.c
//  13-性能优化
//
//  Created by 朱双泉 on 2020/10/1.
//


#import "Boy.h"

xcrun clang -c Boy.m
xcrun clang -c SayHi.m
xcrun clang SayHi.o Boy.o -Wl,`xcrun -show-sdk-path`/System/Library/Frameworks/Foundation.framework/Foundation

/**
 _OBJC_CLASS_$_Boy ，表示 Boy 的 OC 符号。
 (undefined) external ，表示未实现非私有。如果是私有的话，就是 non-external。
 external _main ，表示 main() 函数，处理 0 地址，记录在 __TEXT,__text 区域里。
 */
xcrun nm -nm SayHi.o
                 (undefined) external _OBJC_CLASS_$_Boy
                 (undefined) external _objc_alloc_init
                 (undefined) external _objc_autoreleasePoolPop
                 (undefined) external _objc_autoreleasePoolPush
                 (undefined) external _objc_msgSend
0000000000000000 (__TEXT,__text) external _main
0000000000000060 (__DATA,__objc_classrefs) non-external _OBJC_CLASSLIST_REFERENCES_$_
0000000000000070 (__DATA,__objc_selrefs) non-external _OBJC_SELECTOR_REFERENCES_

/**
 因为 undefined 符号表示的是该文件类未定义，所以在目标文件和 Foundation framework 动态库做链接处理时，链接器会尝试解析所有的 undefined 符号。
 */
xcrun nm -nm Boy.o
                 (undefined) external _NSLog
                 (undefined) external _OBJC_CLASS_$_NSObject
                 (undefined) external _OBJC_METACLASS_$_NSObject
                 (undefined) external ___CFConstantStringClassReference
                 (undefined) external __objc_empty_cache
0000000000000000 (__TEXT,__text) non-external -[Boy say]
0000000000000060 (__DATA,__objc_const) non-external __OBJC_METACLASS_RO_$_Boy
00000000000000a8 (__DATA,__objc_const) non-external __OBJC_$_INSTANCE_METHODS_Boy
00000000000000c8 (__DATA,__objc_const) non-external __OBJC_CLASS_RO_$_Boy
0000000000000110 (__DATA,__objc_data) external _OBJC_METACLASS_$_Boy
0000000000000138 (__DATA,__objc_data) external _OBJC_CLASS_$_Boy

/**
 接器通过动态库解析成符号会记录是通过哪个动态库解析的，路径也会一起记录下来。你可以再用 nm 工具查看 a.out 符号表，对比 boy.o 的符号表，看看链接器是怎么解析符号的。
 */
xcrun nm -nm a.out
                 (undefined) external _NSLog (from Foundation)
                 (undefined) external _OBJC_CLASS_$_NSObject (from libobjc)
                 (undefined) external _OBJC_METACLASS_$_NSObject (from libobjc)
                 (undefined) external ___CFConstantStringClassReference (from CoreFoundation)
                 (undefined) external __objc_empty_cache (from libobjc)
                 (undefined) external _objc_alloc_init (from libobjc)
                 (undefined) external _objc_autoreleasePoolPop (from libobjc)
                 (undefined) external _objc_autoreleasePoolPush (from libobjc)
                 (undefined) external _objc_msgSend (from libobjc)
                 (undefined) external dyld_stub_binder (from libSystem)
0000000100000000 (__TEXT,__text) [referenced dynamically] external __mh_execute_header
0000000100003eb0 (__TEXT,__text) external _main
0000000100003f10 (__TEXT,__text) non-external -[Boy say]
0000000100008020 (__DATA,__objc_const) non-external __OBJC_METACLASS_RO_$_Boy
0000000100008068 (__DATA,__objc_const) non-external __OBJC_$_INSTANCE_METHODS_Boy
0000000100008088 (__DATA,__objc_const) non-external __OBJC_CLASS_RO_$_Boy
00000001000080e0 (__DATA,__objc_data) external _OBJC_METACLASS_$_Boy
0000000100008108 (__DATA,__objc_data) external _OBJC_CLASS_$_Boy
0000000100008130 (__DATA,__data) non-external __dyld_private

/**
 这些 undefined 符号需要的两个库分别是 libSystem 和 libobjc。查看 libSystem 库的话，你可以看到常用的 GCD 的 libdispatch，还有 Block 的 libsystem_blocks。
 */
xcrun otool -L a.out
a.out:
    /System/Library/Frameworks/Foundation.framework/Versions/C/Foundation (compatibility version 300.0.0, current version 1677.104.0)
    /usr/lib/libSystem.B.dylib (compatibility version 1.0.0, current version 1281.100.1)
    /System/Library/Frameworks/CoreFoundation.framework/Versions/A/CoreFoundation (compatibility version 150.0.0, current version 1677.104.0)
    /usr/lib/libobjc.A.dylib (compatibility version 1.0.0, current version 228.0.0)

/**
 dylib 这种格式，表示是动态链接的，编译的时候不会被编译到执行文件中，在程序执行的时候才 link，这样就不用算到包大小里，而且不更新执行程序就能够更新库。
 
 数一下，被加载的库还挺多的。因为 Foundation 还会依赖一些其他动态库，这些依赖的其他库还会再依赖更多的库，所以相互依赖的符号会很多，需要处理的时间也会比较长。这里系统上的动态链接器会使用共享缓存，共享缓存在 /var/db/dyld/。当加载 Mach-O 文件时，动态链接器会先检查是否有共享缓存。每个进程都会在自己的地址空间映射这些共享缓存，这样做可以起到优化 App 启动速度的作用。
 
 简单来说， dyld 做了这么几件事儿：先执行 Mach-O 文件，根据 Mach-O 文件里 undefined 的符号加载对应的动态库，系统会设置一个共享缓存来解决加载的递归依赖问题；加载后，将 undefined 的符号绑定到动态库里对应的地址上；最后再处理 +load 方法，main 函数返回后运行 static terminator。
 */
(export DYLD_PRINT_LIBRARIES=; ./a.out )
dyld: loaded: <1DD6F88B-18C2-3619-B43F-850B1DA5ACD6> /Users/zhushuangquan/Codes/GitHub/coderZsq.practice.native/StudyNotes/Lang Collection/Objective-C/13-性能优化/13-性能优化/./a.out
dyld: loaded: <7C69F845-F651-3193-8262-5938010EC67D> /System/Library/Frameworks/Foundation.framework/Versions/C/Foundation
dyld: loaded: <C0C9872A-E730-37EA-954A-3CE087C15535> /usr/lib/libSystem.B.dylib
dyld: loaded: <C0D70026-EDBE-3CBD-B317-367CF4F1C92F> /System/Library/Frameworks/CoreFoundation.framework/Versions/A/CoreFoundation
...

* thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 1.1
  * frame #0: 0x0000000100003eec debug-objc`+[Foo load](self=Foo, _cmd="load") at Foo.m:14:1
    frame #1: 0x00007fff6a71d560 libobjc.A.dylib`load_images + 1529
    frame #2: 0x000000010001626c dyld`dyld::notifySingle(dyld_image_states, ImageLoader const*, ImageLoader::InitializerTimingList*) + 418
    frame #3: 0x0000000100029fe9 dyld`ImageLoader::recursiveInitialization(ImageLoader::LinkContext const&, unsigned int, char const*, ImageLoader::InitializerTimingList&, ImageLoader::UninitedUpwards&) + 475
    frame #4: 0x00000001000280b4 dyld`ImageLoader::processInitializers(ImageLoader::LinkContext const&, unsigned int, ImageLoader::InitializerTimingList&, ImageLoader::UninitedUpwards&) + 188
    frame #5: 0x0000000100028154 dyld`ImageLoader::runInitializers(ImageLoader::LinkContext const&, ImageLoader::InitializerTimingList&) + 82
    frame #6: 0x00000001000166a8 dyld`dyld::initializeMainExecutable() + 199
    frame #7: 0x000000010001bbba dyld`dyld::_main(macho_header const*, unsigned long, int, char const**, char const**, char const**, unsigned long*) + 6667
    frame #8: 0x0000000100015227 dyld`dyldbootstrap::start(dyld3::MachOLoaded const*, int, char const**, dyld3::MachOLoaded const*, unsigned long*) + 453
    frame #9: 0x0000000100015025 dyld`_dyld_start + 37

int main(int argc, char *argv[])
{
    @autoreleasepool {
        Boy *boy = [[Boy alloc] init];
        [boy say];
        return 0;
    }
}
