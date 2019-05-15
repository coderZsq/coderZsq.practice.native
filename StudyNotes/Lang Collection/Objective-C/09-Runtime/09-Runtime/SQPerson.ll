; ModuleID = 'SQPerson.m'
source_filename = "SQPerson.m"
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.14.0"

%0 = type opaque
%1 = type opaque
%2 = type opaque
%3 = type opaque
%4 = type opaque
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
%struct.__NSConstantString_tag = type { i32*, i32, i8*, i64 }
%struct._objc_super = type { i8*, i8* }
%union.anon = type { i8 }

@"OBJC_CLASS_$_NSMethodSignature" = external global %struct._class_t
@"OBJC_CLASSLIST_REFERENCES_$_" = private global %struct._class_t* @"OBJC_CLASS_$_NSMethodSignature", section "__DATA,__objc_classrefs,regular,no_dead_strip", align 8
@.str = private unnamed_addr constant [4 x i8] c"v@:\00", align 1
@OBJC_METH_VAR_NAME_ = private unnamed_addr constant [24 x i8] c"signatureWithObjCTypes:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_ = private externally_initialized global i8* getelementptr inbounds ([24 x i8], [24 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@"OBJC_CLASS_$_SQPerson" = global %struct._class_t { %struct._class_t* @"OBJC_METACLASS_$_SQPerson", %struct._class_t* @"OBJC_CLASS_$_NSObject", %struct._objc_cache* @_objc_empty_cache, i8* (i8*, i8*)** null, %struct._class_ro_t* @"\01l_OBJC_CLASS_RO_$_SQPerson" }, section "__DATA, __objc_data", align 8
@"OBJC_CLASSLIST_SUP_REFS_$_" = private global %struct._class_t* @"OBJC_CLASS_$_SQPerson", section "__DATA,__objc_superrefs,regular,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.1 = private unnamed_addr constant [19 x i8] c"forwardInvocation:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.2 = private externally_initialized global i8* getelementptr inbounds ([19 x i8], [19 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@__CFConstantStringClassReference = external global [0 x i32]
@.str.3 = private unnamed_addr constant [14 x i8] c"my name is %@\00", section "__TEXT,__cstring,cstring_literals", align 1
@_unnamed_cfstring_ = private global %struct.__NSConstantString_tag { i32* getelementptr inbounds ([0 x i32], [0 x i32]* @__CFConstantStringClassReference, i32 0, i32 0), i32 1992, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.3, i32 0, i32 0), i64 13 }, section "__DATA,__cfstring", align 8
@OBJC_METH_VAR_NAME_.4 = private unnamed_addr constant [5 x i8] c"name\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.5 = private externally_initialized global i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.4, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@.str.6 = private unnamed_addr constant [10 x i8] c"age is %d\00", section "__TEXT,__cstring,cstring_literals", align 1
@_unnamed_cfstring_.7 = private global %struct.__NSConstantString_tag { i32* getelementptr inbounds ([0 x i32], [0 x i32]* @__CFConstantStringClassReference, i32 0, i32 0), i32 1992, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.6, i32 0, i32 0), i64 9 }, section "__DATA,__cfstring", align 8
@OBJC_METH_VAR_NAME_.8 = private unnamed_addr constant [8 x i8] c"setAge:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.9 = private externally_initialized global i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_NAME_.8, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@.str.10 = private unnamed_addr constant [5 x i8] c"v@:i\00", align 1
@OBJC_METH_VAR_NAME_.11 = private unnamed_addr constant [4 x i8] c"age\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.12 = private externally_initialized global i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_METH_VAR_NAME_.11, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@.str.13 = private unnamed_addr constant [4 x i8] c"i@:\00", align 1
@"OBJC_METACLASS_$_SQPerson" = global %struct._class_t { %struct._class_t* @"OBJC_METACLASS_$_NSObject", %struct._class_t* @"OBJC_METACLASS_$_NSObject", %struct._objc_cache* @_objc_empty_cache, i8* (i8*, i8*)** null, %struct._class_ro_t* @"\01l_OBJC_METACLASS_RO_$_SQPerson" }, section "__DATA, __objc_data", align 8
@"OBJC_CLASSLIST_SUP_REFS_$_.14" = private global %struct._class_t* @"OBJC_METACLASS_$_SQPerson", section "__DATA,__objc_superrefs,regular,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.15 = private unnamed_addr constant [20 x i8] c"resolveClassMethod:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.16 = private externally_initialized global i8* getelementptr inbounds ([20 x i8], [20 x i8]* @OBJC_METH_VAR_NAME_.15, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.17 = private unnamed_addr constant [5 x i8] c"test\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.18 = private externally_initialized global i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.17, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@"OBJC_CLASS_$_SQCat" = external global %struct._class_t
@"OBJC_CLASSLIST_REFERENCES_$_.19" = private global %struct._class_t* @"OBJC_CLASS_$_SQCat", section "__DATA,__objc_classrefs,regular,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.20 = private unnamed_addr constant [6 x i8] c"alloc\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.21 = private externally_initialized global i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.20, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.22 = private unnamed_addr constant [5 x i8] c"init\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.23 = private externally_initialized global i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.22, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.24 = private unnamed_addr constant [29 x i8] c"forwardingTargetForSelector:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.25 = private externally_initialized global i8* getelementptr inbounds ([29 x i8], [29 x i8]* @OBJC_METH_VAR_NAME_.24, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@OBJC_METH_VAR_NAME_.26 = private unnamed_addr constant [28 x i8] c"methodSignatureForSelector:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_SELECTOR_REFERENCES_.27 = private externally_initialized global i8* getelementptr inbounds ([28 x i8], [28 x i8]* @OBJC_METH_VAR_NAME_.26, i32 0, i32 0), section "__DATA,__objc_selrefs,literal_pointers,no_dead_strip", align 8
@.str.28 = private unnamed_addr constant [3 x i8] c"%s\00", section "__TEXT,__cstring,cstring_literals", align 1
@_unnamed_cfstring_.29 = private global %struct.__NSConstantString_tag { i32* getelementptr inbounds ([0 x i32], [0 x i32]* @__CFConstantStringClassReference, i32 0, i32 0), i32 1992, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.28, i32 0, i32 0), i64 2 }, section "__DATA,__cfstring", align 8
@"__func__.+[SQPerson forwardInvocation:]" = private unnamed_addr constant [31 x i8] c"+[SQPerson forwardInvocation:]\00", align 1
@.str.30 = private unnamed_addr constant [18 x i8] c"c_other - %@ - %@\00", section "__TEXT,__cstring,cstring_literals", align 1
@_unnamed_cfstring_.31 = private global %struct.__NSConstantString_tag { i32* getelementptr inbounds ([0 x i32], [0 x i32]* @__CFConstantStringClassReference, i32 0, i32 0), i32 1992, i8* getelementptr inbounds ([18 x i8], [18 x i8]* @.str.30, i32 0, i32 0), i64 17 }, section "__DATA,__cfstring", align 8
@"__func__.-[SQPerson other]" = private unnamed_addr constant [18 x i8] c"-[SQPerson other]\00", align 1
@"__func__.-[SQPerson test:height:]" = private unnamed_addr constant [25 x i8] c"-[SQPerson test:height:]\00", align 1
@"__func__.-[SQPerson personTest]" = private unnamed_addr constant [23 x i8] c"-[SQPerson personTest]\00", align 1
@"OBJC_IVAR_$_SQPerson._tallRichHandsome" = hidden global i64 8, section "__DATA, __objc_ivar", align 8
@"OBJC_IVAR_$_SQPerson._name" = hidden global i64 16, section "__DATA, __objc_ivar", align 8
@"OBJC_IVAR_$_SQPerson._height" = hidden global i64 24, section "__DATA, __objc_ivar", align 8
@_objc_empty_cache = external global %struct._objc_cache
@"OBJC_METACLASS_$_NSObject" = external global %struct._class_t
@OBJC_CLASS_NAME_ = private unnamed_addr constant [9 x i8] c"SQPerson\00", section "__TEXT,__objc_classname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.32 = private unnamed_addr constant [23 x i8] c"resolveInstanceMethod:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_ = private unnamed_addr constant [11 x i8] c"c24@0:8:16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.33 = private unnamed_addr constant [11 x i8] c"@24@0:8:16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.34 = private unnamed_addr constant [11 x i8] c"v24@0:8@16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"\01l_OBJC_$_CLASS_METHODS_SQPerson" = private global { i32, i32, [4 x %struct._objc_method] } { i32 24, i32 4, [4 x %struct._objc_method] [%struct._objc_method { i8* getelementptr inbounds ([23 x i8], [23 x i8]* @OBJC_METH_VAR_NAME_.32, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_, i32 0, i32 0), i8* bitcast (i8 (i8*, i8*, i8*)* @"\01+[SQPerson resolveInstanceMethod:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([29 x i8], [29 x i8]* @OBJC_METH_VAR_NAME_.24, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.33, i32 0, i32 0), i8* bitcast (i8* (i8*, i8*, i8*)* @"\01+[SQPerson forwardingTargetForSelector:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([28 x i8], [28 x i8]* @OBJC_METH_VAR_NAME_.26, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.33, i32 0, i32 0), i8* bitcast (%0* (i8*, i8*, i8*)* @"\01+[SQPerson methodSignatureForSelector:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.34, i32 0, i32 0), i8* bitcast (void (i8*, i8*, %2*)* @"\01+[SQPerson forwardInvocation:]" to i8*) }] }, section "__DATA, __objc_const", align 8
@"\01l_OBJC_METACLASS_RO_$_SQPerson" = private global %struct._class_ro_t { i32 1, i32 40, i32 40, i8* null, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), %struct.__method_list_t* bitcast ({ i32, i32, [4 x %struct._objc_method] }* @"\01l_OBJC_$_CLASS_METHODS_SQPerson" to %struct.__method_list_t*), %struct._objc_protocol_list* null, %struct._ivar_list_t* null, i8* null, %struct._prop_list_t* null }, section "__DATA, __objc_const", align 8
@"OBJC_CLASS_$_NSObject" = external global %struct._class_t
@OBJC_METH_VAR_NAME_.35 = private unnamed_addr constant [6 x i8] c"print\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.36 = private unnamed_addr constant [8 x i8] c"v16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.37 = private unnamed_addr constant [6 x i8] c"other\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.38 = private unnamed_addr constant [13 x i8] c"test:height:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.39 = private unnamed_addr constant [14 x i8] c"i24@0:8i16f20\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.40 = private unnamed_addr constant [11 x i8] c"personTest\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.41 = private unnamed_addr constant [12 x i8] c"personTest2\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.42 = private unnamed_addr constant [12 x i8] c"personTest3\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.43 = private unnamed_addr constant [9 x i8] c"setTall:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.44 = private unnamed_addr constant [11 x i8] c"v20@0:8c16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.45 = private unnamed_addr constant [7 x i8] c"isTall\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.46 = private unnamed_addr constant [8 x i8] c"c16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.47 = private unnamed_addr constant [9 x i8] c"setRich:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.48 = private unnamed_addr constant [7 x i8] c"isRich\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.49 = private unnamed_addr constant [13 x i8] c"setHandsome:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.50 = private unnamed_addr constant [11 x i8] c"isHandsome\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.51 = private unnamed_addr constant [9 x i8] c"setThin:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.52 = private unnamed_addr constant [7 x i8] c"isThin\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.53 = private unnamed_addr constant [8 x i8] c"@16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.54 = private unnamed_addr constant [9 x i8] c"setName:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.55 = private unnamed_addr constant [7 x i8] c"height\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.56 = private unnamed_addr constant [8 x i8] c"d16@0:8\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.57 = private unnamed_addr constant [11 x i8] c"setHeight:\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.58 = private unnamed_addr constant [11 x i8] c"v24@0:8d16\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"\01l_OBJC_$_INSTANCE_METHODS_SQPerson" = private global { i32, i32, [21 x %struct._objc_method] } { i32 24, i32 21, [21 x %struct._objc_method] [%struct._objc_method { i8* getelementptr inbounds ([28 x i8], [28 x i8]* @OBJC_METH_VAR_NAME_.26, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.33, i32 0, i32 0), i8* bitcast (%0* (%1*, i8*, i8*)* @"\01-[SQPerson methodSignatureForSelector:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([19 x i8], [19 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.34, i32 0, i32 0), i8* bitcast (void (%1*, i8*, %2*)* @"\01-[SQPerson forwardInvocation:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.35, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.36, i32 0, i32 0), i8* bitcast (void (%1*, i8*)* @"\01-[SQPerson print]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([29 x i8], [29 x i8]* @OBJC_METH_VAR_NAME_.24, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.33, i32 0, i32 0), i8* bitcast (i8* (%1*, i8*, i8*)* @"\01-[SQPerson forwardingTargetForSelector:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.37, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.36, i32 0, i32 0), i8* bitcast (void (%1*, i8*)* @"\01-[SQPerson other]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @OBJC_METH_VAR_NAME_.38, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @OBJC_METH_VAR_TYPE_.39, i32 0, i32 0), i8* bitcast (i32 (%1*, i8*, i32, float)* @"\01-[SQPerson test:height:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.40, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.36, i32 0, i32 0), i8* bitcast (void (%1*, i8*)* @"\01-[SQPerson personTest]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_.41, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.36, i32 0, i32 0), i8* bitcast (void (%1*, i8*)* @"\01-[SQPerson personTest2]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_.42, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.36, i32 0, i32 0), i8* bitcast (void (%1*, i8*)* @"\01-[SQPerson personTest3]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.43, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.44, i32 0, i32 0), i8* bitcast (void (%1*, i8*, i8)* @"\01-[SQPerson setTall:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.45, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.46, i32 0, i32 0), i8* bitcast (i8 (%1*, i8*)* @"\01-[SQPerson isTall]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.47, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.44, i32 0, i32 0), i8* bitcast (void (%1*, i8*, i8)* @"\01-[SQPerson setRich:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.48, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.46, i32 0, i32 0), i8* bitcast (i8 (%1*, i8*)* @"\01-[SQPerson isRich]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([13 x i8], [13 x i8]* @OBJC_METH_VAR_NAME_.49, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.44, i32 0, i32 0), i8* bitcast (void (%1*, i8*, i8)* @"\01-[SQPerson setHandsome:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.50, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.46, i32 0, i32 0), i8* bitcast (i8 (%1*, i8*)* @"\01-[SQPerson isHandsome]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.51, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.44, i32 0, i32 0), i8* bitcast (void (%1*, i8*, i8)* @"\01-[SQPerson setThin:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.52, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.46, i32 0, i32 0), i8* bitcast (i8 (%1*, i8*)* @"\01-[SQPerson isThin]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.4, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.53, i32 0, i32 0), i8* bitcast (%3* (%1*, i8*)* @"\01-[SQPerson name]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.54, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.34, i32 0, i32 0), i8* bitcast (void (%1*, i8*, %3*)* @"\01-[SQPerson setName:]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.55, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.56, i32 0, i32 0), i8* bitcast (double (%1*, i8*)* @"\01-[SQPerson height]" to i8*) }, %struct._objc_method { i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.57, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.58, i32 0, i32 0), i8* bitcast (void (%1*, i8*, double)* @"\01-[SQPerson setHeight:]" to i8*) }] }, section "__DATA, __objc_const", align 8
@OBJC_METH_VAR_NAME_.59 = private unnamed_addr constant [18 x i8] c"_tallRichHandsome\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.60 = private unnamed_addr constant [54 x i8] c"(?=\22bits\22c\22\22{?=\22tall\22b1\22rich\22b1\22handsome\22b1\22thin\22b1})\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.61 = private unnamed_addr constant [6 x i8] c"_name\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.62 = private unnamed_addr constant [12 x i8] c"@\22NSString\22\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@OBJC_METH_VAR_NAME_.63 = private unnamed_addr constant [8 x i8] c"_height\00", section "__TEXT,__objc_methname,cstring_literals", align 1
@OBJC_METH_VAR_TYPE_.64 = private unnamed_addr constant [2 x i8] c"d\00", section "__TEXT,__objc_methtype,cstring_literals", align 1
@"\01l_OBJC_$_INSTANCE_VARIABLES_SQPerson" = private global { i32, i32, [3 x %struct._ivar_t] } { i32 32, i32 3, [3 x %struct._ivar_t] [%struct._ivar_t { i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", i8* getelementptr inbounds ([18 x i8], [18 x i8]* @OBJC_METH_VAR_NAME_.59, i32 0, i32 0), i8* getelementptr inbounds ([54 x i8], [54 x i8]* @OBJC_METH_VAR_TYPE_.60, i32 0, i32 0), i32 0, i32 1 }, %struct._ivar_t { i64* @"OBJC_IVAR_$_SQPerson._name", i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.61, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_TYPE_.62, i32 0, i32 0), i32 3, i32 8 }, %struct._ivar_t { i64* @"OBJC_IVAR_$_SQPerson._height", i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_NAME_.63, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @OBJC_METH_VAR_TYPE_.64, i32 0, i32 0), i32 3, i32 8 }] }, section "__DATA, __objc_const", align 8
@OBJC_PROP_NAME_ATTR_ = private unnamed_addr constant [5 x i8] c"name\00", section "__TEXT,__cstring,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.65 = private unnamed_addr constant [24 x i8] c"T@\22NSString\22,C,N,V_name\00", section "__TEXT,__cstring,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.66 = private unnamed_addr constant [4 x i8] c"age\00", section "__TEXT,__cstring,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.67 = private unnamed_addr constant [7 x i8] c"Ti,D,N\00", section "__TEXT,__cstring,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.68 = private unnamed_addr constant [7 x i8] c"height\00", section "__TEXT,__cstring,cstring_literals", align 1
@OBJC_PROP_NAME_ATTR_.69 = private unnamed_addr constant [14 x i8] c"Td,N,V_height\00", section "__TEXT,__cstring,cstring_literals", align 1
@"\01l_OBJC_$_PROP_LIST_SQPerson" = private global { i32, i32, [3 x %struct._prop_t] } { i32 16, i32 3, [3 x %struct._prop_t] [%struct._prop_t { i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_PROP_NAME_ATTR_, i32 0, i32 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @OBJC_PROP_NAME_ATTR_.65, i32 0, i32 0) }, %struct._prop_t { i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_PROP_NAME_ATTR_.66, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_PROP_NAME_ATTR_.67, i32 0, i32 0) }, %struct._prop_t { i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_PROP_NAME_ATTR_.68, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @OBJC_PROP_NAME_ATTR_.69, i32 0, i32 0) }] }, section "__DATA, __objc_const", align 8
@"\01l_OBJC_CLASS_RO_$_SQPerson" = private global %struct._class_ro_t { i32 0, i32 8, i32 32, i8* null, i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), %struct.__method_list_t* bitcast ({ i32, i32, [21 x %struct._objc_method] }* @"\01l_OBJC_$_INSTANCE_METHODS_SQPerson" to %struct.__method_list_t*), %struct._objc_protocol_list* null, %struct._ivar_list_t* bitcast ({ i32, i32, [3 x %struct._ivar_t] }* @"\01l_OBJC_$_INSTANCE_VARIABLES_SQPerson" to %struct._ivar_list_t*), i8* null, %struct._prop_list_t* bitcast ({ i32, i32, [3 x %struct._prop_t] }* @"\01l_OBJC_$_PROP_LIST_SQPerson" to %struct._prop_list_t*) }, section "__DATA, __objc_const", align 8
@"OBJC_LABEL_CLASS_$" = private global [1 x i8*] [i8* bitcast (%struct._class_t* @"OBJC_CLASS_$_SQPerson" to i8*)], section "__DATA,__objc_classlist,regular,no_dead_strip", align 8
@llvm.compiler.used = appending global [72 x i8*] [i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_" to i8*), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @OBJC_METH_VAR_NAME_, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_ to i8*), i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_" to i8*), i8* getelementptr inbounds ([19 x i8], [19 x i8]* @OBJC_METH_VAR_NAME_.1, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.2 to i8*), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.4, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.5 to i8*), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_NAME_.8, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.9 to i8*), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_METH_VAR_NAME_.11, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.12 to i8*), i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_.14" to i8*), i8* getelementptr inbounds ([20 x i8], [20 x i8]* @OBJC_METH_VAR_NAME_.15, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.16 to i8*), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.17, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.18 to i8*), i8* bitcast (%struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_.19" to i8*), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.20, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.21 to i8*), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_METH_VAR_NAME_.22, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.23 to i8*), i8* getelementptr inbounds ([29 x i8], [29 x i8]* @OBJC_METH_VAR_NAME_.24, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.25 to i8*), i8* getelementptr inbounds ([28 x i8], [28 x i8]* @OBJC_METH_VAR_NAME_.26, i32 0, i32 0), i8* bitcast (i8** @OBJC_SELECTOR_REFERENCES_.27 to i8*), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_CLASS_NAME_, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @OBJC_METH_VAR_NAME_.32, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.33, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.34, i32 0, i32 0), i8* bitcast ({ i32, i32, [4 x %struct._objc_method] }* @"\01l_OBJC_$_CLASS_METHODS_SQPerson" to i8*), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.35, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.36, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.37, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @OBJC_METH_VAR_NAME_.38, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @OBJC_METH_VAR_TYPE_.39, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.40, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_.41, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_NAME_.42, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.43, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.44, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.45, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.46, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.47, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.48, i32 0, i32 0), i8* getelementptr inbounds ([13 x i8], [13 x i8]* @OBJC_METH_VAR_NAME_.49, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.50, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.51, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.52, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.53, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8], [9 x i8]* @OBJC_METH_VAR_NAME_.54, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_METH_VAR_NAME_.55, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_TYPE_.56, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_NAME_.57, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8], [11 x i8]* @OBJC_METH_VAR_TYPE_.58, i32 0, i32 0), i8* bitcast ({ i32, i32, [21 x %struct._objc_method] }* @"\01l_OBJC_$_INSTANCE_METHODS_SQPerson" to i8*), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @OBJC_METH_VAR_NAME_.59, i32 0, i32 0), i8* getelementptr inbounds ([54 x i8], [54 x i8]* @OBJC_METH_VAR_TYPE_.60, i32 0, i32 0), i8* getelementptr inbounds ([6 x i8], [6 x i8]* @OBJC_METH_VAR_NAME_.61, i32 0, i32 0), i8* getelementptr inbounds ([12 x i8], [12 x i8]* @OBJC_METH_VAR_TYPE_.62, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8], [8 x i8]* @OBJC_METH_VAR_NAME_.63, i32 0, i32 0), i8* getelementptr inbounds ([2 x i8], [2 x i8]* @OBJC_METH_VAR_TYPE_.64, i32 0, i32 0), i8* bitcast ({ i32, i32, [3 x %struct._ivar_t] }* @"\01l_OBJC_$_INSTANCE_VARIABLES_SQPerson" to i8*), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @OBJC_PROP_NAME_ATTR_, i32 0, i32 0), i8* getelementptr inbounds ([24 x i8], [24 x i8]* @OBJC_PROP_NAME_ATTR_.65, i32 0, i32 0), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @OBJC_PROP_NAME_ATTR_.66, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_PROP_NAME_ATTR_.67, i32 0, i32 0), i8* getelementptr inbounds ([7 x i8], [7 x i8]* @OBJC_PROP_NAME_ATTR_.68, i32 0, i32 0), i8* getelementptr inbounds ([14 x i8], [14 x i8]* @OBJC_PROP_NAME_ATTR_.69, i32 0, i32 0), i8* bitcast ({ i32, i32, [3 x %struct._prop_t] }* @"\01l_OBJC_$_PROP_LIST_SQPerson" to i8*), i8* bitcast ([1 x i8*]* @"OBJC_LABEL_CLASS_$" to i8*)], section "llvm.metadata"

