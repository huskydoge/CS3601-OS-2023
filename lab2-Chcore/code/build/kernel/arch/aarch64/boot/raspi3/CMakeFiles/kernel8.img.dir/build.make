# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.16

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/os/OS-Course-Lab/kernel

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/os/OS-Course-Lab/build/kernel

# Utility rule file for kernel8.img.

# Include the progress variables for this target.
include arch/aarch64/boot/raspi3/CMakeFiles/kernel8.img.dir/progress.make

arch/aarch64/boot/raspi3/CMakeFiles/kernel8.img: kernel.img
	cd /home/os/OS-Course-Lab/build/kernel/arch/aarch64/boot/raspi3 && aarch64-linux-gnu-objcopy -O binary -S /home/os/OS-Course-Lab/build/kernel/kernel.img kernel8.img

kernel8.img: arch/aarch64/boot/raspi3/CMakeFiles/kernel8.img
kernel8.img: arch/aarch64/boot/raspi3/CMakeFiles/kernel8.img.dir/build.make

.PHONY : kernel8.img

# Rule to build all files generated by this target.
arch/aarch64/boot/raspi3/CMakeFiles/kernel8.img.dir/build: kernel8.img

.PHONY : arch/aarch64/boot/raspi3/CMakeFiles/kernel8.img.dir/build

arch/aarch64/boot/raspi3/CMakeFiles/kernel8.img.dir/clean:
	cd /home/os/OS-Course-Lab/build/kernel/arch/aarch64/boot/raspi3 && $(CMAKE_COMMAND) -P CMakeFiles/kernel8.img.dir/cmake_clean.cmake
.PHONY : arch/aarch64/boot/raspi3/CMakeFiles/kernel8.img.dir/clean

arch/aarch64/boot/raspi3/CMakeFiles/kernel8.img.dir/depend:
	cd /home/os/OS-Course-Lab/build/kernel && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/os/OS-Course-Lab/kernel /home/os/OS-Course-Lab/kernel/arch/aarch64/boot/raspi3 /home/os/OS-Course-Lab/build/kernel /home/os/OS-Course-Lab/build/kernel/arch/aarch64/boot/raspi3 /home/os/OS-Course-Lab/build/kernel/arch/aarch64/boot/raspi3/CMakeFiles/kernel8.img.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : arch/aarch64/boot/raspi3/CMakeFiles/kernel8.img.dir/depend

