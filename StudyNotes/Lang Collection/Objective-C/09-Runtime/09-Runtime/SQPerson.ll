; ModuleID = 'SQPerson.m'
source_filename = "SQPerson.m"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.15.0"

%0 = type opaque
%1 = type opaque
%2 = type opaque
%3 = type opaque
%4 = type opaque
%5 = type opaque
%struct.__NSConstantString_tag = type { i32*, i32, i8*, i64 }
%struct._class_t = type { %struct._class_t*, %struct._class_t*, %struct._objc_cache*, i8* (i8*, i8*)**, %struct._class_ro_t* }
%struct._objc_cache = type opaque
%struct._class_ro_t = type { i32, i32, i32, i8*, i8*, %struct.__method_list_t*, %struct._objc_protocol_list*, %struct._ivar_list_t*, i8*, %struct._prop_list_t* }
%struct.__method_list_t = type { i32, i32, [0 x %struct._objc_method] }
%struct._objc_method = type { i8*, i8*, i8* }
%struct._objc_protocol_list = type { i64, [0 x %struct._protocol_t*] }
%struct._protocol_t = type { i8*, i8*, %struct._objc_protocol_list*, %struct.__method_list_t*, %struct.__method_list_t*, %struct.__method_list_t*, %struct.__method_list_t*, %struct._prop_list_t*, i32, i32, i8**, i8*, %struct._prop_list_t* }
%struct._ivar_list_t = type { i32, i32, [0 x %struct._ivar_t] }
%struct._ivar_t = type { i64*, i8*, i8*, i32, i32 }
%struct._prop_list_t = type { i32, i32, [0 x %struct._prop_t] }
%struct._prop_t = type { i8*, i8* }
%struct._objc_super = type { i8*, i8* }
%union.anon = type { i8 }