; Function Attrs: noinline nounwind optnone ssp uwtable
define void @test(i32) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal %0* @"\01-[SQPerson methodSignatureForSelector:]"(%1*, i8*, i8*) #1 {
  %4 = alloca %1*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  store %1* %0, %1** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8* %2, i8** %6, align 8
  %7 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_", align 8
  %8 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_, align 8, !invariant.load !9
  %9 = bitcast %struct._class_t* %7 to i8*
  %10 = call %0* bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to %0* (i8*, i8*, i8*)*)(i8* %9, i8* %8, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0))
  ret %0* %10
}

; Function Attrs: nonlazybind
declare i8* @objc_msgSend(i8*, i8*, ...) #2

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson forwardInvocation:]"(%1*, i8*, %2*) #1 {
  %4 = alloca %1*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %2*, align 8
  %7 = alloca %struct._objc_super, align 8
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store %1* %0, %1** %4, align 8
  store i8* %1, i8** %5, align 8
  store %2* %2, %2** %6, align 8
  %11 = load %1*, %1** %4, align 8
  %12 = load %2*, %2** %6, align 8
  %13 = bitcast %1* %11 to i8*
  %14 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %7, i32 0, i32 0
  store i8* %13, i8** %14, align 8
  %15 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_", align 8
  %16 = bitcast %struct._class_t* %15 to i8*
  %17 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %7, i32 0, i32 1
  store i8* %16, i8** %17, align 8
  %18 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.2, align 8, !invariant.load !9
  call void bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to void (%struct._objc_super*, i8*, %2*)*)(%struct._objc_super* %7, i8* %18, %2* %12)
  store i32 10, i32* %8, align 4
  store i32 20, i32* %9, align 4
  %19 = load i32, i32* %8, align 4
  %20 = load i32, i32* %9, align 4
  %21 = add nsw i32 %19, %20
  store i32 %21, i32* %10, align 4
  %22 = load i32, i32* %10, align 4
  call void @test(i32 %22)
  ret void
}

