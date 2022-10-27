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
!> \file set_drawing_pdflatex.f08
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
!> \brief   Alter the preferred compiler for this Asymptote drawing.
!> \param   this    The Asymptote drawing whose preferred compiler shall be set.
!>
!> This subroutine will assign the compiler `pdflatex` to this Asymptote
!> drawing.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

pure subroutine set_drawing_pdflatex (this)
implicit none
    class (drawing), intent (inout) :: this

    call conditional_free (this % compiler)
    allocate (character (8) :: this % compiler)
    this % compiler = 'pdflatex'
end subroutine set_drawing_pdflatex

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
