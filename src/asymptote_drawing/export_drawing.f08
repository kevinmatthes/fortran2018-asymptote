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
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

function export_drawing (this)
    use, intrinsic :: iso_fortran_env, only: error_unit
implicit none
    class (drawing), intent (in)    :: this
    logical                         :: export_drawing

    character (*), parameter    :: fmt = '(a, a, a)'
    integer                     :: status
    integer                     :: unit

    export_drawing = .false.

    if (this % drawing_can_be_exported ()) then
        open    ( file = this % name // '.asy'                                 &
                , iostat = status                                              &
                , newunit = unit                                               &
                , status = 'replace'                                           &
                )

        if (status /= 0) then
            write (unit = error_unit, fmt = fmt)                               &
                'Asymptote drawing ''', this % name, ''' cannot be created.'
        else
            write (unit, fmt = fmt)                                            &
                '// Created by LIBF18ASY, ', library_version, '.'
            write (unit, fmt = fmt) 'defaultfilename = "', this % name, '";'
            write (unit, fmt = fmt)                                            &
                'settings.outformat = "', this % output_format, '";'
            write (unit, fmt = fmt) 'settings.tex = "', this % compiler, '";'
            close (unit)

            export_drawing = .true.
        end if
    end if
end function export_drawing

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
