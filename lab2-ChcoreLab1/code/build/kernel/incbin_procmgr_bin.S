/*
 * Copyright (c) 2023 Institute of Parallel And Distributed Systems (IPADS), Shanghai Jiao Tong University (SJTU)
 * Licensed under the Mulan PSL v2.
 * You can use this software according to the terms and conditions of the Mulan PSL v2.
 * You may obtain a copy of Mulan PSL v2 at:
 *     http://license.coscl.org.cn/MulanPSL2
 * THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR
 * PURPOSE.
 * See the Mulan PSL v2 for more details.
 */

/* Kernel binary include template. */

        .section .rodata
        .align 4
        .globl binary_procmgr_bin_start
binary_procmgr_bin_start:
        .incbin "/home/os/OS-Course-Lab/kernel/../user/procmgr"
binary_procmgr_bin_end:
        .globl binary_procmgr_bin_size
binary_procmgr_bin_size:
#if __SIZEOF_POINTER__ == 4
        .word binary_procmgr_bin_end - binary_procmgr_bin_start
#else
        .quad binary_procmgr_bin_end - binary_procmgr_bin_start
#endif