@__CFConstantStringClassReference = external global [0 x i32]
@.str = private unnamed_addr constant [14 x i8] c"my name is %@\00", section "__TEXT,__cstring,cstring_literals", align 1
@_unnamed_cfstring_ = private global %struct.__NSConstantString_tag { i32* getelementptr inbounds ([0 x i32], [0 x i32]* @__CFConstantStringClassReference, i32 0, i32 0), i32 1992, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str, i32 0, i32 0), i64 13 }, section "__DATA,__cfstring", align 8 #0
@OBJC_METH_VAR_NAME_ = private unnamed_addr constant [5 x i8] c"name\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_ = internal externally_initialized global i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@"OBJC_CLASS_$_SQPerson" = global %struct._class_t { %struct._class_t* @"OBJC_METACLASS_$_SQPerson", %struct._class_t* @"OBJC_CLASS_$_NSObject", %struct._objc_cache* @_objc_empty_cache, i8* (i8*, i8*)** null, %struct._class_ro_t* @"_OBJC_CLASS_RO_$_SQPerson" }, section "__DATA, __objc_data", align 8
@"OBJC_CLASSLIST_SUP_REFS_$_" = private global %struct._class_t* @"OBJC_CLASS_$_SQPerson", section "__DATA,__objc_superrefs,regular,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.1 = private unnamed_addr constant [28 x i8] c"methodSignatureForSelector:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.2 = internal externally_initialized global i8* getelementptr inbounds ([28 x i8], [28 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@"OBJC_CLASS_$_NSMethodSignature" = external global %struct._class_t
@"OBJC_CLASSLIST_REFERENCES_$_" = internal global %struct._class_t* @"OBJC_CLASS_$_NSMethodSignature", section "__DATA,__objc_classrefs,regular,no_dead_strip", align 8
@.str.3 = private unnamed_addr constant [4 x i8] c"v@:\00", align 1
@OBJC_METH_VAR_NAME_.4 = private unnamed_addr constant [24 x i8] c"signatureWithObjCTypes:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.5 = internal externally_initialized global i8* getelementptr inbounds ([24 x i8], [24 x i8]* @OBJC_METH_VAR_NAME_.4, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@.str.6 = private unnamed_addr constant [8 x i16] [i16 25214, i16 19981, i16 21040, i16 37, i16 64, i16 26041, i16 27861, i16 0], section "__TEXT,__ustring", align 2
@_unnamed_cfstring_.7 = private global %struct.__NSConstantString_tag { i32* getelementptr inbounds ([0 x i32], [0 x i32]* @__CFConstantStringClassReference, i32 0, i32 0), i32 2000, i8* bitcast ([8 x i16]* @.str.6 to i8*), i64 7 }, section "__DATA,__cfstring", align 8 #0
@OBJC_METH_VAR_NAME_.8 = private unnamed_addr constant [9 x i8] c"selector\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.9 = internal externally_initialized global i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.8, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@.str.10 = private unnamed_addr constant [3 x i8] c"%s\00", section "__TEXT,__cstring,cstring_literals", align 1
@_unnamed_cfstring_.11 = private global %struct.__NSConstantString_tag { i32* getelementptr inbounds ([0 x i32], [0 x i32]* @__CFConstantStringClassReference, i32 0, i32 0), i32 1992, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.10, i32 0, i32 0), i64 2 }, section "__DATA,__cfstring", align 8 #0
@"__func__.-[SQPerson run]" = private unnamed_addr constant [16 x i8] c"-[SQPerson run]\00", align 1
@"__func__.-[SQPerson test]" = private unnamed_addr constant [17 x i8] c"-[SQPerson test]\00", align 1
@.str.12 = private unnamed_addr constant [10 x i8] c"age is %d\00", section "__TEXT,__cstring,cstring_literals", align 1
@_unnamed_cfstring_.13 = private global %struct.__NSConstantString_tag { i32* getelementptr inbounds ([0 x i32], [0 x i32]* @__CFConstantStringClassReference, i32 0, i32 0), i32 1992, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.12, i32 0, i32 0), i64 9 }, section "__DATA,__cfstring", align 8 #0
@OBJC_METH_VAR_NAME_.14 = private unnamed_addr constant [8 x i8] c"setAge:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.15 = internal externally_initialized global i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_NAME_.14, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@.str.16 = private unnamed_addr constant [5 x i8] c"v@:i\00", align 1
@OBJC_METH_VAR_NAME_.17 = private unnamed_addr constant [4 x i8] c"age\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.18 = internal externally_initialized global i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_METH_VAR_NAME_.17, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@.str.19 = private unnamed_addr constant [4 x i8] c"i@:\00", align 1
@"OBJC_METACLASS_$_SQPerson" = global %struct._class_t { %struct._class_t* @"OBJC_METACLASS_$_NSObject", %struct._class_t* @"OBJC_METACLASS_$_NSObject", %struct._objc_cache* @_objc_empty_cache, i8* (i8*, i8*)** null, %struct._class_ro_t* @"_OBJC_METACLASS_RO_$_SQPerson" }, section "__DATA, __objc_data", align 8
@"OBJC_CLASSLIST_SUP_REFS_$_.20" = private global %struct._class_t* @"OBJC_METACLASS_$_SQPerson", section "__DATA,__objc_superrefs,regular,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.21 = private unnamed_addr constant [20 x i8] c"resolveClassMethod:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.22 = internal externally_initialized global i8* getelementptr inbounds ([20 x i8], [20 x i8]* @OBJC_METH_VAR_NAME_.21, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.23 = private unnamed_addr constant [5 x i8] c"test\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.24 = internal externally_initialized global i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.23, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@"OBJC_CLASS_$_SQCat" = external global %struct._class_t
@"OBJC_CLASSLIST_REFERENCES_$_.25" = internal global %struct._class_t* @"OBJC_CLASS_$_SQCat", section "__DATA,__objc_classrefs,regular,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.26 = private unnamed_addr constant [29 x i8] c"forwardingTargetForSelector:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.27 = internal externally_initialized global i8* getelementptr inbounds ([29 x i8], [29 x i8]* @OBJC_METH_VAR_NAME_.26, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@"__func__.+[SQPerson forwardInvocation:]" = private unnamed_addr constant [31 x i8] c"+[SQPerson forwardInvocation:]\00", align 1
@.str.28 = private unnamed_addr constant [18 x i8] c"c_other - %@ - %@\00", section "__TEXT,__cstring,cstring_literals", align 1
@_unnamed_cfstring_.29 = private global %struct.__NSConstantString_tag { i32* getelementptr inbounds ([0 x i32], [0 x i32]* @__CFConstantStringClassReference, i32 0, i32 0), i32 1992, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.28, i32 0, i32 0), i64 17 }, section "__DATA,__cfstring", align 8 #0
@"__func__.-[SQPerson other]" = private unnamed_addr constant [18 x i8] c"-[SQPerson other]\00", align 1
@"__func__.-[SQPerson test:height:]" = private unnamed_addr constant [25 x i8] c"-[SQPerson test:height:]\00", align 1
@"__func__.-[SQPerson personTest]" = private unnamed_addr constant [23 x i8] c"-[SQPerson personTest]\00", align 1
@OBJC_METH_VAR_NAME_.30 = private unnamed_addr constant [5 x i8] c"init\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.31 = internal externally_initialized global i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.30, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@_objc_empty_cache = external global %struct._objc_cache
@"OBJC_METACLASS_$_NSObject" = external global %struct._class_t
@OBJC_CLASS_NAME_ = private unnamed_addr constant [9 x i8] c"SQPerson\00", section "__TEXT,__objc_classname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.32 = private unnamed_addr constant [23 x i8] c"resolveInstanceMethod:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_ = private unnamed_addr constant [11 x i8] c"c24@0:8:16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.33 = private unnamed_addr constant [11 x i8] c"@24@0:8:16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.34 = private unnamed_addr constant [19 x i8] c"forwardInvocation:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.35 = private unnamed_addr constant [11 x i8] c"v24@0:8@16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"_OBJC_$_CLASS_METHODS_SQPerson" = internal global { i32, i32, [4 x %struct._objc_method] } { i32 24, i32 4, [4 x %struct._objc_method] [%struct._objc_method { i8* getelementptr inbounds ([23 x i8], [23 x i8]* @OBJC_METH_VAR_NAME_.32, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_, i32 0, i32 0), i8* bitcast (i8 (i8*, i8*, i8*)* @"\01+[SQPerson resolveInstanceMethod:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([29 x i8], [29 x i8]* @OBJC_METH_VAR_NAME_.26, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.33, i32 0, i32 0), i8* bitcast (i8* (i8*, i8*, i8*)* @"\01+[SQPerson forwardingTargetForSelector:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([28 x i8], [28 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.33, i32 0, i32 0), i8* bitcast (%2* (i8*, i8*, i8*)* @"\01+[SQPerson methodSignatureForSelector:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @OBJC_METH_VAR_NAME_.34, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.35, i32 0, i32 0), i8* bitcast (void (i8*, i8*, %3*)* @"\01+[SQPerson forwardInvocation:]" to i8*) }] }, section "__DATA, __objc_const", align 8
@OBJC_CLASS_NAME_.36 = private unnamed_addr constant [9 x i8] c"NSCoding\00", section "__TEXT,__objc_classname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.37 = private unnamed_addr constant [17 x i8] c"encodeWithCoder:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.38 = private unnamed_addr constant [15 x i8] c"initWithCoder:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.39 = private unnamed_addr constant [11 x i8] c"@24@0:8@16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"_OBJC_$_PROTOCOL_INSTANCE_METHODS_NSCoding" = internal global { i32, i32, [2 x %struct._objc_method] } { i32 24, i32 2, [2 x %struct._objc_method] [%struct._objc_method { i8* getelementptr inbounds ([17 x i8], [17 x i8]* @OBJC_METH_VAR_NAME_.37, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.35, i32 0, i32 0), i8* null }, %struct._objc_method { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @OBJC_METH_VAR_NAME_.38, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.39, i32 0, i32 0), i8* null }] }, section "__DATA, __objc_const", align 8
@OBJC_METH_VAR_TYPE_.40 = private unnamed_addr constant [20 x i8] c"v24@0:8@\22NSCoder\2216\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.41 = private unnamed_addr constant [20 x i8] c"@24@0:8@\22NSCoder\2216\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"_OBJC_$_PROTOCOL_METHOD_TYPES_NSCoding" = internal global [2 x i8*] [i8* getelementptr inbounds ([20 x i8], [20 x i8]* @OBJC_METH_VAR_TYPE_.40, i32 0, i32 0), i8* getelementptr inbounds ([20 x i8], [20 x i8]* @OBJC_METH_VAR_TYPE_.41, i32 0, i32 0)], section "__DATA, __objc_const", align 8
@"_OBJC_PROTOCOL_$_NSCoding" = weak hidden global %struct._protocol_t { i8* null, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_CLASS_NAME_.36, i32 0, i32 0), %struct._objc_protocol_list* null, %struct.__method_list_t* bitcast ({ i32, i32, [2 x %struct._objc_method] }* @"_OBJC_$_PROTOCOL_INSTANCE_METHODS_NSCoding" to %struct.__method_list_t*), %struct.__method_list_t* null, %struct.__method_list_t* null, %struct.__method_list_t* null, %struct._prop_list_t* null, i32 96, i32 0, i8** getelementptr inbounds ([2 x i8*], [2 x i8*]* @"_OBJC_$_PROTOCOL_METHOD_TYPES_NSCoding", i32 0, i32 0), i8* null, %struct._prop_list_t* null }, align 8
@"_OBJC_LABEL_PROTOCOL_$_NSCoding" = weak hidden global %struct._protocol_t* @"_OBJC_PROTOCOL_$_NSCoding", section "__DATA,__objc_protolist,coalesced,no_dead_strip", align 8
@"_OBJC_CLASS_PROTOCOLS_$_SQPerson" = internal global { i64, [2 x %struct._protocol_t*] } { i64 1, [2 x %struct._protocol_t*] [%struct._protocol_t* @"_OBJC_PROTOCOL_$_NSCoding", %struct._protocol_t* null] }, section "__DATA, __objc_const", align 8
@"_OBJC_METACLASS_RO_$_SQPerson" = internal global %struct._class_ro_t { i32 1, i32 40, i32 40, i8* null, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), %struct.__method_list_t* bitcast ({ i32, i32, [4 x %struct._objc_method] }* @"_OBJC_$_CLASS_METHODS_SQPerson" to %struct.__method_list_t*), %struct._objc_protocol_list* bitcast ({ i64, [2 x %struct._protocol_t*] }* @"_OBJC_CLASS_PROTOCOLS_$_SQPerson" to %struct._objc_protocol_list*), %struct._ivar_list_t* null, i8* null, %struct._prop_list_t* null }, section "__DATA, __objc_const", align 8
@"OBJC_CLASS_$_NSObject" = external global %struct._class_t
@OBJC_METH_VAR_NAME_.42 = private unnamed_addr constant [6 x i8] c"print\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.43 = private unnamed_addr constant [8 x i8] c"v16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.44 = private unnamed_addr constant [4 x i8] c"run\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.45 = private unnamed_addr constant [6 x i8] c"other\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.46 = private unnamed_addr constant [13 x i8] c"test:height:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.47 = private unnamed_addr constant [14 x i8] c"i24@0:8i16f20\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.48 = private unnamed_addr constant [11 x i8] c"personTest\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.49 = private unnamed_addr constant [12 x i8] c"personTest2\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.50 = private unnamed_addr constant [12 x i8] c"personTest3\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.51 = private unnamed_addr constant [9 x i8] c"setTall:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.52 = private unnamed_addr constant [11 x i8] c"v20@0:8c16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.53 = private unnamed_addr constant [7 x i8] c"isTall\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.54 = private unnamed_addr constant [8 x i8] c"c16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.55 = private unnamed_addr constant [9 x i8] c"setRich:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.56 = private unnamed_addr constant [7 x i8] c"isRich\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.57 = private unnamed_addr constant [13 x i8] c"setHandsome:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.58 = private unnamed_addr constant [11 x i8] c"isHandsome\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.59 = private unnamed_addr constant [9 x i8] c"setThin:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.60 = private unnamed_addr constant [7 x i8] c"isThin\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.61 = private unnamed_addr constant [8 x i8] c"@16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.62 = private unnamed_addr constant [9 x i8] c"setName:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.63 = private unnamed_addr constant [8 x i8] c"i16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.64 = private unnamed_addr constant [11 x i8] c"v20@0:8i16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.65 = private unnamed_addr constant [7 x i8] c"height\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.66 = private unnamed_addr constant [8 x i8] c"d16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.67 = private unnamed_addr constant [11 x i8] c"setHeight:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.68 = private unnamed_addr constant [11 x i8] c"v24@0:8d16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"_OBJC_$_INSTANCE_METHODS_SQPerson" = internal global { i32, i32, [27 x %struct._objc_method] } { i32 24, i32 27, [27 x %struct._objc_method] [%struct._objc_method { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.42, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.43, i32 0, i32 0), i8* bitcast (void (%0*, i8*)* @"\01-[SQPerson print]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([28 x i8], [28 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.33, i32 0, i32 0), i8* bitcast (%2* (%0*, i8*, i8*)* @"\01-[SQPerson methodSignatureForSelector:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @OBJC_METH_VAR_NAME_.34, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.35, i32 0, i32 0), i8* bitcast (void (%0*, i8*, %3*)* @"\01-[SQPerson forwardInvocation:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_METH_VAR_NAME_.44, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.43, i32 0, i32 0), i8* bitcast (void (%0*, i8*)* @"\01-[SQPerson run]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.23, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.43, i32 0, i32 0), i8* bitcast (void (%0*, i8*)* @"\01-[SQPerson test]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([29 x i8], [29 x i8]* @OBJC_METH_VAR_NAME_.26, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.33, i32 0, i32 0), i8* bitcast (i8* (%0*, i8*, i8*)* @"\01-[SQPerson forwardingTargetForSelector:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.45, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.43, i32 0, i32 0), i8* bitcast (void (%0*, i8*)* @"\01-[SQPerson other]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @OBJC_METH_VAR_NAME_.46, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @OBJC_METH_VAR_TYPE_.47, i32 0, i32 0), i8* bitcast (i32 (%0*, i8*, i32, float)* @"\01-[SQPerson test:height:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.48, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.43, i32 0, i32 0), i8* bitcast (void (%0*, i8*)* @"\01-[SQPerson personTest]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_.49, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.43, i32 0, i32 0), i8* bitcast (void (%0*, i8*)* @"\01-[SQPerson personTest2]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_.50, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.43, i32 0, i32 0), i8* bitcast (void (%0*, i8*)* @"\01-[SQPerson personTest3]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.51, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.52, i32 0, i32 0), i8* bitcast (void (%0*, i8*, i8)* @"\01-[SQPerson setTall:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.53, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.54, i32 0, i32 0), i8* bitcast (i8 (%0*, i8*)* @"\01-[SQPerson isTall]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.55, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.52, i32 0, i32 0), i8* bitcast (void (%0*, i8*, i8)* @"\01-[SQPerson setRich:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.56, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.54, i32 0, i32 0), i8* bitcast (i8 (%0*, i8*)* @"\01-[SQPerson isRich]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @OBJC_METH_VAR_NAME_.57, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.52, i32 0, i32 0), i8* bitcast (void (%0*, i8*, i8)* @"\01-[SQPerson setHandsome:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.58, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.54, i32 0, i32 0), i8* bitcast (i8 (%0*, i8*)* @"\01-[SQPerson isHandsome]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.59, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.52, i32 0, i32 0), i8* bitcast (void (%0*, i8*, i8)* @"\01-[SQPerson setThin:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.60, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.54, i32 0, i32 0), i8* bitcast (i8 (%0*, i8*)* @"\01-[SQPerson isThin]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([17 x i8], [17 x i8]* @OBJC_METH_VAR_NAME_.37, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.35, i32 0, i32 0), i8* bitcast (void (%0*, i8*, %5*)* @"\01-[SQPerson encodeWithCoder:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([15 x i8], [15 x i8]* @OBJC_METH_VAR_NAME_.38, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.39, i32 0, i32 0), i8* bitcast (i8* (%0*, i8*, %5*)* @"\01-[SQPerson initWithCoder:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.61, i32 0, i32 0), i8* bitcast (%1* (%0*, i8*)* @"\01-[SQPerson name]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.62, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.35, i32 0, i32 0), i8* bitcast (void (%0*, i8*, %1*)* @"\01-[SQPerson setName:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_METH_VAR_NAME_.17, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.63, i32 0, i32 0), i8* bitcast (i32 (%0*, i8*)* @"\01-[SQPerson age]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_NAME_.14, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.64, i32 0, i32 0), i8* bitcast (void (%0*, i8*, i32)* @"\01-[SQPerson setAge:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.65, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.66, i32 0, i32 0), i8* bitcast (double (%0*, i8*)* @"\01-[SQPerson height]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.67, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.68, i32 0, i32 0), i8* bitcast (void (%0*, i8*, double)* @"\01-[SQPerson setHeight:]" to i8*) }] }, section "__DATA, __objc_const", align 8
@"OBJC_IVAR_$_SQPerson._tallRichHandsome" = hidden constant i64 8, section "__DATA, __objc_ivar", align 8
@OBJC_METH_VAR_NAME_.69 = private unnamed_addr constant [18 x i8] c"_tallRichHandsome\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.70 = private unnamed_addr constant [54 x i8] c"(?=\22bits\22c\22\22{?=\22tall\22b1\22rich\22b1\22handsome\22b1\22thin\22b1})\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"OBJC_IVAR_$_SQPerson._age" = hidden constant i64 12, section "__DATA, __objc_ivar", align 8
@OBJC_METH_VAR_NAME_.71 = private unnamed_addr constant [5 x i8] c"_age\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.72 = private unnamed_addr constant [2 x i8] c"i\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"OBJC_IVAR_$_SQPerson._name" = hidden constant i64 16, section "__DATA, __objc_ivar", align 8
@OBJC_METH_VAR_NAME_.73 = private unnamed_addr constant [6 x i8] c"_name\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.74 = private unnamed_addr constant [12 x i8] c"@\22NSString\22\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"OBJC_IVAR_$_SQPerson._height" = hidden constant i64 24, section "__DATA, __objc_ivar", align 8
@OBJC_METH_VAR_NAME_.75 = private unnamed_addr constant [8 x i8] c"_height\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.76 = private unnamed_addr constant [2 x i8] c"d\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"_OBJC_$_INSTANCE_VARIABLES_SQPerson" = internal global { i32, i32, [4 x %struct._ivar_t] } { i32 32, i32 4, [4 x %struct._ivar_t] [%struct._ivar_t { i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", i8* getelementptr inbounds ([18 x i8], [18 x i8]* @OBJC_METH_VAR_NAME_.69, i32 0, i32 0), i8* getelementptr inbounds ([54 x i8], [54 x i8]* @OBJC_METH_VAR_TYPE_.70, i32 0, i32 0), i32 0, i32 1 }, %struct._ivar_t { i64* @"OBJC_IVAR_$_SQPerson._age", i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.71, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @OBJC_METH_VAR_TYPE_.72, i32 0, i32 0), i32 2, i32 4 }, %struct._ivar_t { i64* @"OBJC_IVAR_$_SQPerson._name", i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.73, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_TYPE_.74, i32 0, i32 0), i32 3, i32 8 }, %struct._ivar_t { i64* @"OBJC_IVAR_$_SQPerson._height", i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_NAME_.75, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @OBJC_METH_VAR_TYPE_.76, i32 0, i32 0), i32 3, i32 8 }] }, section "__DATA, __objc_const", align 8
@OBJC_PROP_NAME_ATTR_ = private unnamed_addr constant [5 x i8] c"name\00", section "__TEXT,__cstring,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.77 = private unnamed_addr constant [24 x i8] c"T@\22NSString\22,C,N,V_name\00", section "__TEXT,__cstring,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.78 = private unnamed_addr constant [4 x i8] c"age\00", section "__TEXT,__cstring,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.79 = private unnamed_addr constant [11 x i8] c"Ti,N,V_age\00", section "__TEXT,__cstring,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.80 = private unnamed_addr constant [7 x i8] c"height\00", section "__TEXT,__cstring,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.81 = private unnamed_addr constant [14 x i8] c"Td,N,V_height\00", section "__TEXT,__cstring,cstring_literals", align 1
@"_OBJC_$_PROP_LIST_SQPerson" = internal global { i32, i32, [3 x %struct._prop_t] } { i32 16, i32 3, [3 x %struct._prop_t] [%struct._prop_t { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_PROP_NAME_ATTR_, i32 0, i32 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @OBJC_PROP_NAME_ATTR_.77, i32 0, i32 0) }, %struct._prop_t { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_PROP_NAME_ATTR_.78, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_PROP_NAME_ATTR_.79, i32 0, i32 0) }, %struct._prop_t { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_PROP_NAME_ATTR_.80, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @OBJC_PROP_NAME_ATTR_.81, i32 0, i32 0) }] }, section "__DATA, __objc_const", align 8
@"_OBJC_CLASS_RO_$_SQPerson" = internal global %struct._class_ro_t { i32 0, i32 8, i32 32, i8* null, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), %struct.__method_list_t* bitcast ({ i32, i32, [27 x %struct._objc_method] }* @"_OBJC_$_INSTANCE_METHODS_SQPerson" to %struct.__method_list_t*), %struct._objc_protocol_list* bitcast ({ i64, [2 x %struct._protocol_t*] }* @"_OBJC_CLASS_PROTOCOLS_$_SQPerson" to %struct._objc_protocol_list*), %struct._ivar_list_t* bitcast ({ i32, i32, [4 x %struct._ivar_t] }* @"_OBJC_$_INSTANCE_VARIABLES_SQPerson" to %struct._ivar_list_t*), i8* null, %struct._prop_list_t* bitcast ({ i32, i32, [3 x %struct._prop_t] }* @"_OBJC_$_PROP_LIST_SQPerson" to %struct._prop_list_t*) }, section "__DATA, __objc_const", align 8
@"OBJC_LABEL_CLASS_$" = private global [1 x i8*] [i8* bitcast (%struct._class_t* @"OBJC_CLASS_$_SQPerson" to i8*)], section "__DATA,__objc_classlist,regular,no_dead_strip", align 8
@llvm.used = appending global [2 x i8*] [i8* bitcast (%struct._protocol_t* @"_OBJC_PROTOCOL_$_NSCoding" to i8*), i8* bitcast (%struct._protocol_t** @"_OBJC_LABEL_PROTOCOL_$_NSCoding" to i8*)], section "llvm.metadata"
@llvm.compiler.used = appending global [85 x i8*] [i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_ to i8*), i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_" to i8*), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.2 to i8*), i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_" to i8*), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @OBJC_METH_VAR_NAME_.4, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.5 to i8*), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.8, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.9 to i8*), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_NAME_.14, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.15 to i8*), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_METH_VAR_NAME_.17, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.18 to i8*), i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_.20" to i8*), i8* getelementptr inbounds ([20 x i8], [20 x i8]* @OBJC_METH_VAR_NAME_.21, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.22 to i8*), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.23, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.24 to i8*), i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_.25" to i8*), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @OBJC_METH_VAR_NAME_.26, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.27 to i8*), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.30, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.31 to i8*), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @OBJC_METH_VAR_NAME_.32, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.33, i32 0, i32 0), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @OBJC_METH_VAR_NAME_.34, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.35, i32 0, i32 0), i8* bitcast ({ i32, i32, [4 x %struct._objc_method] }* @"_OBJC_$_CLASS_METHODS_SQPerson" to i8*), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_CLASS_NAME_.36, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @OBJC_METH_VAR_NAME_.37, i32 0, i32 0), i8* getelementptr inbounds ([15 x i8], [15 x i8]* @OBJC_METH_VAR_NAME_.38, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.39, i32 0, i32 0), i8* bitcast ({ i32, i32, [2 x %struct._objc_method] }* @"_OBJC_$_PROTOCOL_INSTANCE_METHODS_NSCoding" to i8*), i8* getelementptr inbounds ([20 x i8], [20 x i8]* @OBJC_METH_VAR_TYPE_.40, i32 0, i32 0), i8* getelementptr inbounds ([20 x i8], [20 x i8]* @OBJC_METH_VAR_TYPE_.41, i32 0, i32 0), i8* bitcast ([2 x i8*]* @"_OBJC_$_PROTOCOL_METHOD_TYPES_NSCoding" to i8*), i8* bitcast ({ i64, [2 x %struct._protocol_t*] }* @"_OBJC_CLASS_PROTOCOLS_$_SQPerson" to i8*), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.42, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.43, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_METH_VAR_NAME_.44, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.45, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @OBJC_METH_VAR_NAME_.46, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @OBJC_METH_VAR_TYPE_.47, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.48, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_.49, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_.50, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.51, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.52, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.53, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.54, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.55, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.56, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @OBJC_METH_VAR_NAME_.57, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.58, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.59, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.60, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.61, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.62, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.63, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.64, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.65, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.66, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.67, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.68, i32 0, i32 0), i8* bitcast ({ i32, i32, [27 x %struct._objc_method] }* @"_OBJC_$_INSTANCE_METHODS_SQPerson" to i8*), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @OBJC_METH_VAR_NAME_.69, i32 0, i32 0), i8* getelementptr inbounds ([54 x i8], [54 x i8]* @OBJC_METH_VAR_TYPE_.70, i32 0, i32 0), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.71, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @OBJC_METH_VAR_TYPE_.72, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.73, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_TYPE_.74, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_NAME_.75, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @OBJC_METH_VAR_TYPE_.76, i32 0, i32 0), i8* bitcast ({ i32, i32, [4 x %struct._ivar_t] }* @"_OBJC_$_INSTANCE_VARIABLES_SQPerson" to i8*), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_PROP_NAME_ATTR_, i32 0, i32 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @OBJC_PROP_NAME_ATTR_.77, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_PROP_NAME_ATTR_.78, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_PROP_NAME_ATTR_.79, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_PROP_NAME_ATTR_.80, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @OBJC_PROP_NAME_ATTR_.81, i32 0, i32 0), i8* bitcast ({ i32, i32, [3 x %struct._prop_t] }* @"_OBJC_$_PROP_LIST_SQPerson" to i8*), i8* bitcast ([1 x i8*]* @"OBJC_LABEL_CLASS_$" to i8*)], section "llvm.metadata"
; Function Attrs: noinline nounwind optnone ssp uwtable
define void @test(i32 %0) #1 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson print]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %0*, %0** %3, align 8
  %6 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_, align 8, !invariant.load !9
  %7 = bitcast %0* %5 to i8*
  %8 = call %1* bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to %1* (i8*, i8*)*)(i8* %7, i8* %6)
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_ to i8*), %1* %8)
  ret void
}
declare void @NSLog(i8*, ...) #3
; Function Attrs: nonlazybind
declare i8* @objc_msgSend(i8*, i8*, ...) #4
; Function Attrs: noinline optnone ssp uwtable
define internal %2* @"\01-[SQPerson methodSignatureForSelector:]"(%0* %0, i8* %1, i8* %2) #2 {
  %4 = alloca %2*, align 8
  %5 = alloca %0*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct._objc_super, align 8
  store %0* %0, %0** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load %0*, %0** %5, align 8
  %10 = load i8*, i8** %7, align 8
  %11 = bitcast %0* %9 to i8*
  %12 = call i8 @objc_opt_respondsToSelector(i8* %11, i8* %10)
  %13 = icmp ne i8 %12, 0
  br i1 %13, label %14, label %24

