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
CMAKE_SOURCE_DIR = /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug

# Utility rule file for lint_test.

# Include the progress variables for this target.
include CMakeFiles/lint_test.dir/progress.make

CMakeFiles/lint_test:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Running lint_test"
	/Applications/CLion.app/Contents/bin/cmake/bin/cmake -E chdir /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager CLANG_TIDY_EXECUTABLE-NOTFOUND -quiet -p=/Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug test/buffer_manager_test.cc

lint_test: CMakeFiles/lint_test
lint_test: CMakeFiles/lint_test.dir/build.make

.PHONY : lint_test

# Rule to build all files generated by this target.
CMakeFiles/lint_test.dir/build: lint_test

.PHONY : CMakeFiles/lint_test.dir/build

CMakeFiles/lint_test.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/lint_test.dir/cmake_clean.cmake
.PHONY : CMakeFiles/lint_test.dir/clean

CMakeFiles/lint_test.dir/depend:
	cd /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/CMakeFiles/lint_test.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/lint_test.dir/depend

