//
//  OCLint.m
//  13-性能优化
//
//  Created by 朱双泉 on 2020/10/1.
//

oclint OCLint.m

//Error while trying to load a compilation database:
//Could not auto-detect compilation database for file "OCLint.m"
//No compilation database found in /Users/zhushuangquan/Codes/GitHub/coderZsq.practice.native/StudyNotes/Lang Collection/Objective-C/13-性能优化/13-性能优化/Lint or any parent directory
//json-compilation-database: Error while opening JSON database: No such file or directory
//Running without flags.
//
//Compiler Errors:
//(please be aware that these errors will prevent OCLint from analyzing this source code)
//
///Users/zhushuangquan/Codes/GitHub/coderZsq.practice.native/StudyNotes/Lang Collection/Objective-C/13-性能优化/13-性能优化/Lint/OCLint.m:7:10: 'stdio.h' file not found
//
//
//OCLint Report
//
//Summary: TotalFiles=0 FilesWithViolations=0 P1=0 P2=0 P3=0

oclint -report-type html -o report.html OCLint.m

xcodebuild -project 13-性能优化.xcodeproj | tee xcodebuild.log | xcpretty -r json-compilation-database -o compile_commands.json

2020-10-01 18:29:24.689 xcodebuild[31509:914328] [MT] PluginLoading: Required plug-in compatibility UUID 6C8909A0-F208-4C21-9224-504F9A70056E for plug-in at path '~/Library/Application Support/Developer/Shared/Xcode/Plug-ins/RealmPlugin.xcplugin' not present in DVTPlugInCompatibilityUUIDs
▸ Compiling AppDelegate.m
▸ Compiling main.m
▸ Compiling fishhook.c
▸ Compiling SQCallTrace.m
▸ Compiling SQCallTraceCore.c
▸ Compiling ViewController.m
▸ Compiling SceneDelegate.m
▸ Compiling SQFluecyMonitor.m
▸ Compiling SQCallTraceModel.m
▸ Compiling SQBacktraceLogger.m
▸ Linking 13-性能优化
▸ Compiling Main.storyboard
▸ Compiling LaunchScreen.storyboard
▸ Processing Info.plist
▸ Generating '13-性能优化.app.dSYM'
▸ Touching 13-性能优化.app (in target '13-性能优化' from project '13-性能优化')
▸ Build Succeeded

oclint-json-compilation-database -e Pods -- -report-type pmd -o report.html

#include <stdio.h>

int main(int argc, char *argv[])
{
    @autoreleasepool {
        printf("Hello world!\n");
        return 0;
    }
}
