!!!!!!!!!!!!!!!!!!!!!!!! GNU General Public License 3.0 !!!!!!!!!!!!!!!!!!!!!!!!
!!                                                                            !!
!! Copyright (C) 2022 Kevin Matthes                                           !!
!!                                                                            !!
!! This program is free software: you can redistribute it and/or modify       !!
!! it under the terms of the GNU General Public License as published by       !!
!! the Free Software Foundation, either version 3 of the License, or          !!
!! (at your option) any later version.                                        !!
!!                                                                            !!
!! This program is distributed in the hope that it will be useful,            !!
!! but WITHOUT ANY WARRANTY; without even the implied warranty of             !!
!! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              !!
!! GNU General Public License for more details.                               !!
!!                                                                            !!
!! You should have received a copy of the GNU General Public License          !!
!! along with this program.  If not, see <https://www.gnu.org/licenses/>.     !!
!!                                                                            !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!
!> \file test_command_write.f08
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!
!> \author      Kevin Matthes
!> \copyright   GPL-3.0
!> \date        2022
!> \note        See `LICENSE' for full license.
!>              See `README.md' for project details.
!>
!> \brief   A simple writing test for the `command` type.
!> \return  Whether this test succeeds.
!>
!> This unit test will check whether
!>
!> * a new command can be constructed from a 2D drawing path.
!> * the constructed command can be written to `stdout`.
!> * the constructed command can be written to `stdout` with one of the
!>   following length units.
!>   * centimetre (`cm`)
!>   * inch (`inch`)
!>   * millimetre (`mm`)
!>   * point (`pt`)
!> * the memory management is working.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

program test_command_write
    use, non_intrinsic :: libf18asy, only: operator (.line.)
    use, non_intrinsic :: libf18asy, only: command
    use, non_intrinsic :: libf18asy, only: draw
    use, non_intrinsic :: libf18asy, only: finalise
    use, non_intrinsic :: libf18asy, only: pair
    use, non_intrinsic :: libf18asy, only: path
implicit none
    type (command)      :: instruction
    type (pair)         :: a
    type (pair)         :: b
    type (path), target :: line

    a = pair (1.0, 1.0)
    b = pair (2.0, 2.0)
    line = a .line. b

    instruction = draw (line)

    call instruction % write
    call instruction % write (length_unit = 'cm')
    call instruction % write (length_unit = 'inch')
    call instruction % write (length_unit = 'mm')
    call instruction % write (length_unit = 'pt')

    call finalise (line)
end program test_command_write

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
