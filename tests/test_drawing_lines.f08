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
!> \file test_drawing_lines.f08
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
!> \brief   A simple drawing test for the `drawing` type.
!> \return  Whether this test succeeds.
!>
!> This unit test will check whether two lines can be drawn.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

program test_drawing_lines
    use, non_intrinsic :: libf18asy, only: operator (.line.)
    use, non_intrinsic :: libf18asy, only: drawing
    use, non_intrinsic :: libf18asy, only: finalise
    use, non_intrinsic :: libf18asy, only: pair
    use, non_intrinsic :: libf18asy, only: path
implicit none
    type (drawing)      :: asymptote
    type (pair)         :: a
    type (pair)         :: b
    type (pair)         :: c
    type (pair)         :: d
    type (path), target :: line_1
    type (path), target :: line_2

    a = pair (0.0, 0.0)
    b = pair (1.0, 0.0)
    c = pair (0.0, 1.0)
    d = pair (1.0, 1.0)

    line_1 = a .line. b
    line_2 = c .line. d

    asymptote = drawing ('test_drawing_lines', 3.0, 3.0)
    call asymptote % set_centimetre
    call asymptote % set_pdf
    call asymptote % set_pdflatex
    call asymptote % draw (line_1)
    call asymptote % draw (line_2)

    if (.not. asymptote % export ()) then
        error stop 'Valid drawing with two lines cannot be exported!'
    end if

    call finalise (asymptote)
    call finalise (line_1)
    call finalise (line_2)
end program test_drawing_lines

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