declare i8* @objc_msgSendSuper2(%struct._objc_super*, i8*, ...)

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson print]"(%1*, i8*) #1 {
  %3 = alloca %1*, align 8
  %4 = alloca i8*, align 8
  store %1* %0, %1** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %1*, %1** %3, align 8
  %6 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.5, align 8, !invariant.load !9
  %7 = bitcast %1* %5 to i8*
  %8 = call %3* bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to %3* (i8*, i8*)*)(i8* %7, i8* %6)
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_ to i8*), %3* %8)
  ret void
}

declare void @NSLog(i8*, ...) #3

; Function Attrs: noinline optnone ssp uwtable
define void @setAge(i8*, i8*, i32) #1 {
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  store i8* %0, i8** %4, align 8
  store i8* %1, i8** %5, align 8
  store i32 %2, i32* %6, align 4
  %7 = load i32, i32* %6, align 4
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.7 to i8*), i32 %7)
  ret void
}

; Function Attrs: noinline nounwind optnone ssp uwtable
define i32 @age() #0 {
  ret i32 120
}

; Function Attrs: noinline optnone ssp uwtable
define internal signext i8 @"\01+[SQPerson resolveInstanceMethod:]"(i8*, i8*, i8*) #1 {
  %4 = alloca i8, align 1
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct._objc_super, align 8
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load i8*, i8** %7, align 8
  %10 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.9, align 8, !invariant.load !9
  %11 = icmp eq i8* %9, %10
  br i1 %11, label %12, label %16

