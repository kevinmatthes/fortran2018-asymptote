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
!> \file export_drawing.f08
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
!> \brief   Write this Asymptote drawing to an Asymptote source file.
!> \param   this    The Asymptote drawing to export.
!> \return  Whether this drawing could be exported.
!>
!> This subroutine will produce the Asymptote drawing by writing it to an
!> Asymptote source file.  The output source file is determined by the name of
!> this drawing.  The file will always be newly created, replacing any recent
!> file of the same name.
!>
!> A valid drawing has at least the following information configured.
!>
!> * name
!> * output format
!> * preferred compiler
!>
!> If an IO failure should occur or at least one of these information should be
!> missing, the drawing is not going to be exported.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

impure function export_drawing (this)
    use, intrinsic :: iso_fortran_env, only: error_unit
implicit none
    character (*), parameter        :: fmt = '(a, a, a)'
    class (drawing), intent (in)    :: this
    integer                         :: status
    integer                         :: unit
    intrinsic                       :: allocated
    intrinsic                       :: associated
    logical                         :: export_drawing

    export_drawing = .false.

    if (this % drawing_can_be_exported ()) then
        open    ( file = this % name // '.asy'                                 &
                , iostat = status                                              &
                , newunit = unit                                               &
                , status = 'replace'                                           &
                )

        if (status /= 0) then
            write (error_unit, fmt)                                            &
                'Asymptote drawing ''', this % name, ''' cannot be created.'
        else
            call write_library_version_header (unit)
            call this % write_output_settings (unit)
            call this % write_size_settings (unit)

            if (associated (this % instructions)) then
                if (allocated (this % length_unit)) then
                    call this % instructions % write (unit, this % length_unit)
                else
                    call this % instructions % write (unit)
                end if
            end if

            close (unit)

            export_drawing = .true.
        end if
    end if
end function export_drawing

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
