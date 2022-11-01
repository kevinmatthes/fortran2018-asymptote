!!!!!!!!!!!!!!!!!!!!!!!! GNU General Public License 2.0 !!!!!!!!!!!!!!!!!!!!!!!!
!!                                                                            !!
!! Copyright (C) 2022 Kevin Matthes                                           !!
!!                                                                            !!
!! This program is free software; you can redistribute it and/or modify       !!
!! it under the terms of the GNU General Public License as published by       !!
!! the Free Software Foundation; either version 2 of the License, or          !!
!! (at your option) any later version.                                        !!
!!                                                                            !!
!! This program is distributed in the hope that it will be useful,            !!
!! but WITHOUT ANY WARRANTY; without even the implied warranty of             !!
!! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the              !!
!! GNU General Public License for more details.                               !!
!!                                                                            !!
!! You should have received a copy of the GNU General Public License along    !!
!! with this program; if not, write to the Free Software Foundation, Inc.,    !!
!! 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.                !!
!!                                                                            !!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!
!> \file write_pair.f08
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!
!> \author      Kevin Matthes
!> \copyright   GPL-2.0
!> \date        2022
!> \note        See `LICENSE' for full license.
!>              See `README.md' for project details.
!>
!> \brief   Output this pair.
!> \param   this        The pair which shall be exported.
!> \param   unit        The unit to write to.
!> \param   length_unit The length unit to write in addition.
!>
!> This subroutine will write this pair to the given unit.  If there is no unit
!> number given, the default output unit will be used for output.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

impure subroutine write_pair (this, unit, length_unit)
    use, intrinsic  :: iso_fortran_env, only: output_unit
implicit none
    character (:), allocatable              :: comma
    character (:), allocatable              :: parenthesis
    character (*), intent (in), optional    :: length_unit
    character (*), parameter                :: fmt = '(a, f17.8, a, f17.8, a)'
    class (pair), intent (in)               :: this
    integer                                 :: string_length = 0
    integer                                 :: writing_unit
    integer, intent (in), optional          :: unit
    intrinsic                               :: len
    intrinsic                               :: present

    if (present (length_unit)) then
        if (len (length_unit) > 0) then
            string_length = len (length_unit) + 1
        end if
    end if

    allocate (character (2 + string_length) :: comma)
    allocate (character (1 + string_length) :: parenthesis)
    comma       = ', '
    parenthesis = ')'

    if (string_length > 0) then
        comma       = ' ' // length_unit // ', '
        parenthesis = ' ' // length_unit // ')'
    else
        comma       = ', '
        parenthesis = ')'
    end if

    if (present (unit)) then
        writing_unit = unit
    else
        writing_unit = output_unit
    end if

    write (writing_unit, fmt) '(', this % fst, comma, this % snd, parenthesis
end subroutine write_pair

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