; <label>:12:                                     ; preds = %3
  %13 = load i8*, i8** %5, align 8
  %14 = load i8*, i8** %7, align 8
  %15 = call signext i8 @class_addMethod(i8* %13, i8* %14, i8* (i8*, i8*, ...)* bitcast (void (i8*, i8*, i32)* @setAge to i8* (i8*, i8*, ...)*), i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.10, i32 0, i32 0))
  store i8 1, i8* %4, align 1
  br label %34

; <label>:16:                                     ; preds = %3
  %17 = load i8*, i8** %7, align 8
  %18 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.12, align 8, !invariant.load !9
  %19 = icmp eq i8* %17, %18
  br i1 %19, label %20, label %24

; <label>:20:                                     ; preds = %16
  %21 = load i8*, i8** %5, align 8
  %22 = load i8*, i8** %7, align 8
  %23 = call signext i8 @class_addMethod(i8* %21, i8* %22, i8* (i8*, i8*, ...)* bitcast (i32 ()* @age to i8* (i8*, i8*, ...)*), i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.13, i32 0, i32 0))
  store i8 1, i8* %4, align 1
  br label %34

; <label>:24:                                     ; preds = %16
  br label %25

; <label>:25:                                     ; preds = %24
  %26 = load i8*, i8** %5, align 8
  %27 = load i8*, i8** %7, align 8
  %28 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 0
  store i8* %26, i8** %28, align 8
  %29 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_.14", align 8
  %30 = bitcast %struct._class_t* %29 to i8*
  %31 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 1
  store i8* %30, i8** %31, align 8
  %32 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.16, align 8, !invariant.load !9
  %33 = call signext i8 bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to i8 (%struct._objc_super*, i8*, i8*)*)(%struct._objc_super* %8, i8* %32, i8* %27)
  store i8 %33, i8* %4, align 1
  br label %34

