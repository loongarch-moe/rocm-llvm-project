; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s | FileCheck %s
; RUN: llc -relocation-model=pic < %s | FileCheck %s --check-prefix=PIC

target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@foo = external global i8, align 1, !absolute_symbol !0

define void @bar(i8* %x) {
; CHECK-LABEL: bar:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    testb $foo, (%rdi)
; CHECK-NEXT:    je .LBB0_1
; CHECK-NEXT:  # %bb.2: # %if.then
; CHECK-NEXT:    xorl %eax, %eax
; CHECK-NEXT:    jmp xf@PLT # TAILCALL
; CHECK-NEXT:  .LBB0_1: # %if.end
; CHECK-NEXT:    retq
;
; PIC-LABEL: bar:
; PIC:       # %bb.0: # %entry
; PIC-NEXT:    testb $foo, (%rdi)
; PIC-NEXT:    je .LBB0_1
; PIC-NEXT:  # %bb.2: # %if.then
; PIC-NEXT:    xorl %eax, %eax
; PIC-NEXT:    jmp xf@PLT # TAILCALL
; PIC-NEXT:  .LBB0_1: # %if.end
; PIC-NEXT:    retq
entry:
  %0 = load i8, i8* %x, align 1
  %conv = sext i8 %0 to i32
  %and = and i32 %conv, sext (i8 ptrtoint (i8* @foo to i8) to i32)
  %tobool = icmp eq i32 %and, 0
  br i1 %tobool, label %if.end, label %if.then

if.then:                                          ; preds = %entry
  tail call void (...) @xf()
  br label %if.end

if.end:                                           ; preds = %entry, %if.then
  ret void
}

declare void @xf(...)

!0 = !{i64 0, i64 256}