14:                                               ; preds = %3
  %15 = load %0*, %0** %5, align 8
  %16 = load i8*, i8** %7, align 8
  %17 = bitcast %0* %15 to i8*
  %18 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 0
  store i8* %17, i8** %18, align 8
  %19 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_", align 8
  %20 = bitcast %struct._class_t* %19 to i8*
  %21 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 1
  store i8* %20, i8** %21, align 8
  %22 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.2, align 8, !invariant.load !9
  %23 = call %2* bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to %2* (%struct._objc_super*, i8*, i8*)*)(%struct._objc_super* %8, i8* %22, i8* %16)
  store %2* %23, %2** %4, align 8
  br label %29

24:                                               ; preds = %3
  %25 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_", align 8
  %26 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.5, align 8, !invariant.load !9
  %27 = bitcast %struct._class_t* %25 to i8*
  %28 = call %2* bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to %2* (i8*, i8*, i8*)*)(i8* %27, i8* %26, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0))
  store %2* %28, %2** %4, align 8
  br label %29

29:                                               ; preds = %24, %14
  %30 = load %2*, %2** %4, align 8
  ret %2* %30
}
declare i8 @objc_opt_respondsToSelector(i8*, i8*)
declare i8* @objc_msgSendSuper2(%struct._objc_super*, i8*, ...)
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson forwardInvocation:]"(%0* %0, i8* %1, %3* %2) #2 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %3*, align 8
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store %3* %2, %3** %6, align 8
  %7 = load %3*, %3** %6, align 8
  %8 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.9, align 8, !invariant.load !9
  %9 = bitcast %3* %7 to i8*
  %10 = call i8* bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to i8* (i8*, i8*)*)(i8* %9, i8* %8)
  %11 = call %1* @NSStringFromSelector(i8* %10)
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.7 to i8*), %1* %11)
  ret void
}
declare %1* @NSStringFromSelector(i8*) #3
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson run]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.11 to i8*), i8* getelementptr inbounds ([16 x i8], [16 x i8]* @"__func__.-[SQPerson run]", i64 0, i64 0))
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson test]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.11 to i8*), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @"__func__.-[SQPerson test]", i64 0, i64 0))
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define void @setAge(i8* %0, i8* %1, i32 %2) #5 {
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  store i8* %0, i8** %4, align 8
  store i8* %1, i8** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load i32, i32* %6, align 4
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.13 to i8*), i32 %7)
  ret void
}
; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @age() #1 {
  ret i32 120
}
; Function Attrs: noinline optnone ssp uwtable
define internal signext i8 @"\01+[SQPerson resolveInstanceMethod:]"(i8* %0, i8* %1, i8* %2) #2 {
  %4 = alloca i8, align 1
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct._objc_super, align 8
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load i8*, i8** %7, align 8
  %10 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.15, align 8, !invariant.load !9
  %11 = icmp eq i8* %9, %10
  br i1 %11, label %12, label %16