; <label>:34:                                     ; preds = %25, %20, %12
  %35 = load i8, i8* %4, align 1
  ret i8 %35
}

declare signext i8 @class_addMethod(i8*, i8*, i8* (i8*, i8*, ...)*, i8*) #3

; Function Attrs: noinline optnone ssp uwtable
define internal i8* @"\01+[SQPerson forwardingTargetForSelector:]"(i8*, i8*, i8*) #1 {
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct._objc_super, align 8
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load i8*, i8** %7, align 8
  %10 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.18, align 8, !invariant.load !9
  %11 = icmp eq i8* %9, %10
  br i1 %11, label %12, label %23

; <label>:12:                                     ; preds = %3
  %13 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_.19", align 8
  %14 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.21, align 8, !invariant.load !9
  %15 = bitcast %struct._class_t* %13 to i8*
  %16 = call i8* bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to i8* (i8*, i8*)*)(i8* %15, i8* %14)
  %17 = bitcast i8* %16 to %4*
  %18 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.23, align 8, !invariant.load !9
  %19 = bitcast %4* %17 to i8*
  %20 = call i8* bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to i8* (i8*, i8*)*)(i8* %19, i8* %18)
  %21 = bitcast i8* %20 to %4*
  %22 = bitcast %4* %21 to i8*
  store i8* %22, i8** %4, align 8
  br label %32

; <label>:23:                                     ; preds = %3
  %24 = load i8*, i8** %5, align 8
  %25 = load i8*, i8** %7, align 8
  %26 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 0
  store i8* %24, i8** %26, align 8
  %27 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_.14", align 8
  %28 = bitcast %struct._class_t* %27 to i8*
  %29 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 1
  store i8* %28, i8** %29, align 8
  %30 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.25, align 8, !invariant.load !9
  %31 = call i8* bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to i8* (%struct._objc_super*, i8*, i8*)*)(%struct._objc_super* %8, i8* %30, i8* %25)
  store i8* %31, i8** %4, align 8
  br label %32

; <label>:32:                                     ; preds = %23, %12
  %33 = load i8*, i8** %4, align 8
  ret i8* %33
}

; Function Attrs: noinline optnone ssp uwtable
define internal %0* @"\01+[SQPerson methodSignatureForSelector:]"(i8*, i8*, i8*) #1 {
  %4 = alloca %0*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct._objc_super, align 8
  store i8* %0, i8** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load i8*, i8** %7, align 8
  %10 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.18, align 8, !invariant.load !9
  %11 = icmp eq i8* %9, %10
  br i1 %11, label %12, label %17

; <label>:12:                                     ; preds = %3
  %13 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_REFERENCES_$_", align 8
  %14 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_, align 8, !invariant.load !9
  %15 = bitcast %struct._class_t* %13 to i8*
  %16 = call %0* bitcast (i8* (i8*, i8*, ...)* @objc_msgSend to %0* (i8*, i8*, i8*)*)(i8* %15, i8* %14, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0))
  store %0* %16, %0** %4, align 8
  br label %26

