# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

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
CMAKE_COMMAND = /Applications/CLion.app/Contents/bin/cmake/bin/cmake

# The command to remove a file.
RM = /Applications/CLion.app/Contents/bin/cmake/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src-build

# Include any dependencies generated for this target.
include test/CMakeFiles/diagnostics_test.dir/depend.make

# Include the progress variables for this target.
include test/CMakeFiles/diagnostics_test.dir/progress.make

# Include the compile flags for this target's objects.
include test/CMakeFiles/diagnostics_test.dir/flags.make

test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o: test/CMakeFiles/diagnostics_test.dir/flags.make
test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o: /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src/test/diagnostics_test.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o"
	cd /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src-build/test && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o -c /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src/test/diagnostics_test.cc

test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.i"
	cd /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src-build/test && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src/test/diagnostics_test.cc > CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.i

test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.s"
	cd /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src-build/test && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src/test/diagnostics_test.cc -o CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.s

test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o.requires:

.PHONY : test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o.requires

test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o.provides: test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o.requires
	$(MAKE) -f test/CMakeFiles/diagnostics_test.dir/build.make test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o.provides.build
.PHONY : test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o.provides

test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o.provides.build: test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o


# Object files for target diagnostics_test
diagnostics_test_OBJECTS = \
"CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o"

# External object files for target diagnostics_test
diagnostics_test_EXTERNAL_OBJECTS =

test/diagnostics_test: test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o
test/diagnostics_test: test/CMakeFiles/diagnostics_test.dir/build.make
test/diagnostics_test: src/libbenchmark.a
test/diagnostics_test: test/CMakeFiles/diagnostics_test.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src-build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable diagnostics_test"
	cd /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src-build/test && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/diagnostics_test.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
test/CMakeFiles/diagnostics_test.dir/build: test/diagnostics_test

.PHONY : test/CMakeFiles/diagnostics_test.dir/build

test/CMakeFiles/diagnostics_test.dir/requires: test/CMakeFiles/diagnostics_test.dir/diagnostics_test.cc.o.requires

.PHONY : test/CMakeFiles/diagnostics_test.dir/requires

test/CMakeFiles/diagnostics_test.dir/clean:
	cd /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src-build/test && $(CMAKE_COMMAND) -P CMakeFiles/diagnostics_test.dir/cmake_clean.cmake
.PHONY : test/CMakeFiles/diagnostics_test.dir/clean

test/CMakeFiles/diagnostics_test.dir/depend:
	cd /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src-build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src/test /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src-build /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src-build/test /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/vendor/benchmark/src/benchmark_src-build/test/CMakeFiles/diagnostics_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : test/CMakeFiles/diagnostics_test.dir/depend

