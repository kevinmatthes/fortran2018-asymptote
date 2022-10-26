######################## GNU General Public License 2.0 ########################
##                                                                            ##
## Copyright (C) 2022 Kevin Matthes                                           ##
##                                                                            ##
## This program is free software; you can redistribute it and/or modify       ##
## it under the terms of the GNU General Public License as published by       ##
## the Free Software Foundation; either version 2 of the License, or          ##
## (at your option) any later version.                                        ##
##                                                                            ##
## This program is distributed in the hope that it will be useful,            ##
## but WITHOUT ANY WARRANTY; without even the implied warranty of             ##
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              ##
## GNU General Public License for more details.                               ##
##                                                                            ##
## You should have received a copy of the GNU General Public License along    ##
## with this program; if not, write to the Free Software Foundation, Inc.,    ##
## 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.                ##
##                                                                            ##
################################################################################

################################################################################
##
##  AUTHOR      Kevin Matthes
##  BRIEF       The recipes in order to compile the provided executable.
##  COPYRIGHT   GPL-2.0
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

# Compile the Asymptote drawing type.
@asymptote_drawing: interfaces
    gfortran {{f18-lib}} src/asymptote_drawing.f08
    ar rsv {{library}} *.o
    rm -rf *.o

# Increment the version numbers.
@bump part:
    bump2version {{part}}
    scriv collect

# Ensure the library's logic to work.
@check: clear valgrind

# Remove build and documentation artifacts.
@clear:
    git clean -dfx

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
    gfortran {{f18-lib}} src/lib.f08
    ar rsv {{library}} *.o
    rm -rf *.o

# Create the project library.
@library: asymptote_drawing interfaces

# Compile and run a single unit test.
@test name: directories library
    gfortran {{f18-exe}} tests/test_{{name}}.f08 -o \
        target/test_{{name}} {{lnk-f18}}
    valgrind {{vflags}} target/test_{{name}}

# Analyse the memory management of the unit tests.
@valgrind:
    just test drawing_lifecycle
    just test export_combinations
    just test library_version

################################################################################