12:                                               ; preds = %3
  %13 = load i8*, i8** %5, align 8
  %14 = load i8*, i8** %7, align 8
  %15 = call signext i8 @class_addMethod(i8* %13, i8* %14, void ()* bitcast (void (i8*, i8*, i32)* @setAge to void ()*), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.16, i64 0, i64 0))
  store i8 1, i8* %4, align 1
  br label %34

16:                                               ; preds = %3
  %17 = load i8*, i8** %7, align 8
  %18 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.18, align 8, !invariant.load !9
  %19 = icmp eq i8* %17, %18
  br i1 %19, label %20, label %24

20:                                               ; preds = %16
  %21 = load i8*, i8** %5, align 8
  %22 = load i8*, i8** %7, align 8
  %23 = call signext i8 @class_addMethod(i8* %21, i8* %22, void ()* bitcast (i32 ()* @age to void ()*), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.19, i64 0, i64 0))
  store i8 1, i8* %4, align 1
  br label %34

24:                                               ; preds = %16
  br label %25

25:                                               ; preds = %24
  %26 = load i8*, i8** %5, align 8
  %27 = load i8*, i8** %7, align 8
  %28 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 0
  store i8* %26, i8** %28, align 8
  %29 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_.20", align 8
  %30 = bitcast %struct._class_t* %29 to i8*
  %31 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 1
  store i8* %30, i8** %31, align 8
  %32 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.22, align 8, !invariant.load !9
  %33 = call signext i8 bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to i8 (%struct._objc_super*, i8*, i8*)*)(%struct._objc_super* %8, i8* %32, i8* %27)
  store i8 %33, i8* %4, align 1
  br label %34

