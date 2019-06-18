~/Desktop/AST/AST zhushuangquan$ swiftc -emit -ir main.swift -o main.ll

; ModuleID = 'main.ll'
source_filename = "main.ll"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%swift.type = type { i64 }
%swift.bridge = type opaque
%Any = type { [24 x i8], %swift.type* }
%TSS = type <{ %Ts11_StringGutsV }>
%Ts11_StringGutsV = type <{ %Ts13_StringObjectV }>
%Ts13_StringObjectV = type <{ %Ts6UInt64V, %swift.bridge* }>
%Ts6UInt64V = type <{ i64 }>

@0 = private unnamed_addr constant [14 x i8] c"Hello, World!\00"
@"$sSSN" = external global %swift.type, align 8
@"_swift_FORCE_LOAD_$_swiftFoundation_$_main" = weak hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftFoundation"
@"_swift_FORCE_LOAD_$_swiftDarwin_$_main" = weak hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftDarwin"
@"_swift_FORCE_LOAD_$_swiftObjectiveC_$_main" = weak hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftObjectiveC"
@"_swift_FORCE_LOAD_$_swiftCoreFoundation_$_main" = weak hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftCoreFoundation"
@"_swift_FORCE_LOAD_$_swiftDispatch_$_main" = weak hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftDispatch"
@"_swift_FORCE_LOAD_$_swiftCoreGraphics_$_main" = weak hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftCoreGraphics"
@"_swift_FORCE_LOAD_$_swiftIOKit_$_main" = weak hidden constant void ()* @"_swift_FORCE_LOAD_$_swiftIOKit"
@1 = private unnamed_addr constant [2 x i8] c"\0A\00"
@2 = private unnamed_addr constant [2 x i8] c" \00"
@__swift_reflection_version = linkonce_odr hidden constant i16 3
@llvm.used = appending global [8 x i8*] [i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftFoundation_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftDarwin_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftObjectiveC_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftCoreFoundation_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftDispatch_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftCoreGraphics_$_main" to i8*), i8* bitcast (void ()** @"_swift_FORCE_LOAD_$_swiftIOKit_$_main" to i8*), i8* bitcast (i16* @__swift_reflection_version to i8*)], section "llvm.metadata", align 8

define i32 @main(i32, i8**) #0 {
entry:
  %2 = bitcast i8** %1 to i8*
  %3 = call swiftcc { %swift.bridge*, i8* } @"$ss27_allocateUninitializedArrayySayxG_BptBwlFyp_Tg5"(i64 1)
  %4 = extractvalue { %swift.bridge*, i8* } %3, 0
  %5 = extractvalue { %swift.bridge*, i8* } %3, 1
  %6 = bitcast i8* %5 to %Any*
  %7 = call swiftcc { i64, %swift.bridge* } @"$sSS21_builtinStringLiteral17utf8CodeUnitCount7isASCIISSBp_BwBi1_tcfC"(i8* getelementptr inbounds ([14 x i8], [14 x i8]* @0, i64 0, i64 0), i64 13, i1 true)
  %8 = extractvalue { i64, %swift.bridge* } %7, 0
  %9 = extractvalue { i64, %swift.bridge* } %7, 1
  %10 = getelementptr inbounds %Any, %Any* %6, i32 0, i32 1
  store %swift.type* @"$sSSN", %swift.type** %10, align 8
  %11 = getelementptr inbounds %Any, %Any* %6, i32 0, i32 0
  %12 = getelementptr inbounds %Any, %Any* %6, i32 0, i32 0
  %13 = bitcast [24 x i8]* %12 to %TSS*
  %._guts = getelementptr inbounds %TSS, %TSS* %13, i32 0, i32 0
  %._guts._object = getelementptr inbounds %Ts11_StringGutsV, %Ts11_StringGutsV* %._guts, i32 0, i32 0
  %._guts._object._countAndFlagsBits = getelementptr inbounds %Ts13_StringObjectV, %Ts13_StringObjectV* %._guts._object, i32 0, i32 0
  %._guts._object._countAndFlagsBits._value = getelementptr inbounds %Ts6UInt64V, %Ts6UInt64V* %._guts._object._countAndFlagsBits, i32 0, i32 0
  store i64 %8, i64* %._guts._object._countAndFlagsBits._value, align 8
  %._guts._object._object = getelementptr inbounds %Ts13_StringObjectV, %Ts13_StringObjectV* %._guts._object, i32 0, i32 1
  store %swift.bridge* %9, %swift.bridge** %._guts._object._object, align 8
  %14 = call swiftcc { i64, %swift.bridge* } @"$ss5print_9separator10terminatoryypd_S2StFfA0_"()
  %15 = extractvalue { i64, %swift.bridge* } %14, 0
  %16 = extractvalue { i64, %swift.bridge* } %14, 1
  %17 = call swiftcc { i64, %swift.bridge* } @"$ss5print_9separator10terminatoryypd_S2StFfA1_"()
  %18 = extractvalue { i64, %swift.bridge* } %17, 0
  %19 = extractvalue { i64, %swift.bridge* } %17, 1
  call swiftcc void @"$ss5print_9separator10terminatoryypd_S2StF"(%swift.bridge* %4, i64 %15, %swift.bridge* %16, i64 %18, %swift.bridge* %19)
  call void @swift_bridgeObjectRelease(%swift.bridge* %19) #1
  call void @swift_bridgeObjectRelease(%swift.bridge* %16) #1
  call void @swift_bridgeObjectRelease(%swift.bridge* %4) #1
  ret i32 0
}

