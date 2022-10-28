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
!> \file asymptote_drawing.f08
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
!> \brief   The submodule defining the Asymptote drawing's methods.
!>
!> This submodule contains the procedures associated with the Asymptote drawing
!> to produce.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

submodule (libf18asy) asymptote_drawing
implicit none
contains
    include 'asymptote_drawing/drawing_can_be_exported.f08'
    include 'asymptote_drawing/export_drawing.f08'
    include 'asymptote_drawing/finalise_drawing.f08'
    include 'asymptote_drawing/get_drawing_compiler.f08'
    include 'asymptote_drawing/get_drawing_format.f08'
    include 'asymptote_drawing/get_drawing_name.f08'
    include 'asymptote_drawing/init_drawing.f08'
    include 'asymptote_drawing/set_drawing_compiler_lualatex.f08'
    include 'asymptote_drawing/set_drawing_compiler_pdflatex.f08'
    include 'asymptote_drawing/set_drawing_compiler_xelatex.f08'
    include 'asymptote_drawing/set_drawing_format_eps.f08'
    include 'asymptote_drawing/set_drawing_format_pdf.f08'
    include 'asymptote_drawing/set_drawing_name.f08'
end submodule asymptote_drawing

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