; <label>:17:                                     ; preds = %3
  %18 = load i8*, i8** %5, align 8
  %19 = load i8*, i8** %7, align 8
  %20 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 0
  store i8* %18, i8** %20, align 8
  %21 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_.14", align 8
  %22 = bitcast %struct._class_t* %21 to i8*
  %23 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 1
  store i8* %22, i8** %23, align 8
  %24 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.27, align 8, !invariant.load !9
  %25 = call %0* bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to %0* (%struct._objc_super*, i8*, i8*)*)(%struct._objc_super* %8, i8* %24, i8* %19)
  store %0* %25, %0** %4, align 8
  br label %26

; <label>:26:                                     ; preds = %17, %12
  %27 = load %0*, %0** %4, align 8
  ret %0* %27
}

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01+[SQPerson forwardInvocation:]"(i8*, i8*, %2*) #1 {
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %2*, align 8
  store i8* %0, i8** %4, align 8
  store i8* %1, i8** %5, align 8
  store %2* %2, %2** %6, align 8
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.29 to i8*), i8* getelementptr inbounds ([31 x i8], [31 x i8]* @"__func__.+[SQPerson forwardInvocation:]", i32 0, i32 0))
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal i8* @"\01-[SQPerson forwardingTargetForSelector:]"(%1*, i8*, i8*) #1 {
  %4 = alloca i8*, align 8
  %5 = alloca %1*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i8*, align 8
  %8 = alloca %struct._objc_super, align 8
  store %1* %0, %1** %5, align 8
  store i8* %1, i8** %6, align 8
  store i8* %2, i8** %7, align 8
  %9 = load i8*, i8** %7, align 8
  %10 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.18, align 8, !invariant.load !9
  %11 = icmp eq i8* %9, %10
  br i1 %11, label %12, label %13

; <label>:12:                                     ; preds = %3
  store i8* null, i8** %4, align 8
  br label %23

; <label>:13:                                     ; preds = %3
  %14 = load %1*, %1** %5, align 8
  %15 = load i8*, i8** %7, align 8
  %16 = bitcast %1* %14 to i8*
  %17 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 0
  store i8* %16, i8** %17, align 8
  %18 = load %struct._class_t*, %struct._class_t** @"OBJC_CLASSLIST_SUP_REFS_$_", align 8
  %19 = bitcast %struct._class_t* %18 to i8*
  %20 = getelementptr inbounds %struct._objc_super, %struct._objc_super* %8, i32 0, i32 1
  store i8* %19, i8** %20, align 8
  %21 = load i8*, i8** @OBJC_SELECTOR_REFERENCES_.25, align 8, !invariant.load !9
  %22 = call i8* bitcast (i8* (%struct._objc_super*, i8*, ...)* @objc_msgSendSuper2 to i8* (%struct._objc_super*, i8*, i8*)*)(%struct._objc_super* %8, i8* %21, i8* %15)
  store i8* %22, i8** %4, align 8
  br label %23

; <label>:23:                                     ; preds = %13, %12
  %24 = load i8*, i8** %4, align 8
  ret i8* %24
}

; Function Attrs: noinline optnone ssp uwtable
define void @c_other(i8*, i8*) #1 {
  %3 = alloca i8*, align 8
  %4 = alloca i8*, align 8
  store i8* %0, i8** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load i8*, i8** %3, align 8
  %6 = load i8*, i8** %4, align 8
  %7 = call %3* @NSStringFromSelector(i8* %6)
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.31 to i8*), i8* %5, %3* %7)
  ret void
}

declare %3* @NSStringFromSelector(i8*) #3

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson other]"(%1*, i8*) #1 {
  %3 = alloca %1*, align 8
  %4 = alloca i8*, align 8
  store %1* %0, %1** %3, align 8
  store i8* %1, i8** %4, align 8
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.29 to i8*), i8* getelementptr inbounds ([18 x i8], [18 x i8]* @"__func__.-[SQPerson other]", i32 0, i32 0))
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal i32 @"\01-[SQPerson test:height:]"(%1*, i8*, i32, float) #1 {
  %5 = alloca %1*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca i32, align 4
  %8 = alloca float, align 4
  store %1* %0, %1** %5, align 8
  store i8* %1, i8** %6, align 8
  store i32 %2, i32* %7, align 4
  store float %3, float* %8, align 4
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.29 to i8*), i8* getelementptr inbounds ([25 x i8], [25 x i8]* @"__func__.-[SQPerson test:height:]", i32 0, i32 0))
  ret i32 0
}

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson personTest]"(%1*, i8*) #1 {
  %3 = alloca %1*, align 8
  %4 = alloca i8*, align 8
  store %1* %0, %1** %3, align 8
  store i8* %1, i8** %4, align 8
  notail call void (i8*, ...) @NSLog(i8* bitcast (%struct.__NSConstantString_tag* @_unnamed_cfstring_.29 to i8*), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @"__func__.-[SQPerson personTest]", i32 0, i32 0))
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson personTest2]"(%1*, i8*) #1 {
  %3 = alloca %1*, align 8
  %4 = alloca i8*, align 8
  store %1* %0, %1** %3, align 8
  store i8* %1, i8** %4, align 8
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson personTest3]"(%1*, i8*) #1 {
  %3 = alloca %1*, align 8
  %4 = alloca i8*, align 8
  store %1* %0, %1** %3, align 8
  store i8* %1, i8** %4, align 8
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setTall:]"(%1*, i8*, i8 signext) #1 {
  %4 = alloca %1*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  store %1* %0, %1** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8 %2, i8* %6, align 1
  %7 = load i8, i8* %6, align 1
  %8 = icmp ne i8 %7, 0
  br i1 %8, label %9, label %20

; <label>:9:                                      ; preds = %3
  %10 = load %1*, %1** %4, align 8
  %11 = load i64, i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", align 8, !invariant.load !9
  %12 = bitcast %1* %10 to i8*
  %13 = getelementptr inbounds i8, i8* %12, i64 %11
  %14 = bitcast i8* %13 to %union.anon*
  %15 = bitcast %union.anon* %14 to i8*
  %16 = load i8, i8* %15, align 1
  %17 = sext i8 %16 to i32
  %18 = or i32 %17, 1
  %19 = trunc i32 %18 to i8
  store i8 %19, i8* %15, align 1
  br label %31

