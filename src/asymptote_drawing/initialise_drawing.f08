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
!> \file initialise_drawing.f08
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
!> \brief   Create a new Asymptote drawing.
!> \param   name    The new Asymptote drawing's name.
!> \param   width   The new Asymptote drawing's width.
!> \param   height  The new Asymptote drawing's height.
!> \param   aspect  Whether the aspect ratio shall be kept.
!> \return  The new Asymptote drawing.
!>
!> This function will construct a new Asymptote drawing entity based on the
!> given data.
!>
!> \note Both the desired output format as well as the preferred compiler need
!> to be set separately with the therefore intended methods.  The length unit is
!> set to the Asymptote default.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

pure function initialise_drawing (name, width, height, aspect)
implicit none
    character (*), intent (in)      :: name
    logical, intent (in), optional  :: aspect
    real, intent (in)               :: width
    real, intent (in), optional     :: height
    type (drawing)                  :: initialise_drawing

    integer :: i
    integer :: string_length

    intrinsic   :: len_trim
    intrinsic   :: present

    intialise_drawing % width = width

    if (present (height)) then
        initialise_drawing % height = height
    else
        initialise_drawing % height = initialise_drawing % width
    end if

    if (present (aspect)) then
        initialise_drawing % aspect = aspect
    else
        initialise_drawing % aspect = .true.
    end if

    string_length = len_trim (name)
    allocate (character (string_length) :: initialise_drawing % name)

    do i = 1, string_length
        initialise_drawing % name (i : i) = name (i : i)
    end do
end function initialise_drawing

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
