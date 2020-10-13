//
//  Infer.m
//  13-性能优化
//
//  Created by 朱双泉 on 2020/10/13.
//

brew install infer

infer -- clang -c Infer.m

Capturing in make/cc mode...
Found 1 source file to analyze in /Users/zhushuangquan/Codes/GitHub/coderZsq.practice.native/StudyNotes/Lang Collection/Objective-C/13-性能优化/13-性能优化/Lint/infer-out


Analysis finished in 4.468ss

Found 3 issues

Infer.m:18: error: NULL_DEREFERENCE
  pointer `infer` last assigned on line 17 could be null and is dereferenced at line 18, column 12.
  16.   NSString* m() {
  17.       Infer* infer = nil;
  18. >     return infer->_s;
  19.   }
  20.

Infer.m:18: warning: DIRECT_ATOMIC_PROPERTY_ACCESS
  Direct access to ivar `_s` of an atomic property at line 18, column 12. Accessing an ivar of an atomic property makes the property nonatomic.
  16.   NSString* m() {
  17.       Infer* infer = nil;
  18. >     return infer->_s;
  19.   }
  20.

Infer.m:11: warning: ASSIGN_POINTER_WARNING
  Property `s` is a pointer type marked with the `assign` attribute at line 11, column 1. Use a different attribute like `strong` or `weak`.
  9.
  10.   @interface Infer ()
  11. > @property NSString *s;
  12.   @end
  13.


Summary of the reports

               NULL_DEREFERENCE: 1
  DIRECT_ATOMIC_PROPERTY_ACCESS: 1
         ASSIGN_POINTER_WARNING: 1

Capturing in make/cc mode...
Found 1 source file to analyze in /Users/zhushuangquan/Codes/GitHub/coderZsq.practice.native/StudyNotes/Lang Collection/Objective-C/13-性能优化/13-性能优化/Lint/infer-out


Analysis finished in 3.558ss

Found 1 issue

Infer.m:53: warning: ASSIGN_POINTER_WARNING
  Property `s` is a pointer type marked with the `assign` attribute at line 53, column 1. Use a different attribute like `strong` or `weak`.
  51.
  52.   @interface Infer ()
  53. > @property NSString *s;
  54.   @end
  55.


Summary of the reports

  ASSIGN_POINTER_WARNING: 1

Capturing in make/cc mode...
Found 1 source file to analyze in /Users/zhushuangquan/Codes/GitHub/coderZsq.practice.native/StudyNotes/Lang Collection/Objective-C/13-性能优化/13-性能优化/Lint/infer-out


Analysis finished in 3.625ss

  No issues found

#import "Infer.h"

@interface Infer ()
//@property NSString *s;
@property (nonatomic, strong) NSString *s;
@end

@implementation Infer

NSString* m() {
    Infer* infer = nil;
//    return infer->_s;
    return infer.s;
}

@end


