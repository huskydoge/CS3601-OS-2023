# Copyright (c) 2023 Institute of Parallel And Distributed Systems (IPADS), Shanghai Jiao Tong University (SJTU)
# Licensed under the Mulan PSL v2.
# You can use this software according to the terms and conditions of the Mulan PSL v2.
# You may obtain a copy of Mulan PSL v2 at:
#     http://license.coscl.org.cn/MulanPSL2
# THIS SOFTWARE IS PROVIDED ON AN "AS IS" BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR
# PURPOSE.
# See the Mulan PSL v2 for more details.

# Set toolchain executables
set(CMAKE_ASM_COMPILER "/home/os/OS-Course-Lab/build/chcore-libc/bin/musl-gcc")
set(CMAKE_C_COMPILER "/home/os/OS-Course-Lab/build/chcore-libc/bin/musl-gcc")
set(CMAKE_CXX_COMPILER "/home/os/OS-Course-Lab/build/chcore-libc/bin/musl-gcc")
set(CMAKE_AR "/home/os/OS-Course-Lab/build/chcore-libc/bin/musl-ar")
set(CMAKE_NM "aarch64-linux-gnu-nm")
set(CMAKE_OBJCOPY "aarch64-linux-gnu-objcopy")
set(CMAKE_OBJDUMP "aarch64-linux-gnu-objdump")
set(CMAKE_RANLIB "aarch64-linux-gnu-ranlib")
set(CMAKE_STRIP "/home/os/OS-Course-Lab/build/chcore-libc/bin/musl-strip")

# Set install prefix path
set(custom_ramdisk_dir /home/os/OS-Course-Lab/ramdisk)

if(EXISTS ${custom_ramdisk_dir})
    set(CHCORE_RAMDISK_INSTALL_PREFIX ${custom_ramdisk_dir})
else()
    set(CHCORE_RAMDISK_INSTALL_PREFIX )
endif()

# Check whether the CXX language is enabled
set(_cxx_enabled FALSE)

get_property(_language_list GLOBAL PROPERTY ENABLED_LANGUAGES)

foreach(_language ${_language_list})
    if(${_language} STREQUAL "CXX")
        set(_cxx_enabled TRUE)
    endif()
endforeach(_language)

# Build position independent code, a.k.a -fPIC
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

execute_process(
    COMMAND ${CMAKE_C_COMPILER} -dumpmachine
    OUTPUT_STRIP_TRAILING_WHITESPACE
    OUTPUT_VARIABLE _target_machine)
message("[DEBUG]the target machine is ${_target_machine}")
string(REGEX MATCH "^[^-]+" _target_arch "${_target_machine}")

# Set CHCORE_ARCH cache var
# Note: set as cache variable so that it will be passed into C
# as compile definition later
set(CHCORE_ARCH
    ${_target_arch}
    CACHE STRING "" FORCE)

unset(_target_machine)
unset(_target_arch)

# Set prefix path
if(NOT ".chpm/install" STREQUAL "")
    # Get absolute path
    get_filename_component(_chpm_install_prefix .chpm/install
                           REALPATH BASE_DIR /home/os/OS-Course-Lab)

    string(REPLACE ":" ";" CMAKE_PREFIX_PATH "${CMAKE_PREFIX_PATH}")
    # For find_package, find_library, etc.
    list(APPEND CMAKE_PREFIX_PATH ${_chpm_install_prefix})

    # C++ headers (FIXME: now we hardcode the version number)
    if(CHCORE_ARCH STREQUAL "x86_64")
        include_directories(
            $<$<COMPILE_LANGUAGE:CXX>:${_chpm_install_prefix}/include/c++/9.2.0/x86_64-linux-musl>
        )
    elseif(CHCORE_ARCH STREQUAL "aarch64")
        include_directories(
            $<$<COMPILE_LANGUAGE:CXX>:${_chpm_install_prefix}/include/c++/9.2.0/aarch64-linux-musleabi>
        )
    elseif(CHCORE_ARCH STREQUAL "riscv64")
        include_directories(
            $<$<COMPILE_LANGUAGE:CXX>:${_chpm_install_prefix}/include/c++/9.2.0/riscv64-linux-musl>
    )
    else()
        message(
            WARNING
                "Please set arch-specific C++ header location for ${CHCORE_ARCH}"
        )
    endif()
    include_directories(
        $<$<COMPILE_LANGUAGE:CXX>:${_chpm_install_prefix}/include/c++/9.2.0>)

    # Link C++ standard library for C++ apps
    if(EXISTS ${_chpm_install_prefix}/lib/libstdc++.so)
        set(CMAKE_CXX_FLAGS
            "${CMAKE_CXX_FLAGS} -L${_chpm_install_prefix}/lib/ ${_chpm_install_prefix}/lib/libstdc++.so ${_chpm_install_prefix}/lib/libgcc_s.so"
        )
    endif()
endif()


if(NOT ".cpp" STREQUAL "")
    # Get absolute path
    get_filename_component(_cpp_install_prefix .cpp
                           REALPATH BASE_DIR /home/os/OS-Course-Lab)

    string(REPLACE ":" ";" CMAKE_PREFIX_PATH "${CMAKE_PREFIX_PATH}")
    # For find_package, find_library, etc.
    list(APPEND CMAKE_PREFIX_PATH ${_cpp_install_prefix})

    # Check CXX toolchain
    if((NOT EXISTS ${_cpp_install_prefix}) AND ${_cxx_enabled})
        message(FATAL_ERROR "To use C++ toolchain, please setup ${CHCORE_CPP_INSTALL_PREFIX} directory first!\nYou can run ./scripts/build/buildup_cpp.sh {arch} to buildup c++ toolchain!")
    endif()
    
    # C++ headers (FIXME: now we hardcode the version number)
    if(CHCORE_ARCH STREQUAL "x86_64")
        include_directories(
            $<$<COMPILE_LANGUAGE:CXX>:${_cpp_install_prefix}/x86_64/include/x86_64-linux-musl>
        )
    elseif(CHCORE_ARCH STREQUAL "aarch64")
        include_directories(
            $<$<COMPILE_LANGUAGE:CXX>:${_cpp_install_prefix}/aarch64/include/aarch64-linux-musleabi>
        )
    elseif(CHCORE_ARCH STREQUAL "riscv64")
        include_directories(
            $<$<COMPILE_LANGUAGE:CXX>:${_cpp_install_prefix}/riscv64/include/riscv64-linux-musl>
    )
    else()
        message(
            WARNING
                "Please set arch-specific C++ header location for ${CHCORE_ARCH}"
        )
    endif()
    include_directories(
        $<$<COMPILE_LANGUAGE:CXX>:${_cpp_install_prefix}/${CHCORE_ARCH}/include>)

    # Link C++ standard library for C++ apps
    if(EXISTS ${_cpp_install_prefix}/${CHCORE_ARCH}/lib/libstdc++.so)
        set(CMAKE_CXX_FLAGS
            "${CMAKE_CXX_FLAGS} -L${_cpp_install_prefix}/${CHCORE_ARCH}/lib/ ${_cpp_install_prefix}/${CHCORE_ARCH}/lib/libstdc++.so ${_cpp_install_prefix}/${CHCORE_ARCH}/lib/libgcc_s.so"
        )
    endif()
endif()