34:                                               ; preds = %25, %20, %12
  %35 = load i8, i8* %4, align 1
  ret i8 %35
}
declare signext i8 @class_addMethod(i8*, i8*, void ()*, i8*) #3
; Function Attrs: noinline optnone ssp uwtable
define internal i8* @"\01+[SQPerson forwardingTargetForSelector:]"(i8* %0, i8* %1, i8* %2) #2 {
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct._objc_super, align 8
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load i8*, i8** %7, align 8
  %10 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.24, align 8, !invariant.load !9
  %11 = icmp eq i8* %9, %10
  br i1 %11, label %12, label %18

12:                                               ; preds = %3
  %13 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_.25", align 8
  %14 = bitcast %struct._class_t* %13 to i8*
  %15 = call i8* @objc_alloc_init(i8* %14)
  %16 = bitcast i8* %15 to %4*
  %17 = bitcast %4* %16 to i8*
  store i8* %17, i8** %4, align 8
  br label %27

18:                                               ; preds = %3
  %19 = load i8*, i8** %5, align 8
  %20 = load i8*, i8** %7, align 8
  %21 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 0
  store i8* %19, i8** %21, align 8
  %22 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_.20", align 8
  %23 = bitcast %struct._class_t* %22 to i8*
  %24 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 1
  store i8* %23, i8** %24, align 8
  %25 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.27, align 8, !invariant.load !9
  %26 = call i8* bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to i8* (%struct._objc_super*, i8*, i8*)*)(%struct._objc_super* %8, i8* %25, i8* %20)
  store i8* %26, i8** %4, align 8
  br label %27

