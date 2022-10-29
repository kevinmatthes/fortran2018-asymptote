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
!> \file test_export_combinations.f08
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
!> \brief   A simple test whether all possible export option combinations work.
!> \return  Whether this test succeeds.
!>
!> This unit test will check whether Asymptote drawings can be exported as
!>
!> * EPS files, and
!> * PDF files
!>
!> being compiled with
!>
!> * `lualatex`,
!> * `pdflatex`, and
!> * `xelatex`
!>
!> as the preferred compilers, respectively.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

program test_export_combinations
    use, non_intrinsic :: libf18asy, only: drawing
    use, non_intrinsic :: libf18asy, only: finalise
implicit none
    character (:), pointer  :: compiler         => null ()
    character (:), pointer  :: output_format    => null ()
    type (drawing)          :: asymptote



    asymptote = drawing ('eps_lualatex', 3., 3.)
    call asymptote % set_centimetre
    call asymptote % set_eps
    call asymptote % set_lualatex

    if (.not. asymptote % export ()) then
        error stop 'Export of EPS / `lualatex` drawing failed!'
    end if

    call asymptote % get_compiler (compiler)

    if (compiler /= 'lualatex') then
        error stop 'Drawing compiler cannot be retrieved!'
    else
        deallocate (compiler)
    end if

    call asymptote % get_format (output_format)

    if (output_format /= 'eps') then
        error stop 'Drawing output format cannot be retrieved!'
    else
        deallocate (output_format)
    end if



    call asymptote % set_name ('eps_pdflatex')
    call asymptote % set_pdflatex

    if (.not. asymptote % export ()) then
        error stop 'Export of EPS / `pdflatex` drawing failed!'
    end if

    call asymptote % get_compiler (compiler)

    if (compiler /= 'pdflatex') then
        error stop 'Drawing compiler cannot be retrieved!'
    else
        deallocate (compiler)
    end if

    call asymptote % get_format (output_format)

    if (output_format /= 'eps') then
        error stop 'Drawing output format cannot be retrieved!'
    else
        deallocate (output_format)
    end if



    call asymptote % set_name ('eps_xelatex')
    call asymptote % set_xelatex

    if (.not. asymptote % export ()) then
        error stop 'Export of EPS / `xelatex` drawing failed!'
    end if

    call asymptote % get_compiler (compiler)

    if (compiler /= 'xelatex') then
        error stop 'Drawing compiler cannot be retrieved!'
    else
        deallocate (compiler)
    end if

    call asymptote % get_format (output_format)

    if (output_format /= 'eps') then
        error stop 'Drawing output format cannot be retrieved!'
    else
        deallocate (output_format)
    end if



    call asymptote % set_name ('pdf_lualatex')
    call asymptote % set_pdf
    call asymptote % set_lualatex

    if (.not. asymptote % export ()) then
        error stop 'Export of PDF / `lualatex` drawing failed!'
    end if

    call asymptote % get_compiler (compiler)

    if (compiler /= 'lualatex') then
        error stop 'Drawing compiler cannot be retrieved!'
    else
        deallocate (compiler)
    end if

    call asymptote % get_format (output_format)

    if (output_format /= 'pdf') then
        error stop 'Drawing output format cannot be retrieved!'
    else
        deallocate (output_format)
    end if



    call asymptote % set_name ('pdf_pdflatex')
    call asymptote % set_pdflatex

    if (.not. asymptote % export ()) then
        error stop 'Export of PDF / `pdflatex` drawing failed!'
    end if

    call asymptote % get_compiler (compiler)

    if (compiler /= 'pdflatex') then
        error stop 'Drawing compiler cannot be retrieved!'
    else
        deallocate (compiler)
    end if

    call asymptote % get_format (output_format)

    if (output_format /= 'pdf') then
        error stop 'Drawing output format cannot be retrieved!'
    else
        deallocate (output_format)
    end if



    call asymptote % set_name ('pdf_xelatex')
    call asymptote % set_xelatex

    if (.not. asymptote % export ()) then
        error stop 'Export of PDF / `xelatex` drawing failed!'
    end if

    call asymptote % get_compiler (compiler)

    if (compiler /= 'xelatex') then
        error stop 'Drawing compiler cannot be retrieved!'
    else
        deallocate (compiler)
    end if

    call asymptote % get_format (output_format)

    if (output_format /= 'pdf') then
        error stop 'Drawing output format cannot be retrieved!'
    else
        deallocate (output_format)
    end if



    call finalise (asymptote)
end program test_export_combinations

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
