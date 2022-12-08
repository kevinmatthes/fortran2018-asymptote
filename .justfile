######################## GNU General Public License 3.0 ########################
##                                                                            ##
## Copyright (C) 2022 Kevin Matthes                                           ##
##                                                                            ##
## This program is free software: you can redistribute it and/or modify       ##
## it under the terms of the GNU General Public License as published by       ##
## the Free Software Foundation, either version 3 of the License, or          ##
## (at your option) any later version.                                        ##
##                                                                            ##
## This program is distributed in the hope that it will be useful,            ##
## but WITHOUT ANY WARRANTY; without even the implied warranty of             ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              ##
## GNU General Public License for more details.                               ##
##                                                                            ##
## You should have received a copy of the GNU General Public License          ##
## along with this program.  If not, see <https://www.gnu.org/licenses/>.     ##
##                                                                            ##
################################################################################

################################################################################
##
##  AUTHOR      Kevin Matthes
##  BRIEF       The recipes in order to compile the provided executable.
##  COPYRIGHT   GPL-3.0
##  DATE        2022
##  FILE        .justfile
##  NOTE        See `LICENSE' for full license.
##              See `README.md' for project details.
##
################################################################################

# Synonyms for the configured recipes.
alias a     := all
alias b     := library
alias build := library
alias c     := check
alias clr   := clear
alias d     := doxygen
alias dirs  := directories
alias l     := library
alias r     := valgrind
alias t     := valgrind
alias v     := valgrind
alias ver   := bump



# Compiler flags.
exe     := '-fPIE'
f18     := '-std=f2018'
flags   := '-Wall -Werror -Wextra -Wpedantic'
lib     := '-c -fPIC'

# Linker flags.
lflags  := '-L. -lf18asy'

# Targets.
library := 'libf18asy.a'

# Valgrind settings.
vflags  := '--leak-check=full --redzone-size=512 --show-leak-kinds=all'

# Settings for the supported language modes.
f18-exe := f18 + ' ' + exe + ' ' + flags
f18-lib := f18 + ' ' + lib + ' ' + flags
lnk-f18 := '-I. ' + lflags



# The default recipe to execute.
@default: check

# Execute all configured recipes.
@all: check doxygen

# Compile the `command` type.
@asymptote_command: asymptote_path
    just compile src/asymptote_command.f08

# Compile the `drawing` type.
@asymptote_drawing: library_utilities
    just compile src/asymptote_drawing.f08

# Compile the `pair` type.
@asymptote_pair: interfaces
    just compile src/asymptote_pair.f08

# Compile the `path` type.
@asymptote_path: asymptote_pair
    just compile src/asymptote_path.f08

# Increment the version numbers.
@bump part:
    bump2version {{part}}
    scriv collect

# Ensure the library's logic to work.
@check: clear valgrind

# Remove build and documentation artifacts.
@clear:
    git clean -dfx

# Compile the given source file and add it to the library.
@compile source_file:
    gfortran {{f18-lib}} {{source_file}}
    ar rsv {{library}} *.o
    rm -rf *.o

# Create the required directories.
@directories:
    mkdir -p target/

# Create the Doxygen documentation for this project.
@doxygen:
    doxygen doxygen.cfg
    cd latex/ && latexmk -f -r ../.latexmkrc --silent refman
    cp latex/refman.pdf doxygen.pdf

# Create the Fortran interfaces.
@interfaces:
    just compile src/lib.f08

# Create the project library.
@library: asymptote_command asymptote_drawing

# Compile the library utility procedures.
@library_utilities: interfaces
    just compile src/library_utilities.f08

# Compile and run a single unit test.
@test name: directories library
    gfortran {{f18-exe}} tests/test_{{name}}.f08 -o \
        target/test_{{name}} {{lnk-f18}}
    valgrind {{vflags}} target/test_{{name}}

# Analyse the memory management of the unit tests.
@valgrind:
    just test command_write
    just test drawing_export_combinations
    just test drawing_lifecycle
    just test library_version
    just test pair_write
    just test path_write

################################################################################
