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

# Utility rule file for lint_src.

# Include the progress variables for this target.
include CMakeFiles/lint_src.dir/progress.make

CMakeFiles/lint_src:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Running lint_src"
	/Applications/CLion.app/Contents/bin/cmake/bin/cmake -E chdir /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager CLANG_TIDY_EXECUTABLE-NOTFOUND -quiet -p=/Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug src/buffer_manager.cc src/file/posix_file.cc

lint_src: CMakeFiles/lint_src
lint_src: CMakeFiles/lint_src.dir/build.make

.PHONY : lint_src

# Rule to build all files generated by this target.
CMakeFiles/lint_src.dir/build: lint_src

.PHONY : CMakeFiles/lint_src.dir/build

CMakeFiles/lint_src.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/lint_src.dir/cmake_clean.cmake
.PHONY : CMakeFiles/lint_src.dir/clean

CMakeFiles/lint_src.dir/depend:
	cd /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug /Users/ahmettanakol/projects/moderndb/task-2-buffer-manager/cmake-build-debug/CMakeFiles/lint_src.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/lint_src.dir/depend