27:                                               ; preds = %18, %12
  %28 = load i8*, i8** %4, align 8
  ret i8* %28
}
declare i8* @objc_alloc_init(i8*)
; Function Attrs: noinline optnone ssp uwtable
define internal %2* @"\01+[SQPerson methodSignatureForSelector:]"(i8* %0, i8* %1, i8* %2) #2 {
  %4 = alloca %2*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct._objc_super, align 8
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load i8*, i8** %7, align 8
  %10 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.24, align 8, !invariant.load !9
  %11 = icmp eq i8* %9, %10
  br i1 %11, label %12, label %17

12:                                               ; preds = %3
  %13 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_", align 8
  %14 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.5, align 8, !invariant.load !9
  %15 = bitcast %struct._class_t* %13 to i8*
  %16 = call %2* bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to %2* (i8*, i8*, i8*)*)(i8* %15, i8* %14, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.3, i64 0, i64 0))
  store %2* %16, %2** %4, align 8
  br label %26

17:                                               ; preds = %3
  %18 = load i8*, i8** %5, align 8
  %19 = load i8*, i8** %7, align 8
  %20 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 0
  store i8* %18, i8** %20, align 8
  %21 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_.20", align 8
  %22 = bitcast %struct._class_t* %21 to i8*
  %23 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 1
  store i8* %22, i8** %23, align 8
  %24 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.2, align 8, !invariant.load !9
  %25 = call %2* bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to %2* (%struct._objc_super*, i8*, i8*)*)(%struct._objc_super* %8, i8* %24, i8* %19)
  store %2* %25, %2** %4, align 8
  br label %26

26:                                               ; preds = %17, %12
  %27 = load %2*, %2** %4, align 8
  ret %2* %27
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01+[SQPerson forwardInvocation:]"(i8* %0, i8* %1, %3* %2) #2 {
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %3*, align 8
  store i8* %0, i8** %4, align 8
  store i8* %1, i8** %5, align 8
  store %3* %2, %3** %6, align 8
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.11 to i8*), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @"__func__.+[SQPerson forwardInvocation:]", i64 0, i64 0))
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal i8* @"\01-[SQPerson forwardingTargetForSelector:]"(%0* %0, i8* %1, i8* %2) #2 {
  %4 = alloca i8*, align 8
  %5 = alloca %0*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct._objc_super, align 8
  store %0* %0, %0** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load i8*, i8** %7, align 8
  %10 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.24, align 8, !invariant.load !9
  %11 = icmp eq i8* %9, %10
  br i1 %11, label %12, label %13

12:                                               ; preds = %3
  store i8* null, i8** %4, align 8
  br label %23

13:                                               ; preds = %3
  %14 = load %0*, %0** %5, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast %0* %14 to i8*
  %17 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 0
  store i8* %16, i8** %17, align 8
  %18 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_", align 8
  %19 = bitcast %struct._class_t* %18 to i8*
  %20 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 1
  store i8* %19, i8** %20, align 8
  %21 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.27, align 8, !invariant.load !9
  %22 = call i8* bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to i8* (%struct._objc_super*, i8*, i8*)*)(%struct._objc_super* %8, i8* %21, i8* %15)
  store i8* %22, i8** %4, align 8
  br label %23

