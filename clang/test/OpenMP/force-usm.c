// NOTE: Assertions have been autogenerated by utils/update_cc_test_checks.py UTC_ARGS: --include-generated-funcs --replace-value-regex "__omp_offloading_[0-9a-z]+_[0-9a-z]+" "pl_cond[.].+[.|,]" --prefix-filecheck-ir-name _ --version 3
// REQUIRES: amdgpu-registered-target

// RUN: %clang_cc1 -fopenmp -x c++ -std=c++11 -triple x86_64-unknown-unknown -fopenmp-targets=amdgcn-amd-amdhsa -include %S/../../lib/Headers/openmp_wrappers/usm/force_usm.h -emit-llvm-bc %s -o %t-ppc-host.bc
// RUN: %clang_cc1 -fopenmp -x c++ -std=c++11 -triple amdgcn-amd-amdhsa -fopenmp-targets=amdgcn-amd-amdhsa -emit-llvm %s -include %S/../../lib/Headers/openmp_wrappers/usm/force_usm.h -fopenmp-is-device -fopenmp-host-ir-file-path %t-ppc-host.bc -o - | FileCheck -check-prefix=CHECK-USM %s

// RUN: %clang_cc1 -fopenmp -x c++ -std=c++11 -triple x86_64-unknown-unknown -fopenmp-targets=amdgcn-amd-amdhsa -emit-llvm-bc %s -o %t-ppc-host.bc
// RUN: %clang_cc1 -fopenmp -x c++ -std=c++11 -triple amdgcn-amd-amdhsa -fopenmp-targets=amdgcn-amd-amdhsa -emit-llvm %s -fopenmp-is-device -fopenmp-host-ir-file-path %t-ppc-host.bc -o - | FileCheck -check-prefix=CHECK-DEFAULT %s
// expected-no-diagnostics

extern "C" void *malloc(unsigned int b);

int GI;
#pragma omp declare target
int *pGI;
#pragma omp end declare target

int main(void) {

  GI = 0;

  pGI = (int *) malloc(sizeof(int));
  *pGI = 42;

#pragma omp target map(pGI[:1], GI)
  {
    GI = 1;
    *pGI = 2;
  }

  return 0;
}

// CHECK-USM-LABEL: define weak_odr protected amdgpu_kernel void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l25
// CHECK-USM-SAME: (ptr noundef nonnull align 4 dereferenceable(4) [[GI:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-USM-NEXT:  entry:
// CHECK-USM-NEXT:    [[GI_ADDR:%.*]] = alloca ptr, align 8, addrspace(5)
// CHECK-USM-NEXT:    [[GI_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[GI_ADDR]] to ptr
// CHECK-USM-NEXT:    store ptr [[GI]], ptr [[GI_ADDR_ASCAST]], align 8
// CHECK-USM-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[GI_ADDR_ASCAST]], align 8
// CHECK-USM-NEXT:    [[TMP1:%.*]] = call i32 @__kmpc_target_init(ptr addrspacecast (ptr addrspace(1) @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l25_kernel_environment to ptr))
// CHECK-USM-NEXT:    [[EXEC_USER_CODE:%.*]] = icmp eq i32 [[TMP1]], -1
// CHECK-USM-NEXT:    br i1 [[EXEC_USER_CODE]], label [[USER_CODE_ENTRY:%.*]], label [[WORKER_EXIT:%.*]]
// CHECK-USM:       user_code.entry:
// CHECK-USM-NEXT:    store i32 1, ptr [[TMP0]], align 4
// CHECK-USM-NEXT:    [[TMP2:%.*]] = load ptr, ptr @pGI_decl_tgt_ref_ptr, align 8
// CHECK-USM-NEXT:    [[TMP3:%.*]] = load ptr, ptr [[TMP2]], align 8
// CHECK-USM-NEXT:    store i32 2, ptr [[TMP3]], align 4
// CHECK-USM-NEXT:    call void @__kmpc_target_deinit()
// CHECK-USM-NEXT:    ret void
// CHECK-USM:       worker.exit:
// CHECK-USM-NEXT:    ret void
//
//
// CHECK-DEFAULT-LABEL: define weak_odr protected amdgpu_kernel void @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l25
// CHECK-DEFAULT-SAME: (ptr noundef nonnull align 4 dereferenceable(4) [[GI:%.*]]) #[[ATTR0:[0-9]+]] {
// CHECK-DEFAULT-NEXT:  entry:
// CHECK-DEFAULT-NEXT:    [[GI_ADDR:%.*]] = alloca ptr, align 8, addrspace(5)
// CHECK-DEFAULT-NEXT:    [[GI_ADDR_ASCAST:%.*]] = addrspacecast ptr addrspace(5) [[GI_ADDR]] to ptr
// CHECK-DEFAULT-NEXT:    store ptr [[GI]], ptr [[GI_ADDR_ASCAST]], align 8
// CHECK-DEFAULT-NEXT:    [[TMP0:%.*]] = load ptr, ptr [[GI_ADDR_ASCAST]], align 8
// CHECK-DEFAULT-NEXT:    [[TMP1:%.*]] = call i32 @__kmpc_target_init(ptr addrspacecast (ptr addrspace(1) @{{__omp_offloading_[0-9a-z]+_[0-9a-z]+}}_main_l25_kernel_environment to ptr))
// CHECK-DEFAULT-NEXT:    [[EXEC_USER_CODE:%.*]] = icmp eq i32 [[TMP1]], -1
// CHECK-DEFAULT-NEXT:    br i1 [[EXEC_USER_CODE]], label [[USER_CODE_ENTRY:%.*]], label [[WORKER_EXIT:%.*]]
// CHECK-DEFAULT:       user_code.entry:
// CHECK-DEFAULT-NEXT:    store i32 1, ptr [[TMP0]], align 4
// CHECK-DEFAULT-NEXT:    [[TMP2:%.*]] = load ptr, ptr addrspacecast (ptr addrspace(1) @pGI to ptr), align 8
// CHECK-DEFAULT-NEXT:    store i32 2, ptr [[TMP2]], align 4
// CHECK-DEFAULT-NEXT:    call void @__kmpc_target_deinit()
// CHECK-DEFAULT-NEXT:    ret void
// CHECK-DEFAULT:       worker.exit:
// CHECK-DEFAULT-NEXT:    ret void
//