; <label>:20:                                     ; preds = %3
  %21 = load %1*, %1** %4, align 8
  %22 = load i64, i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", align 8, !invariant.load !9
  %23 = bitcast %1* %21 to i8*
  %24 = getelementptr inbounds i8, i8* %23, i64 %22
  %25 = bitcast i8* %24 to %union.anon*
  %26 = bitcast %union.anon* %25 to i8*
  %27 = load i8, i8* %26, align 1
  %28 = sext i8 %27 to i32
  %29 = and i32 %28, -2
  %30 = trunc i32 %29 to i8
  store i8 %30, i8* %26, align 1
  br label %31

; <label>:31:                                     ; preds = %20, %9
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal signext i8 @"\01-[SQPerson isTall]"(%1*, i8*) #1 {
  %3 = alloca %1*, align 8
  %4 = alloca i8*, align 8
  store %1* %0, %1** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %1*, %1** %3, align 8
  %6 = load i64, i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", align 8, !invariant.load !9
  %7 = bitcast %1* %5 to i8*
  %8 = getelementptr inbounds i8, i8* %7, i64 %6
  %9 = bitcast i8* %8 to %union.anon*
  %10 = bitcast %union.anon* %9 to i8*
  %11 = load i8, i8* %10, align 1
  %12 = sext i8 %11 to i32
  %13 = and i32 %12, 1
  %14 = icmp ne i32 %13, 0
  %15 = xor i1 %14, true
  %16 = xor i1 %15, true
  %17 = zext i1 %16 to i32
  %18 = trunc i32 %17 to i8
  ret i8 %18
}

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setRich:]"(%1*, i8*, i8 signext) #1 {
  %4 = alloca %1*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  store %1* %0, %1** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8 %2, i8* %6, align 1
  %7 = load i8, i8* %6, align 1
  %8 = icmp ne i8 %7, 0
  br i1 %8, label %9, label %20

; <label>:9:                                      ; preds = %3
  %10 = load %1*, %1** %4, align 8
  %11 = load i64, i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", align 8, !invariant.load !9
  %12 = bitcast %1* %10 to i8*
  %13 = getelementptr inbounds i8, i8* %12, i64 %11
  %14 = bitcast i8* %13 to %union.anon*
  %15 = bitcast %union.anon* %14 to i8*
  %16 = load i8, i8* %15, align 1
  %17 = sext i8 %16 to i32
  %18 = or i32 %17, 2
  %19 = trunc i32 %18 to i8
  store i8 %19, i8* %15, align 1
  br label %31

; <label>:20:                                     ; preds = %3
  %21 = load %1*, %1** %4, align 8
  %22 = load i64, i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", align 8, !invariant.load !9
  %23 = bitcast %1* %21 to i8*
  %24 = getelementptr inbounds i8, i8* %23, i64 %22
  %25 = bitcast i8* %24 to %union.anon*
  %26 = bitcast %union.anon* %25 to i8*
  %27 = load i8, i8* %26, align 1
  %28 = sext i8 %27 to i32
  %29 = and i32 %28, -3
  %30 = trunc i32 %29 to i8
  store i8 %30, i8* %26, align 1
  br label %31

; <label>:31:                                     ; preds = %20, %9
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal signext i8 @"\01-[SQPerson isRich]"(%1*, i8*) #1 {
  %3 = alloca %1*, align 8
  %4 = alloca i8*, align 8
  store %1* %0, %1** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %1*, %1** %3, align 8
  %6 = load i64, i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", align 8, !invariant.load !9
  %7 = bitcast %1* %5 to i8*
  %8 = getelementptr inbounds i8, i8* %7, i64 %6
  %9 = bitcast i8* %8 to %union.anon*
  %10 = bitcast %union.anon* %9 to i8*
  %11 = load i8, i8* %10, align 1
  %12 = sext i8 %11 to i32
  %13 = and i32 %12, 2
  %14 = icmp ne i32 %13, 0
  %15 = xor i1 %14, true
  %16 = xor i1 %15, true
  %17 = zext i1 %16 to i32
  %18 = trunc i32 %17 to i8
  ret i8 %18
}

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setHandsome:]"(%1*, i8*, i8 signext) #1 {
  %4 = alloca %1*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  store %1* %0, %1** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8 %2, i8* %6, align 1
  %7 = load i8, i8* %6, align 1
  %8 = icmp ne i8 %7, 0
  br i1 %8, label %9, label %20

; <label>:9:                                      ; preds = %3
  %10 = load %1*, %1** %4, align 8
  %11 = load i64, i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", align 8, !invariant.load !9
  %12 = bitcast %1* %10 to i8*
  %13 = getelementptr inbounds i8, i8* %12, i64 %11
  %14 = bitcast i8* %13 to %union.anon*
  %15 = bitcast %union.anon* %14 to i8*
  %16 = load i8, i8* %15, align 1
  %17 = sext i8 %16 to i32
  %18 = or i32 %17, 4
  %19 = trunc i32 %18 to i8
  store i8 %19, i8* %15, align 1
  br label %31

; <label>:20:                                     ; preds = %3
  %21 = load %1*, %1** %4, align 8
  %22 = load i64, i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", align 8, !invariant.load !9
  %23 = bitcast %1* %21 to i8*
  %24 = getelementptr inbounds i8, i8* %23, i64 %22
  %25 = bitcast i8* %24 to %union.anon*
  %26 = bitcast %union.anon* %25 to i8*
  %27 = load i8, i8* %26, align 1
  %28 = sext i8 %27 to i32
  %29 = and i32 %28, -5
  %30 = trunc i32 %29 to i8
  store i8 %30, i8* %26, align 1
  br label %31

; <label>:31:                                     ; preds = %20, %9
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal signext i8 @"\01-[SQPerson isHandsome]"(%1*, i8*) #1 {
  %3 = alloca %1*, align 8
  %4 = alloca i8*, align 8
  store %1* %0, %1** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %1*, %1** %3, align 8
  %6 = load i64, i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", align 8, !invariant.load !9
  %7 = bitcast %1* %5 to i8*
  %8 = getelementptr inbounds i8, i8* %7, i64 %6
  %9 = bitcast i8* %8 to %union.anon*
  %10 = bitcast %union.anon* %9 to i8*
  %11 = load i8, i8* %10, align 1
  %12 = sext i8 %11 to i32
  %13 = and i32 %12, 4
  %14 = icmp ne i32 %13, 0
  %15 = xor i1 %14, true
  %16 = xor i1 %15, true
  %17 = zext i1 %16 to i32
  %18 = trunc i32 %17 to i8
  ret i8 %18
}

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setThin:]"(%1*, i8*, i8 signext) #1 {
  %4 = alloca %1*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i8, align 1
  store %1* %0, %1** %4, align 8
  store i8* %1, i8** %5, align 8
  store i8 %2, i8* %6, align 1
  %7 = load i8, i8* %6, align 1
  %8 = icmp ne i8 %7, 0
  br i1 %8, label %9, label %20