23:                                               ; preds = %13, %12
  %24 = load i8*, i8** %4, align 8
  ret i8* %24
}
; Function Attrs: noinline optnone ssp uwtable
define void @c_other(i8* %0, i8* %1) #5 {
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load i8*, i8** %3, align 8
  %6 = load i8*, i8** %4, align 8
  %7 = call %1* @NSStringFromSelector(i8* %6)
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.29 to i8*), i8* %5, %1* %7)
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson other]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.11 to i8*), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @"__func__.-[SQPerson other]", i64 0, i64 0))
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal i32 @"\01-[SQPerson test:height:]"(%0* %0, i8* %1, i32 %2, float %3) #2 {
  %5 = alloca %0*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i32, align 4
  %8 = alloca float, align 4
  store %0* %0, %0** %5, align 8
  store i8* %1, i8** %6, align 8
  store i32 %2, i32* %7, align 4
  store float %3, float* %8, align 4
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.11 to i8*), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @"__func__.-[SQPerson test:height:]", i64 0, i64 0))
  ret i32 0
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson personTest]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.11 to i8*), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @"__func__.-[SQPerson personTest]", i64 0, i64 0))
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson personTest2]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson personTest3]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setTall:]"(%0* %0, i8* %1, i8 signext %2) #2 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8 %2, i8* %6, align 1
  %7 = load i8, i8* %6, align 1
  %8 = icmp ne i8 %7, 0
  br i1 %8, label %9, label %19

9:                                                ; preds = %3
  %10 = load %0*, %0** %4, align 8
  %11 = bitcast %0* %10 to i8*
  %12 = getelementptr inbounds i8, i8* %11, i64 8
  %13 = bitcast i8* %12 to %union.anon*
  %14 = bitcast %union.anon* %13 to i8*
  %15 = load i8, i8* %14, align 1
  %16 = sext i8 %15 to i32
  %17 = or i32 %16, 1
  %18 = trunc i32 %17 to i8
  store i8 %18, i8* %14, align 1
  br label %29

19:                                               ; preds = %3
  %20 = load %0*, %0** %4, align 8
  %21 = bitcast %0* %20 to i8*
  %22 = getelementptr inbounds i8, i8* %21, i64 8
  %23 = bitcast i8* %22 to %union.anon*
  %24 = bitcast %union.anon* %23 to i8*
  %25 = load i8, i8* %24, align 1
  %26 = sext i8 %25 to i32
  %27 = and i32 %26, -2
  %28 = trunc i32 %27 to i8
  store i8 %28, i8* %24, align 1
  br label %29

29:                                               ; preds = %19, %9
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal signext i8 @"\01-[SQPerson isTall]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %0*, %0** %3, align 8
  %6 = bitcast %0* %5 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 8
  %8 = bitcast i8* %7 to %union.anon*
  %9 = bitcast %union.anon* %8 to i8*
  %10 = load i8, i8* %9, align 1
  %11 = sext i8 %10 to i32
  %12 = and i32 %11, 1
  %13 = icmp ne i32 %12, 0
  %14 = xor i1 %13, true
  %15 = xor i1 %14, true
  %16 = zext i1 %15 to i32
  %17 = trunc i32 %16 to i8
  ret i8 %17
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setRich:]"(%0* %0, i8* %1, i8 signext %2) #2 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8 %2, i8* %6, align 1
  %7 = load i8, i8* %6, align 1
  %8 = icmp ne i8 %7, 0
  br i1 %8, label %9, label %19

9:                                                ; preds = %3
  %10 = load %0*, %0** %4, align 8
  %11 = bitcast %0* %10 to i8*
  %12 = getelementptr inbounds i8, i8* %11, i64 8
  %13 = bitcast i8* %12 to %union.anon*
  %14 = bitcast %union.anon* %13 to i8*
  %15 = load i8, i8* %14, align 1
  %16 = sext i8 %15 to i32
  %17 = or i32 %16, 2
  %18 = trunc i32 %17 to i8
  store i8 %18, i8* %14, align 1
  br label %29

19:                                               ; preds = %3
  %20 = load %0*, %0** %4, align 8
  %21 = bitcast %0* %20 to i8*
  %22 = getelementptr inbounds i8, i8* %21, i64 8
  %23 = bitcast i8* %22 to %union.anon*
  %24 = bitcast %union.anon* %23 to i8*
  %25 = load i8, i8* %24, align 1
  %26 = sext i8 %25 to i32
  %27 = and i32 %26, -3
  %28 = trunc i32 %27 to i8
  store i8 %28, i8* %24, align 1
  br label %29

29:                                               ; preds = %19, %9
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal signext i8 @"\01-[SQPerson isRich]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %0*, %0** %3, align 8
  %6 = bitcast %0* %5 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 8
  %8 = bitcast i8* %7 to %union.anon*
  %9 = bitcast %union.anon* %8 to i8*
  %10 = load i8, i8* %9, align 1
  %11 = sext i8 %10 to i32
  %12 = and i32 %11, 2
  %13 = icmp ne i32 %12, 0
  %14 = xor i1 %13, true
  %15 = xor i1 %14, true
  %16 = zext i1 %15 to i32
  %17 = trunc i32 %16 to i8
  ret i8 %17
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setHandsome:]"(%0* %0, i8* %1, i8 signext %2) #2 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8 %2, i8* %6, align 1
  %7 = load i8, i8* %6, align 1
  %8 = icmp ne i8 %7, 0
  br i1 %8, label %9, label %19

9:                                                ; preds = %3
  %10 = load %0*, %0** %4, align 8
  %11 = bitcast %0* %10 to i8*
  %12 = getelementptr inbounds i8, i8* %11, i64 8
  %13 = bitcast i8* %12 to %union.anon*
  %14 = bitcast %union.anon* %13 to i8*
  %15 = load i8, i8* %14, align 1
  %16 = sext i8 %15 to i32
  %17 = or i32 %16, 4
  %18 = trunc i32 %17 to i8
  store i8 %18, i8* %14, align 1
  br label %29

19:                                               ; preds = %3
  %20 = load %0*, %0** %4, align 8
  %21 = bitcast %0* %20 to i8*
  %22 = getelementptr inbounds i8, i8* %21, i64 8
  %23 = bitcast i8* %22 to %union.anon*
  %24 = bitcast %union.anon* %23 to i8*
  %25 = load i8, i8* %24, align 1
  %26 = sext i8 %25 to i32
  %27 = and i32 %26, -5
  %28 = trunc i32 %27 to i8
  store i8 %28, i8* %24, align 1
  br label %29

29:                                               ; preds = %19, %9
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal signext i8 @"\01-[SQPerson isHandsome]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %0*, %0** %3, align 8
  %6 = bitcast %0* %5 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 8
  %8 = bitcast i8* %7 to %union.anon*
  %9 = bitcast %union.anon* %8 to i8*
  %10 = load i8, i8* %9, align 1
  %11 = sext i8 %10 to i32
  %12 = and i32 %11, 4
  %13 = icmp ne i32 %12, 0
  %14 = xor i1 %13, true
  %15 = xor i1 %14, true
  %16 = zext i1 %15 to i32
  %17 = trunc i32 %16 to i8
  ret i8 %17
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setThin:]"(%0* %0, i8* %1, i8 signext %2) #2 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8 %2, i8* %6, align 1
  %7 = load i8, i8* %6, align 1
  %8 = icmp ne i8 %7, 0
  br i1 %8, label %9, label %19

