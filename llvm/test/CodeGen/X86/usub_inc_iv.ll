; NOTE: Assertions have been autogenerated by utils/update_test_checks.py
; RUN: opt -mtriple=x86_64-linux -codegenprepare -S < %s | FileCheck %s

define i32 @test_01(i32* %p, i64 %len, i32 %x) {
; CHECK-LABEL: @test_01(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[MATH:%.*]], [[BACKEDGE:%.*]] ], [ [[LEN:%.*]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 [[IV]], i64 1)
; CHECK-NEXT:    [[MATH]] = extractvalue { i64, i1 } [[TMP0]], 0
; CHECK-NEXT:    [[OV:%.*]] = extractvalue { i64, i1 } [[TMP0]], 1
; CHECK-NEXT:    br i1 [[OV]], label [[EXIT:%.*]], label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[SUNKADDR:%.*]] = mul i64 [[MATH]], 4
; CHECK-NEXT:    [[SUNKADDR1:%.*]] = getelementptr i8, ptr [[P:%.*]], i64 [[SUNKADDR]]
; CHECK-NEXT:    [[LOADED:%.*]] = load atomic i32, ptr [[SUNKADDR1]] unordered, align 4
; CHECK-NEXT:    [[COND_2:%.*]] = icmp eq i32 [[LOADED]], [[X:%.*]]
; CHECK-NEXT:    br i1 [[COND_2]], label [[FAILURE:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 -1
; CHECK:       failure:
; CHECK-NEXT:    unreachable
;
entry:
  %scevgep = getelementptr i32, i32* %p, i64 -1
  br label %loop

loop:                                             ; preds = %backedge, %entry
  %iv = phi i64 [ %iv.next, %backedge ], [ %len, %entry ]
  %iv.next = add i64 %iv, -1
  %cond_1 = icmp eq i64 %iv, 0
  br i1 %cond_1, label %exit, label %backedge

backedge:                                         ; preds = %loop
  %scevgep1 = getelementptr i32, i32* %scevgep, i64 %iv
  %loaded = load atomic i32, i32* %scevgep1 unordered, align 4
  %cond_2 = icmp eq i32 %loaded, %x
  br i1 %cond_2, label %failure, label %loop

exit:                                             ; preds = %loop
  ret i32 -1

failure:                                          ; preds = %backedge
  unreachable
}

; Similar to test_01, but with different offset.
define i32 @test_01a(i32* %p, i64 %len, i32 %x) {
; CHECK-LABEL: @test_01a(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[MATH:%.*]], [[BACKEDGE:%.*]] ], [ [[LEN:%.*]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 [[IV]], i64 1)
; CHECK-NEXT:    [[MATH]] = extractvalue { i64, i1 } [[TMP0]], 0
; CHECK-NEXT:    [[OV:%.*]] = extractvalue { i64, i1 } [[TMP0]], 1
; CHECK-NEXT:    br i1 [[OV]], label [[EXIT:%.*]], label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[SUNKADDR:%.*]] = mul i64 [[MATH]], 4
; CHECK-NEXT:    [[SUNKADDR1:%.*]] = getelementptr i8, ptr [[P:%.*]], i64 [[SUNKADDR]]
; CHECK-NEXT:    [[SUNKADDR2:%.*]] = getelementptr i8, ptr [[SUNKADDR1]], i64 -24
; CHECK-NEXT:    [[LOADED:%.*]] = load atomic i32, ptr [[SUNKADDR2]] unordered, align 4
; CHECK-NEXT:    [[COND_2:%.*]] = icmp eq i32 [[LOADED]], [[X:%.*]]
; CHECK-NEXT:    br i1 [[COND_2]], label [[FAILURE:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 -1
; CHECK:       failure:
; CHECK-NEXT:    unreachable
;
entry:
  %scevgep = getelementptr i32, i32* %p, i64 -7
  br label %loop

loop:                                             ; preds = %backedge, %entry
  %iv = phi i64 [ %iv.next, %backedge ], [ %len, %entry ]
  %iv.next = add i64 %iv, -1
  %cond_1 = icmp eq i64 %iv, 0
  br i1 %cond_1, label %exit, label %backedge

backedge:                                         ; preds = %loop
  %scevgep1 = getelementptr i32, i32* %scevgep, i64 %iv
  %loaded = load atomic i32, i32* %scevgep1 unordered, align 4
  %cond_2 = icmp eq i32 %loaded, %x
  br i1 %cond_2, label %failure, label %loop

exit:                                             ; preds = %loop
  ret i32 -1

failure:                                          ; preds = %backedge
  unreachable
}

; TODO: We can use trick with usub here.
define i32 @test_02(i32* %p, i64 %len, i32 %x) {
; CHECK-LABEL: @test_02(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[MATH:%.*]], [[BACKEDGE:%.*]] ], [ [[LEN:%.*]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 [[IV]], i64 1)
; CHECK-NEXT:    [[MATH]] = extractvalue { i64, i1 } [[TMP0]], 0
; CHECK-NEXT:    [[OV:%.*]] = extractvalue { i64, i1 } [[TMP0]], 1
; CHECK-NEXT:    br i1 [[OV]], label [[EXIT:%.*]], label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[SUNKADDR:%.*]] = mul i64 [[MATH]], 4
; CHECK-NEXT:    [[SUNKADDR1:%.*]] = getelementptr i8, ptr [[P:%.*]], i64 [[SUNKADDR]]
; CHECK-NEXT:    [[LOADED:%.*]] = load atomic i32, ptr [[SUNKADDR1]] unordered, align 4
; CHECK-NEXT:    [[COND_2:%.*]] = icmp eq i32 [[LOADED]], [[X:%.*]]
; CHECK-NEXT:    br i1 [[COND_2]], label [[FAILURE:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 -1
; CHECK:       failure:
; CHECK-NEXT:    unreachable
;
entry:
  %scevgep = getelementptr i32, i32* %p, i64 -1
  br label %loop

loop:                                             ; preds = %backedge, %entry
  %iv = phi i64 [ %iv.next, %backedge ], [ %len, %entry ]
  %cond_1 = icmp eq i64 %iv, 0
  br i1 %cond_1, label %exit, label %backedge

backedge:                                         ; preds = %loop
  %scevgep1 = getelementptr i32, i32* %scevgep, i64 %iv
  %loaded = load atomic i32, i32* %scevgep1 unordered, align 4
  %cond_2 = icmp eq i32 %loaded, %x
  %iv.next = add i64 %iv, -1
  br i1 %cond_2, label %failure, label %loop

exit:                                             ; preds = %loop
  ret i32 -1

failure:                                          ; preds = %backedge
  unreachable
}

declare i1 @use(i64 %x)
declare i1 @some_cond()

; Make sure we do not move the increment below the point where it is used.
define i32 @test_03_neg(i32* %p, i64 %len, i32 %x) {
; CHECK-LABEL: @test_03_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ], [ [[LEN:%.*]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], -1
; CHECK-NEXT:    [[COND_0:%.*]] = call i1 @use(i64 [[IV_NEXT]])
; CHECK-NEXT:    br i1 [[COND_0]], label [[MIDDLE:%.*]], label [[FAILURE:%.*]]
; CHECK:       middle:
; CHECK-NEXT:    [[COND_1:%.*]] = icmp eq i64 [[IV]], 0
; CHECK-NEXT:    br i1 [[COND_1]], label [[EXIT:%.*]], label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[SUNKADDR:%.*]] = mul i64 [[IV_NEXT]], 4
; CHECK-NEXT:    [[SUNKADDR1:%.*]] = getelementptr i8, ptr [[P:%.*]], i64 [[SUNKADDR]]
; CHECK-NEXT:    [[LOADED:%.*]] = load atomic i32, ptr [[SUNKADDR1]] unordered, align 4
; CHECK-NEXT:    [[COND_2:%.*]] = icmp eq i32 [[LOADED]], [[X:%.*]]
; CHECK-NEXT:    br i1 [[COND_2]], label [[FAILURE]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 -1
; CHECK:       failure:
; CHECK-NEXT:    unreachable
;
entry:
  %scevgep = getelementptr i32, i32* %p, i64 -1
  br label %loop

loop:                                             ; preds = %backedge, %entry
  %iv = phi i64 [ %iv.next, %backedge ], [ %len, %entry ]
  %iv.next = add i64 %iv, -1
  %cond_0 = call i1 @use(i64 %iv.next)
  br i1 %cond_0, label %middle, label %failure

middle:
  %cond_1 = icmp eq i64 %iv, 0
  br i1 %cond_1, label %exit, label %backedge

backedge:                                         ; preds = %loop
  %scevgep1 = getelementptr i32, i32* %scevgep, i64 %iv
  %loaded = load atomic i32, i32* %scevgep1 unordered, align 4
  %cond_2 = icmp eq i32 %loaded, %x
  br i1 %cond_2, label %failure, label %loop

exit:                                             ; preds = %loop
  ret i32 -1

failure:                                          ; preds = %backedge
  unreachable
}

define i32 @test_04_neg(i32* %p, i64 %len, i32 %x) {
; CHECK-LABEL: @test_04_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ], [ [[LEN:%.*]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    br label [[INNER:%.*]]
; CHECK:       inner:
; CHECK-NEXT:    [[COND_1:%.*]] = icmp eq i64 [[IV]], 0
; CHECK-NEXT:    br i1 [[COND_1]], label [[INNER_BACKEDGE:%.*]], label [[EXIT:%.*]]
; CHECK:       inner_backedge:
; CHECK-NEXT:    [[COND_INNER:%.*]] = call i1 @some_cond()
; CHECK-NEXT:    br i1 [[COND_INNER]], label [[INNER]], label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[SUNKADDR:%.*]] = mul i64 [[IV]], 4
; CHECK-NEXT:    [[SUNKADDR1:%.*]] = getelementptr i8, ptr [[P:%.*]], i64 [[SUNKADDR]]
; CHECK-NEXT:    [[SUNKADDR2:%.*]] = getelementptr i8, ptr [[SUNKADDR1]], i64 -4
; CHECK-NEXT:    [[LOADED:%.*]] = load atomic i32, ptr [[SUNKADDR2]] unordered, align 4
; CHECK-NEXT:    [[COND_2:%.*]] = icmp eq i32 [[LOADED]], [[X:%.*]]
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], -1
; CHECK-NEXT:    br i1 [[COND_2]], label [[FAILURE:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 -1
; CHECK:       failure:
; CHECK-NEXT:    unreachable
;
entry:
  %scevgep = getelementptr i32, i32* %p, i64 -1
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %backedge ], [ %len, %entry ]
  br label %inner

inner:
  %cond_1 = icmp eq i64 %iv, 0
  br i1 %cond_1, label %inner_backedge, label %exit

inner_backedge:
  %cond_inner = call i1 @some_cond()
  br i1 %cond_inner, label %inner, label %backedge

backedge:
  %scevgep1 = getelementptr i32, i32* %scevgep, i64 %iv
  %loaded = load atomic i32, i32* %scevgep1 unordered, align 4
  %cond_2 = icmp eq i32 %loaded, %x
  %iv.next = add i64 %iv, -1
  br i1 %cond_2, label %failure, label %loop

exit:
  ret i32 -1

failure:
  unreachable
}

; Here Cmp does not dominate latch.
define i32 @test_05_neg(i32* %p, i64 %len, i32 %x, i1 %cond) {
; CHECK-LABEL: @test_05_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ], [ [[LEN:%.*]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], -1
; CHECK-NEXT:    br i1 [[COND:%.*]], label [[IF_TRUE:%.*]], label [[BACKEDGE]]
; CHECK:       if.true:
; CHECK-NEXT:    [[COND_1:%.*]] = icmp eq i64 [[IV]], 0
; CHECK-NEXT:    br i1 [[COND_1]], label [[EXIT:%.*]], label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[SUNKADDR:%.*]] = mul i64 [[IV_NEXT]], 4
; CHECK-NEXT:    [[SUNKADDR1:%.*]] = getelementptr i8, ptr [[P:%.*]], i64 [[SUNKADDR]]
; CHECK-NEXT:    [[LOADED:%.*]] = load atomic i32, ptr [[SUNKADDR1]] unordered, align 4
; CHECK-NEXT:    [[COND_2:%.*]] = icmp eq i32 [[LOADED]], [[X:%.*]]
; CHECK-NEXT:    br i1 [[COND_2]], label [[FAILURE:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 -1
; CHECK:       failure:
; CHECK-NEXT:    unreachable
;
entry:
  %scevgep = getelementptr i32, i32* %p, i64 -1
  br label %loop

loop:                                             ; preds = %backedge, %entry
  %iv = phi i64 [ %iv.next, %backedge ], [ %len, %entry ]
  %iv.next = add i64 %iv, -1
  br i1 %cond, label %if.true, label %backedge

if.true:
  %cond_1 = icmp eq i64 %iv, 0
  br i1 %cond_1, label %exit, label %backedge

backedge:                                         ; preds = %loop
  %scevgep1 = getelementptr i32, i32* %scevgep, i64 %iv
  %loaded = load atomic i32, i32* %scevgep1 unordered, align 4
  %cond_2 = icmp eq i32 %loaded, %x
  br i1 %cond_2, label %failure, label %loop

exit:                                             ; preds = %loop
  ret i32 -1

failure:                                          ; preds = %backedge
  unreachable
}


; test_01, but with an additional use of %iv.next outside the loop
define i32 @test_06(i32* %p, i64 %len, i32 %x) {
; CHECK-LABEL: @test_06(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[MATH:%.*]], [[BACKEDGE:%.*]] ], [ [[LEN:%.*]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[TMP0:%.*]] = call { i64, i1 } @llvm.usub.with.overflow.i64(i64 [[IV]], i64 1)
; CHECK-NEXT:    [[MATH]] = extractvalue { i64, i1 } [[TMP0]], 0
; CHECK-NEXT:    [[OV:%.*]] = extractvalue { i64, i1 } [[TMP0]], 1
; CHECK-NEXT:    br i1 [[OV]], label [[EXIT:%.*]], label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[SUNKADDR:%.*]] = mul i64 [[MATH]], 4
; CHECK-NEXT:    [[SUNKADDR1:%.*]] = getelementptr i8, ptr [[P:%.*]], i64 [[SUNKADDR]]
; CHECK-NEXT:    [[LOADED:%.*]] = load atomic i32, ptr [[SUNKADDR1]] unordered, align 4
; CHECK-NEXT:    [[COND_2:%.*]] = icmp eq i32 [[LOADED]], [[X:%.*]]
; CHECK-NEXT:    br i1 [[COND_2]], label [[FAILURE:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 -1
; CHECK:       failure:
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i64 [[MATH]] to i32
; CHECK-NEXT:    ret i32 [[TRUNC]]
;
entry:
  %scevgep = getelementptr i32, i32* %p, i64 -1
  br label %loop

loop:                                             ; preds = %backedge, %entry
  %iv = phi i64 [ %iv.next, %backedge ], [ %len, %entry ]
  %cond_1 = icmp eq i64 %iv, 0
  br i1 %cond_1, label %exit, label %backedge

backedge:                                         ; preds = %loop
  %scevgep1 = getelementptr i32, i32* %scevgep, i64 %iv
  %loaded = load atomic i32, i32* %scevgep1 unordered, align 4
  %iv.next = add i64 %iv, -1
  %cond_2 = icmp eq i32 %loaded, %x
  br i1 %cond_2, label %failure, label %loop

exit:
  ret i32 -1

failure:
  %trunc = trunc i64 %iv.next to i32
  ret i32 %trunc
}


; Extra use outside loop which prevents us moving the increment to the cmp
define i32 @test_07_neg(i32* %p, i64 %len, i32 %x) {
; CHECK-LABEL: @test_07_neg(
; CHECK-NEXT:  entry:
; CHECK-NEXT:    br label [[LOOP:%.*]]
; CHECK:       loop:
; CHECK-NEXT:    [[IV:%.*]] = phi i64 [ [[IV_NEXT:%.*]], [[BACKEDGE:%.*]] ], [ [[LEN:%.*]], [[ENTRY:%.*]] ]
; CHECK-NEXT:    [[IV_NEXT]] = add i64 [[IV]], -1
; CHECK-NEXT:    [[SUNKADDR:%.*]] = mul i64 [[IV_NEXT]], 4
; CHECK-NEXT:    [[SUNKADDR1:%.*]] = getelementptr i8, ptr [[P:%.*]], i64 [[SUNKADDR]]
; CHECK-NEXT:    [[LOADED:%.*]] = load atomic i32, ptr [[SUNKADDR1]] unordered, align 4
; CHECK-NEXT:    [[COND_2:%.*]] = icmp eq i32 [[LOADED]], [[X:%.*]]
; CHECK-NEXT:    br i1 [[COND_2]], label [[FAILURE:%.*]], label [[BACKEDGE]]
; CHECK:       backedge:
; CHECK-NEXT:    [[COND_1:%.*]] = icmp eq i64 [[IV]], 0
; CHECK-NEXT:    br i1 [[COND_1]], label [[EXIT:%.*]], label [[LOOP]]
; CHECK:       exit:
; CHECK-NEXT:    ret i32 -1
; CHECK:       failure:
; CHECK-NEXT:    [[TRUNC:%.*]] = trunc i64 [[IV_NEXT]] to i32
; CHECK-NEXT:    ret i32 [[TRUNC]]
;
entry:
  %scevgep = getelementptr i32, i32* %p, i64 -1
  br label %loop

loop:
  %iv = phi i64 [ %iv.next, %backedge ], [ %len, %entry ]
  %iv.next = add i64 %iv, -1
  %scevgep1 = getelementptr i32, i32* %scevgep, i64 %iv
  %loaded = load atomic i32, i32* %scevgep1 unordered, align 4
  %cond_2 = icmp eq i32 %loaded, %x
  br i1 %cond_2, label %failure, label %backedge

backedge:
  %cond_1 = icmp eq i64 %iv, 0
  br i1 %cond_1, label %exit, label %loop

exit:
  ret i32 -1

failure:
  %trunc = trunc i64 %iv.next to i32
  ret i32 %trunc
}
