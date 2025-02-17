; RUN: llc < %s -mcpu=yonah
target datalayout = "e-p:32:32:32-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:32:64-f32:32:32-f64:32:64-v64:64:64-v128:128:128-a0:0:64"
target triple = "i686-apple-darwin8"

declare <4 x float> @llvm.x86.sse.add.ss(<4 x float>, <4 x float>)

define void @test(float* %P) {
entry:
	%and = and <4 x i32> bitcast (<4 x float> shufflevector (<4 x float> undef, <4 x float> undef, <4 x i32> zeroinitializer) to <4 x i32>), < i32 -2147483648, i32 -2147483648, i32 -2147483648, i32 -2147483648 >
	or <4 x i32> zeroinitializer, %and
	bitcast <4 x i32> %0 to <4 x float>		; <<4 x float>>:1 [#uses=1]
	fsub <4 x float> %1, zeroinitializer		; <<4 x float>>:2 [#uses=1]
	fsub <4 x float> shufflevector (<4 x float> undef, <4 x float> undef, <4 x i32> zeroinitializer), %2		; <<4 x float>>:3 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %3, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:4 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %4, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:5 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %5, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:6 [#uses=1]
	shufflevector <4 x float> %6, <4 x float> zeroinitializer, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:7 [#uses=1]
	shufflevector <4 x float> %7, <4 x float> zeroinitializer, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:8 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %8, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:9 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %9, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:10 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %10, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:11 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %11, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:12 [#uses=1]
	shufflevector <4 x float> %12, <4 x float> zeroinitializer, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:13 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %13, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:14 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %14, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:15 [#uses=1]
	shufflevector <4 x float> %15, <4 x float> zeroinitializer, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:16 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %16, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:17 [#uses=1]
	shufflevector <4 x float> %17, <4 x float> zeroinitializer, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:18 [#uses=1]
	shufflevector <4 x float> %18, <4 x float> zeroinitializer, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:19 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %19, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:20 [#uses=1]
	shufflevector <4 x float> %20, <4 x float> zeroinitializer, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:21 [#uses=1]
	shufflevector <4 x float> %21, <4 x float> zeroinitializer, <4 x i32> < i32 0, i32 1, i32 2, i32 7 >		; <<4 x float>>:22 [#uses=1]
	fmul <4 x float> %22, zeroinitializer		; <<4 x float>>:23 [#uses=1]
	shufflevector <4 x float> %23, <4 x float> undef, <4 x i32> < i32 2, i32 2, i32 2, i32 2 >		; <<4 x float>>:24 [#uses=1]
	call <4 x float> @llvm.x86.sse.add.ss( <4 x float> zeroinitializer, <4 x float> %24 )		; <<4 x float>>:25 [#uses=1]
	shufflevector <4 x float> %25, <4 x float> undef, <4 x i32> zeroinitializer		; <<4 x float>>:26 [#uses=1]
	shufflevector <4 x float> %26, <4 x float> zeroinitializer, <4 x i32> zeroinitializer		; <<4 x float>>:27 [#uses=1]
	shufflevector <4 x float> %27, <4 x float> zeroinitializer, <4 x i32> < i32 4, i32 1, i32 6, i32 7 >		; <<4 x float>>:28 [#uses=1]
	fmul <4 x float> zeroinitializer, %28		; <<4 x float>>:29 [#uses=1]
	fadd <4 x float> %29, zeroinitializer		; <<4 x float>>:30 [#uses=1]
	fmul <4 x float> zeroinitializer, %30		; <<4 x float>>:31 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %31, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:32 [#uses=1]
	fmul <4 x float> zeroinitializer, %32		; <<4 x float>>:33 [#uses=1]
	shufflevector <4 x float> %33, <4 x float> zeroinitializer, <4 x i32> zeroinitializer		; <<4 x float>>:34 [#uses=1]
	fmul <4 x float> zeroinitializer, %34		; <<4 x float>>:35 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %35, <4 x i32> < i32 0, i32 1, i32 6, i32 7 >		; <<4 x float>>:36 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %36, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:37 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %37, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:38 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %38, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:39 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %39, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:40 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %40, <4 x i32> < i32 4, i32 1, i32 6, i32 7 >		; <<4 x float>>:41 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %41, <4 x i32> < i32 4, i32 1, i32 6, i32 7 >		; <<4 x float>>:42 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %42, <4 x i32> < i32 4, i32 1, i32 6, i32 7 >		; <<4 x float>>:43 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %43, <4 x i32> < i32 4, i32 1, i32 6, i32 7 >		; <<4 x float>>:44 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %44, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:45 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %45, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:46 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %46, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:47 [#uses=1]
	shufflevector <4 x float> zeroinitializer, <4 x float> %47, <4 x i32> < i32 0, i32 5, i32 6, i32 7 >		; <<4 x float>>:48 [#uses=1]
	shufflevector <4 x float> %48, <4 x float> undef, <4 x i32> < i32 1, i32 1, i32 1, i32 1 >		; <<4 x float>>:49 [#uses=1]
	fadd <4 x float> %49, zeroinitializer		; <<4 x float>>:50 [#uses=1]
	%tmp5845 = extractelement <4 x float> %50, i32 2		; <float> [#uses=1]
	store float %tmp5845, float* %P
	ret void
}