declare swiftcc { %swift.bridge*, i8* } @"$ss27_allocateUninitializedArrayySayxG_BptBwlFyp_Tg5"(i64) #0

declare swiftcc { i64, %swift.bridge* } @"$sSS21_builtinStringLiteral17utf8CodeUnitCount7isASCIISSBp_BwBi1_tcfC"(i8*, i64, i1) #0

define linkonce_odr hidden swiftcc { i64, %swift.bridge* } @"$ss5print_9separator10terminatoryypd_S2StFfA0_"() #0 {
entry:
  %0 = call swiftcc { i64, %swift.bridge* } @"$sSS21_builtinStringLiteral17utf8CodeUnitCount7isASCIISSBp_BwBi1_tcfC"(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @2, i64 0, i64 0), i64 1, i1 true)
  %1 = extractvalue { i64, %swift.bridge* } %0, 0
  %2 = extractvalue { i64, %swift.bridge* } %0, 1
  %3 = insertvalue { i64, %swift.bridge* } undef, i64 %1, 0
  %4 = insertvalue { i64, %swift.bridge* } %3, %swift.bridge* %2, 1
  ret { i64, %swift.bridge* } %4
}

define linkonce_odr hidden swiftcc { i64, %swift.bridge* } @"$ss5print_9separator10terminatoryypd_S2StFfA1_"() #0 {
entry:
  %0 = call swiftcc { i64, %swift.bridge* } @"$sSS21_builtinStringLiteral17utf8CodeUnitCount7isASCIISSBp_BwBi1_tcfC"(i8* getelementptr inbounds ([2 x i8], [2 x i8]* @1, i64 0, i64 0), i64 1, i1 true)
  %1 = extractvalue { i64, %swift.bridge* } %0, 0
  %2 = extractvalue { i64, %swift.bridge* } %0, 1
  %3 = insertvalue { i64, %swift.bridge* } undef, i64 %1, 0
  %4 = insertvalue { i64, %swift.bridge* } %3, %swift.bridge* %2, 1
  ret { i64, %swift.bridge* } %4
}

declare swiftcc void @"$ss5print_9separator10terminatoryypd_S2StF"(%swift.bridge*, i64, %swift.bridge*, i64, %swift.bridge*) #0

; Function Attrs: nounwind
declare void @swift_bridgeObjectRelease(%swift.bridge*) #1

declare void @"_swift_FORCE_LOAD_$_swiftFoundation"()

declare void @"_swift_FORCE_LOAD_$_swiftDarwin"()

declare void @"_swift_FORCE_LOAD_$_swiftObjectiveC"()

declare void @"_swift_FORCE_LOAD_$_swiftCoreFoundation"()

declare void @"_swift_FORCE_LOAD_$_swiftDispatch"()

declare void @"_swift_FORCE_LOAD_$_swiftCoreGraphics"()

declare void @"_swift_FORCE_LOAD_$_swiftIOKit"()

attributes #0 = { "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" }
attributes #1 = { nounwind }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7, !8}
!swift.module.flags = !{!9}
!llvm.linker.options = !{!10, !11, !12, !13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31}
!llvm.asan.globals = !{!32}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 14]}
!1 = !{i32 1, !"Objective-C Version", i32 2}
!2 = !{i32 1, !"Objective-C Image Info Version", i32 0}
!3 = !{i32 1, !"Objective-C Image Info Section", !"__DATA,__objc_imageinfo,regular,no_dead_strip"}
!4 = !{i32 4, !"Objective-C Garbage Collection", i32 83887872}
!5 = !{i32 1, !"Objective-C Class Properties", i32 64}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = !{i32 7, !"PIC Level", i32 2}
!8 = !{i32 1, !"Swift Version", i32 7}
!9 = !{!"standard-library", i1 false}
!10 = !{!"-lswiftFoundation"}
!11 = !{!"-lswiftCore"}
!12 = !{!"-lswiftDarwin"}
!13 = !{!"-lswiftObjectiveC"}
!14 = !{!"-lswiftCoreFoundation"}
!15 = !{!"-framework", !"CoreFoundation"}
!16 = !{!"-lswiftDispatch"}
!17 = !{!"-framework", !"Foundation"}
!18 = !{!"-framework", !"ApplicationServices"}
!19 = !{!"-framework", !"ImageIO"}
!20 = !{!"-lswiftCoreGraphics"}
!21 = !{!"-framework", !"CoreGraphics"}
!22 = !{!"-lswiftIOKit"}
!23 = !{!"-framework", !"IOKit"}
!24 = !{!"-framework", !"CoreText"}
!25 = !{!"-framework", !"ColorSync"}
!26 = !{!"-framework", !"CoreServices"}
!27 = !{!"-framework", !"CFNetwork"}
!28 = !{!"-framework", !"Security"}
!29 = !{!"-framework", !"DiskArbitration"}
!30 = !{!"-lswiftSwiftOnoneSupport"}
!31 = !{!"-lobjc"}
!32 = !{[8 x i8*]* @llvm.used, null, null, i1 false, i1 true}
