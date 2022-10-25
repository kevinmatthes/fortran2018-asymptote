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
!> \file test_drawing_lifecycle.f08
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
!> \brief   A simple lifecycle test for the `drawing` type.
!> \return  Whether this test succeeds.
!>
!> This unit test will check whether
!>
!> * a new Asymptote drawing can be constructed.
!> * the constructed drawing's name can be retrieved.
!> * the constructed drawing can be exported with both compiler and output
!>   format being unset.
!> * the output format can be set to PDF.
!> * the constructed drawing can be exported without a compiler being set.
!> * the compiler can be set to `pdflatex`.
!> * the constructed drawing's name can be modified.
!> * the modified drawing name can be retrieved.
!> * the modified drawing can be exported.
!> * the memory management is working.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

program test_drawing_lifecycle
    use, non_intrinsic :: libf18asy, only: drawing
    use, non_intrinsic :: libf18asy, only: finalise
implicit none
    character (:), pointer  :: name => null ()
    type (drawing)          :: asymptote

    asymptote = drawing ('name')
    call asymptote % get_name (name)

    if (name /= 'name') then
        error stop 'Original drawing name cannot be retrieved!'
    else
        deallocate (name)
    end if

    if (asymptote % drawing_can_be_exported ()) then
        error stop 'Drawing export does not need compiler and output format inf&
        &ormation!'
    end if

    call asymptote % set_pdf

    if (asymptote % drawing_can_be_exported ()) then
        error stop 'Drawing export does not need a compiler being set!'
    end if

    call asymptote % set_pdflatex

    if (.not. asymptote % export ()) then
        error stop 'Valid drawing cannot be exported!'
    end if

    call asymptote % set_name ('new_name')
    call asymptote % get_name (name)

    if (name /= 'new_name') then
        error stop 'Modified drawing name cannot be retrieved!'
    else
        deallocate (name)
    end if

    if (.not. asymptote % export ()) then
        error stop 'Valid drawing cannot be exported!'
    end if

    call finalise (asymptote)
end program test_drawing_lifecycle

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