; <label>:9:                                      ; preds = %3
  %10 = load %1*, %1** %4, align 8
  %11 = load i64, i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", align 8, !invariant.load !9
  %12 = bitcast %1* %10 to i8*
  %13 = getelementptr inbounds i8, i8* %12, i64 %11
  %14 = bitcast i8* %13 to %union.anon*
  %15 = bitcast %union.anon* %14 to i8*
  %16 = load i8, i8* %15, align 1
  %17 = sext i8 %16 to i32
  %18 = or i32 %17, 8
  %19 = trunc i32 %18 to i8
  store i8 %19, i8* %15, align 1
  br label %31

; <label>:20:                                     ; preds = %3
  %21 = load %1*, %1** %4, align 8
  %22 = load i64, i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", align 8, !invariant.load !9
  %23 = bitcast %1* %21 to i8*
  %24 = getelementptr inbounds i8, i8* %23, i64 %22
  %25 = bitcast i8* %24 to %union.anon*
  %26 = bitcast %union.anon* %25 to i8*
  %27 = load i8, i8* %26, align 1
  %28 = sext i8 %27 to i32
  %29 = and i32 %28, -9
  %30 = trunc i32 %29 to i8
  store i8 %30, i8* %26, align 1
  br label %31

; <label>:31:                                     ; preds = %20, %9
  ret void
}

; Function Attrs: noinline optnone ssp uwtable
define internal signext i8 @"\01-[SQPerson isThin]"(%1*, i8*) #1 {
  %3 = alloca %1*, align 8
  %4 = alloca i8*, align 8
  store %1* %0, %1** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %1*, %1** %3, align 8
  %6 = load i64, i64* @"OBJC_IVAR_$_SQPerson._tallRichHandsome", align 8, !invariant.load !9
  %7 = bitcast %1* %5 to i8*
  %8 = getelementptr inbounds i8, i8* %7, i64 %6
  %9 = bitcast i8* %8 to %union.anon*
  %10 = bitcast %union.anon* %9 to i8*
  %11 = load i8, i8* %10, align 1
  %12 = sext i8 %11 to i32
  %13 = and i32 %12, 8
  %14 = icmp ne i32 %13, 0
  %15 = xor i1 %14, true
  %16 = xor i1 %15, true
  %17 = zext i1 %16 to i32
  %18 = trunc i32 %17 to i8
  ret i8 %18
}

; Function Attrs: noinline optnone ssp uwtable
define internal %3* @"\01-[SQPerson name]"(%1*, i8*) #1 {
  %3 = alloca %1*, align 8
  %4 = alloca i8*, align 8
  store %1* %0, %1** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load i8*, i8** %4, align 8
  %6 = load %1*, %1** %3, align 8
  %7 = bitcast %1* %6 to i8*
  %8 = load i64, i64* @"OBJC_IVAR_$_SQPerson._name", align 8, !invariant.load !9
  %9 = tail call i8* @objc_getProperty(i8* %7, i8* %5, i64 %8, i1 zeroext false)
  %10 = bitcast i8* %9 to %3*
  ret %3* %10
}

declare i8* @objc_getProperty(i8*, i8*, i64, i1)

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setName:]"(%1*, i8*, %3*) #1 {
  %4 = alloca %1*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca %3*, align 8
  store %1* %0, %1** %4, align 8
  store i8* %1, i8** %5, align 8
  store %3* %2, %3** %6, align 8
  %7 = load i8*, i8** %5, align 8
  %8 = load %1*, %1** %4, align 8
  %9 = bitcast %1* %8 to i8*
  %10 = load i64, i64* @"OBJC_IVAR_$_SQPerson._name", align 8, !invariant.load !9
  %11 = load %3*, %3** %6, align 8
  %12 = bitcast %3* %11 to i8*
  call void @objc_setProperty_nonatomic_copy(i8* %9, i8* %7, i8* %12, i64 %10)
  ret void
}

declare void @objc_setProperty_nonatomic_copy(i8*, i8*, i8*, i64)

; Function Attrs: noinline optnone ssp uwtable
define internal double @"\01-[SQPerson height]"(%1*, i8*) #1 {
  %3 = alloca %1*, align 8
  %4 = alloca i8*, align 8
  store %1* %0, %1** %3, align 8
  store i8* %1, i8** %4, align 8
  %5 = load %1*, %1** %3, align 8
  %6 = load i64, i64* @"OBJC_IVAR_$_SQPerson._height", align 8, !invariant.load !9
  %7 = bitcast %1* %5 to i8*
  %8 = getelementptr inbounds i8, i8* %7, i64 %6
  %9 = bitcast i8* %8 to double*
  %10 = load double, double* %9, align 8
  ret double %10
}

; Function Attrs: noinline optnone ssp uwtable
define internal void @"\01-[SQPerson setHeight:]"(%1*, i8*, double) #1 {
  %4 = alloca %1*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca double, align 8
  store %1* %0, %1** %4, align 8
  store i8* %1, i8** %5, align 8
  store double %2, double* %6, align 8
  %7 = load double, double* %6, align 8
  %8 = load %1*, %1** %4, align 8
  %9 = load i64, i64* @"OBJC_IVAR_$_SQPerson._height", align 8, !invariant.load !9
  %10 = bitcast %1* %8 to i8*
  %11 = getelementptr inbounds i8, i8* %10, i64 %9
  %12 = bitcast i8* %11 to double*
  store double %7, double* %12, align 8
  ret void
}

attributes #0 = { noinline nounwind optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noinline optnone ssp uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nonlazybind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1, !2, !3, !4, !5, !6, !7}
!llvm.ident = !{!8}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 10, i32 14]}
!1 = !{i32 1, !"Objective-C Version", i32 2}
!2 = !{i32 1, !"Objective-C Image Info Version", i32 0}
!3 = !{i32 1, !"Objective-C Image Info Section", !"__DATA,__objc_imageinfo,regular,no_dead_strip"}
!4 = !{i32 4, !"Objective-C Garbage Collection", i32 0}
!5 = !{i32 1, !"Objective-C Class Properties", i32 64}
!6 = !{i32 1, !"wchar_size", i32 4}
!7 = !{i32 7, !"PIC Level", i32 2}
!8 = !{!"Apple LLVM version 10.0.1 (clang-1001.0.46.4)"}
!9 = !{}
