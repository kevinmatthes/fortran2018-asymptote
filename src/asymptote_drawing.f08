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
!> \file asymptote_drawing.f08
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
!> \brief   The submodule defining operations on an Asymptote drawing.
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
    include 'asymptote_drawing/get_drawing_aspect.f08'
    include 'asymptote_drawing/get_drawing_compiler.f08'
    include 'asymptote_drawing/get_drawing_format.f08'
    include 'asymptote_drawing/get_drawing_height.f08'
    include 'asymptote_drawing/get_drawing_length_unit.f08'
    include 'asymptote_drawing/get_drawing_name.f08'
    include 'asymptote_drawing/get_drawing_width.f08'
    include 'asymptote_drawing/initialise_drawing.f08'
    include 'asymptote_drawing/set_drawing_aspect_false.f08'
    include 'asymptote_drawing/set_drawing_aspect_true.f08'
    include 'asymptote_drawing/set_drawing_compiler_lualatex.f08'
    include 'asymptote_drawing/set_drawing_compiler_pdflatex.f08'
    include 'asymptote_drawing/set_drawing_compiler_xelatex.f08'
    include 'asymptote_drawing/set_drawing_format_eps.f08'
    include 'asymptote_drawing/set_drawing_format_pdf.f08'
    include 'asymptote_drawing/set_drawing_name.f08'
    include 'asymptote_drawing/set_drawing_height.f08'
    include 'asymptote_drawing/set_drawing_length_unit_big_point.f08'
    include 'asymptote_drawing/set_drawing_length_unit_centimetre.f08'
    include 'asymptote_drawing/set_drawing_length_unit_inch.f08'
    include 'asymptote_drawing/set_drawing_length_unit_millimetre.f08'
    include 'asymptote_drawing/set_drawing_length_unit_point.f08'
    include 'asymptote_drawing/set_drawing_width.f08'
    include 'asymptote_drawing/write_drawing_output_settings.f08'
    include 'asymptote_drawing/write_drawing_size_settings.f08'
end submodule asymptote_drawing

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
