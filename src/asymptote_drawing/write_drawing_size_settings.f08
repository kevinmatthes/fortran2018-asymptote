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
!> \file write_drawing_size_settings.f08
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
!> \brief   Output the size settings of this drawing.
!> \param   this    The drawing whose size settings shall be exported.
!> \param   unit    The unit to write to.
!>
!> This subroutine will write the size settings of this drawing to the given IO
!> unit.  If there is no unit number given, the default output unit will be used
!> for output.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

impure subroutine write_drawing_size_settings (this, unit)
    use, intrinsic  :: iso_fortran_env, only: output_unit
implicit none
    character (:), allocatable      :: length_unit
    class (drawing), intent (in)    :: this
    integer                         :: writing_unit
    integer, intent (in), optional  :: unit
    intrinsic                       :: allocated
    intrinsic                       :: present

    allocate (character (0) :: length_unit)

    if (allocated (this % length_unit)) then
        length_unit = ' ' // this % length_unit
    end if

    if (present (unit)) then
        writing_unit = unit
    else
        writing_unit = output_unit
    end if

    write (writing_unit, fmt = '(a, f13.4, a, a, f13.4, a, a)')                &
        'size (', this % width  , length_unit                                  &
    ,   ', '    , this % height , length_unit                                  &
    ,   ');'
end subroutine write_drawing_size_settings

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