9:                                                ; preds = %3
  %10 = load %0*, %0** %4, align 8
  %11 = bitcast %0* %10 to i8*
  %12 = getelementptr inbounds i8, i8* %11, i64 8
  %13 = bitcast i8* %12 to %union.anon*
  %14 = bitcast %union.anon* %13 to i8*
  %15 = load i8, i8* %14, align 1
  %16 = sext i8 %15 to i32
  %17 = or i32 %16, 8
  %18 = trunc i32 %17 to i8
  store i8 %18, i8* %14, align 1
  br label %29

19:                                               ; preds = %3
  %20 = load %0*, %0** %4, align 8
  %21 = bitcast %0* %20 to i8*
  %22 = getelementptr inbounds i8, i8* %21, i64 8
  %23 = bitcast i8* %22 to %union.anon*
  %24 = bitcast %union.anon* %23 to i8*
  %25 = load i8, i8* %24, align 1
  %26 = sext i8 %25 to i32
  %27 = and i32 %26, -9
  %28 = trunc i32 %27 to i8
  store i8 %28, i8* %24, align 1
  br label %29

29:                                               ; preds = %19, %9
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal signext i8 @"\01-[SQPerson isThin]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %0*, %0** %3, align 8
  %6 = bitcast %0* %5 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 8
  %8 = bitcast i8* %7 to %union.anon*
  %9 = bitcast %union.anon* %8 to i8*
  %10 = load i8, i8* %9, align 1
  %11 = sext i8 %10 to i32
  %12 = and i32 %11, 8
  %13 = icmp ne i32 %12, 0
  %14 = xor i1 %13, true
  %15 = xor i1 %14, true
  %16 = zext i1 %15 to i32
  %17 = trunc i32 %16 to i8
  ret i8 %17
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson encodeWithCoder:]"(%0* %0, i8* %1, %5* %2) #2 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %5*, align 8
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store %5* %2, %5** %6, align 8
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal i8* @"\01-[SQPerson initWithCoder:]"(%0* %0, i8* %1, %5* %2) #2 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %5*, align 8
  %7 = alloca %struct._objc_super, align 8
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store %5* %2, %5** %6, align 8
  %8 = load %0*, %0** %4, align 8
  %9 = bitcast %0* %8 to i8*
  %10 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %7, i32 0, i32 0
  store i8* %9, i8** %10, align 8
  %11 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_", align 8
  %12 = bitcast %struct._class_t* %11 to i8*
  %13 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %7, i32 0, i32 1
  store i8* %12, i8** %13, align 8
  %14 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.31, align 8, !invariant.load !9
  %15 = call i8* bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to i8* (%struct._objc_super*, i8*)*)(%struct._objc_super* %7, i8* %14)
  %16 = bitcast i8* %15 to %0*
  store %0* %16, %0** %4, align 8
  %17 = icmp ne %0* %16, null
  br i1 %17, label %18, label %19

18:                                               ; preds = %3
  br label %19

19:                                               ; preds = %18, %3
  %20 = load %0*, %0** %4, align 8
  %21 = bitcast %0* %20 to i8*
  ret i8* %21
}
; Function Attrs: noinline optnone ssp uwtable
define internal %1* @"\01-[SQPerson name]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load i8*, i8** %4, align 8
  %6 = load %0*, %0** %3, align 8
  %7 = bitcast %0* %6 to i8*
  %8 = tail call i8* @objc_getProperty(i8* %7, i8* %5, i64 16, i1 zeroext false)
  %9 = bitcast i8* %8 to %1*
  ret %1* %9
}
declare i8* @objc_getProperty(i8*, i8*, i64, i1)
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setName:]"(%0* %0, i8* %1, %1* %2) #2 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %1*, align 8
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store %1* %2, %1** %6, align 8
  %7 = load i8*, i8** %5, align 8
  %8 = load %0*, %0** %4, align 8
  %9 = bitcast %0* %8 to i8*
  %10 = load %1*, %1** %6, align 8
  %11 = bitcast %1* %10 to i8*
  call void @objc_setProperty_nonatomic_copy(i8* %9, i8* %7, i8* %11, i64 16)
  ret void
}
declare void @objc_setProperty_nonatomic_copy(i8*, i8*, i8*, i64)
; Function Attrs: noinline optnone ssp uwtable
define internal i32 @"\01-[SQPerson age]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %0*, %0** %3, align 8
  %6 = bitcast %0* %5 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 12
  %8 = bitcast i8* %7 to i32*
  %9 = load i32, i32* %8, align 4
  ret i32 %9
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setAge:]"(%0* %0, i8* %1, i32 %2) #2 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load i32, i32* %6, align 4
  %8 = load %0*, %0** %4, align 8
  %9 = bitcast %0* %8 to i8*
  %10 = getelementptr inbounds i8, i8* %9, i64 12
  %11 = bitcast i8* %10 to i32*
  store i32 %7, i32* %11, align 4
  ret void
}
; Function Attrs: noinline optnone ssp uwtable
define internal double @"\01-[SQPerson height]"(%0* %0, i8* %1) #2 {
  %3 = alloca %0*, align 8
  %4 = alloca i8*, align 8
  store %0* %0, %0** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %0*, %0** %3, align 8
  %6 = bitcast %0* %5 to i8*
  %7 = getelementptr inbounds i8, i8* %6, i64 24
  %8 = bitcast i8* %7 to double*
  %9 = load double, double* %8, align 8
  ret double %9
}
; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setHeight:]"(%0* %0, i8* %1, double %2) #2 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca double, align 8
  store %0* %0, %0** %4, align 8
  store i8* %1, i8** %5, align 8
  store double %2, double* %6, align 8
  %7 = load double, double* %6, align 8
  %8 = load %0*, %0** %4, align 8
  %9 = bitcast %0* %8 to i8*
  %10 = getelementptr inbounds i8, i8* %9, i64 24
  %11 = bitcast i8* %10 to double*
  store double %7, double* %11, align 8
  ret void
}

attributes #0 = { "objc_arc_inert" }
attributes #1 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nonlazybind }
attributes #5 = { noinline optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7}
!llvm.ident = !{!8}

!0 = !{i32 2, !"SDK Version", [3 x i32] [i32 10, i32 15, i32 6]}
!1 = !{i32 1, !"Objective-C Version", i32 2}
!2 = !{i32 1, !"Objective-C Image Info Version", i32 0}
!3 = !{i32 1, !"Objective-C Image Info Section", !"__DATA,__objc_imageinfo,regular,no_dead_strip"}
!4 = !{i32 4, !"Objective-C Garbage Collection", i32 0}
!5 = !{i32 1, !"Objective-C Class Properties", i32 64}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = !{i32 7, !"PIC Level", i32 2}
!8 = !{!"Apple clang version 12.0.0 (clang-1200.0.32.2)"}
!9 = !{}
