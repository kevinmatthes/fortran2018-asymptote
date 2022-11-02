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
!> \file write_command.f08
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
!> \brief   Output this command.
!> \param   this        The command which shall be exported.
!> \param   unit        The unit to write to.
!> \param   length_unit The length unit to write in addition.
!>
!> This subroutine will write this command to the given unit.  If there is no
!> unit number given, the default output unit will be used for output.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

impure recursive subroutine write_command (this, unit, length_unit)
    use, intrinsic  :: iso_fortran_env, only: output_unit
implicit none
    character (*), intent (in), optional    :: length_unit
    class (command), intent (in)            :: this
    integer                                 :: writing_unit
    integer, intent (in), optional          :: unit
    intrinsic                               :: associated
    intrinsic                               :: present
    logical                                 :: lu_present

    lu_present = present (length_unit)

    if (present (unit)) then
        writing_unit = unit
    else
        writing_unit = output_unit
    end if

    if (associated (this % draw)) then
        write (writing_unit, '(a)') 'draw ('

        if (lu_present) then
            call this % draw % write (writing_unit, length_unit)
        else
            call this % draw % write (writing_unit)
        end if

        write (writing_unit, '(a)') ');'
    end if

    if (associated (this % next)) then
        if (lu_present) then
            call this % next % write (writing_unit, length_unit)
        else
            call this % next % write (writing_unit)
        end if
    end if
end subroutine write_command

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
