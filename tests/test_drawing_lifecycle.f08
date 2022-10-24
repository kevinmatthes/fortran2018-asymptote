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
!> * the constructed drawing can be exported.
!> * the constructed drawing's name can be modified.
!> * the modified drawing name can be retrieved.
!> * the modified drawing can be exported.
!> * the memory management is working.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

program test_drawing_lifecycle
    use, non_intrinsic :: libf18asy, only: drawing
    use, non_intrinsic :: libf18asy, only: finalise_drawing
implicit none
    character (:), pointer  :: name
    type (drawing)          :: asymptote

    asymptote = drawing ('name')
    call asymptote % get_name (name)

    if (name /= 'name') then
        error stop '[drawing] Original name not retrievable!'
    end if

    deallocate (name)
    call asymptote % export
    call asymptote % set_name ('new_name')
    call asymptote % get_name (name)

    if (name /= 'new_name') then
        error stop '[drawing] Modified name not retrievable!'
    end if

    deallocate (name)
    call asymptote % export
    call finalise_drawing (asymptote)
end program test_drawing_lifecycle

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
