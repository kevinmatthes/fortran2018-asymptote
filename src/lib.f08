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
!> \file lib.f08
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
!> \brief   The module containing all symbols to be exported.
!>
!> This Fortran 2018 library \cite chivers.sleightholme:fortran:2018
!> \cite kuhme.witschital:fortran:1991 \cite metcalf.reid.cohen:fortran:2018
!> is intended to provide the functionality to export drawings using the
!> Asymptote Vector Graphics Language
!> \cite hammerlindl.bowman.prince:asymptote:2021:2.69
!> \cite hammerlindl.bowman.prince:asymptote:2022:2.83.  It is tested with
!> Asymptote, version 2.69 \cite hammerlindl.bowman.prince:asymptote:2021:2.69.
!>
!> In order to define an Asymptote drawing with this library, a new `drawing`
!> instance needs to be created and modified in order to define the intended
!> drawing.
!>
!> \note Any `drawing` instance needs to be freed with a call to its finaliser,
!> `finalise`.  This is a generic subroutine freeing all instances of the data
!> types provided by this library.  At option, one may also call the subroutine
!> specific to the `drawing` type:  `finalise_drawing`.
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

module libf18asy
implicit none
private
    !> This library's version.
    character (*), parameter, public    :: library_version = 'v0.0.0'

    !> The Asymptote drawing to produce.
    type, public    :: drawing
        character (:), pointer, private :: compiler                            &
                                        => null ()

        character (:), pointer, private :: length_unit                         &
                                        => null ()

        character (:), pointer, private :: name                                &
                                        => null ()

        character (:), pointer, private :: output_format                       &
                                        => null ()

        logical, private    :: aspect                                          &
                            =  .true.

        real, private   :: height                                              &
                        =  0.0

        real, private   :: width                                               &
                        =  0.0
    contains
        final   :: finalise_drawing

        procedure, pass (this), public  :: drawing_can_be_exported

        procedure, pass (this), public  :: export                              &
                                        => export_drawing

        procedure, pass (this), public  :: get_aspect                          &
                                        => get_drawing_aspect

        procedure, pass (this), public  :: get_compiler                        &
                                        => get_drawing_compiler

        procedure, pass (this), public  :: get_format                          &
                                        => get_drawing_format

        procedure, pass (this), public  :: get_height                          &
                                        => get_drawing_height

        procedure, pass (this), public  :: get_length_unit                     &
                                        => get_drawing_length_unit

        procedure, pass (this), public  :: get_name                            &
                                        => get_drawing_name

        procedure, pass (this), public  :: get_width                           &
                                        => get_drawing_width

        procedure, pass (this), public  :: ignore_aspect                       &
                                        => set_drawing_aspect_false

        procedure, pass (this), public  :: keep_aspect                         &
                                        => set_drawing_aspect_true

        procedure, pass (this), public  :: set_big_point                       &
                                        => set_drawing_length_unit_big_point

        procedure, pass (this), public  :: set_centimetre                      &
                                        => set_drawing_length_unit_centimetre

        procedure, pass (this), public  :: set_eps                             &
                                        => set_drawing_format_eps

        procedure, pass (this), public  :: set_height                          &
                                        => set_drawing_height

        procedure, pass (this), public  :: set_inch                            &
                                        => set_drawing_length_unit_inch

        procedure, pass (this), public  :: set_lualatex                        &
                                        => set_drawing_compiler_lualatex

        procedure, pass (this), public  :: set_millimetre                      &
                                        => set_drawing_length_unit_millimetre

        procedure, pass (this), public  :: set_name                            &
                                        => set_drawing_name

        procedure, pass (this), public  :: set_pdf                             &
                                        => set_drawing_format_pdf

        procedure, pass (this), public  :: set_pdflatex                        &
                                        => set_drawing_compiler_pdflatex

        procedure, pass (this), public  :: set_point                           &
                                        => set_drawing_length_unit_point

        procedure, pass (this), public  :: set_width                           &
                                        => set_drawing_width

        procedure, pass (this), public  :: set_xelatex                         &
                                        => set_drawing_compiler_xelatex

        procedure, pass (this), private :: write_size_settings                 &
                                        => write_drawing_size_settings
    end type drawing

    private :: conditional_free
    private :: write_library_version_header

    public  :: finalise

    interface conditional_free
        pure module subroutine conditional_free_character (ptr)
        implicit none
            character (:), pointer, intent (inout)  :: ptr
        end subroutine conditional_free_character
    end interface conditional_free

    interface drawing
        pure module function initialise_drawing (name, width, height, aspect)
        implicit none
            character (*), intent (in)      :: name
            logical, intent (in), optional  :: aspect
            real, intent (in)               :: width
            real, intent (in), optional     :: height
            type (drawing)                  :: initialise_drawing
        end function initialise_drawing
    end interface drawing

    interface
        pure module function drawing_can_be_exported (this)
        implicit none
            class (drawing), intent (in)    :: this
            logical                         :: drawing_can_be_exported
        end function drawing_can_be_exported
    end interface

    interface
        module function export_drawing (this)
        implicit none
            class (drawing), intent (in)    :: this
            logical                         :: export_drawing
        end function export_drawing
    end interface

    interface finalise
        pure module subroutine finalise_drawing (this)
        implicit none
            type (drawing), intent (inout)  :: this
        end subroutine finalise_drawing
    end interface finalise

    interface
        pure module function get_drawing_aspect (this)
        implicit none
            class (drawing), intent (in)    :: this
            logical                         :: get_drawing_aspect
        end function get_drawing_aspect
    end interface

    interface
        pure module subroutine get_drawing_compiler (this, compiler)
        implicit none
            character (:), pointer, intent (out)    :: compiler
            class (drawing), intent (in)            :: this
        end subroutine get_drawing_compiler
    end interface

    interface
        pure module subroutine get_drawing_format (this, output_format)
        implicit none
            character (:), pointer, intent (out)    :: output_format
            class (drawing), intent (in)            :: this
        end subroutine get_drawing_format
    end interface

    interface
        pure module function get_drawing_height (this)
        implicit none
            class (drawing), intent (in)    :: this
            real                            :: get_drawing_height
        end function get_drawing_height
    end interface

    interface
        pure module subroutine get_drawing_length_unit (this, length_unit)
        implicit none
            character (:), pointer, intent (out)    :: length_unit
            class (drawing), intent (in)            :: this
        end subroutine get_drawing_length_unit
    end interface

    interface
        pure module subroutine get_drawing_name (this, name)
        implicit none
            character (:), pointer, intent (out)    :: name
            class (drawing), intent (in)            :: this
        end subroutine get_drawing_name
    end interface

    interface
        pure module function get_drawing_width (this)
        implicit none
            class (drawing), intent (in)    :: this
            real                            :: get_drawing_width
        end function get_drawing_width
    end interface

    interface
        pure module subroutine set_drawing_aspect_false (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_aspect_false
    end interface

    interface
        pure module subroutine set_drawing_aspect_true (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_aspect_true
    end interface

    interface
        pure module subroutine set_drawing_compiler_lualatex (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_compiler_lualatex
    end interface

    interface
        pure module subroutine set_drawing_compiler_pdflatex (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_compiler_pdflatex
    end interface

    interface
        pure module subroutine set_drawing_compiler_xelatex (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_compiler_xelatex
    end interface

    interface
        pure module subroutine set_drawing_format_eps (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_format_eps
    end interface

    interface
        pure module subroutine set_drawing_format_pdf (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_format_pdf
    end interface

    interface
        pure module subroutine set_drawing_height (this, height)
        implicit none
            class (drawing), intent (inout) :: this
            real, intent (in)               :: height
        end subroutine set_drawing_height
    end interface

    interface
        pure module subroutine set_drawing_length_unit_big_point (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_length_unit_big_point
    end interface

    interface
        pure module subroutine set_drawing_length_unit_centimetre (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_length_unit_centimetre
    end interface

    interface
        pure module subroutine set_drawing_length_unit_inch (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_length_unit_inch
    end interface

    interface
        pure module subroutine set_drawing_length_unit_millimetre (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_length_unit_millimetre
    end interface

    interface
        pure module subroutine set_drawing_length_unit_point (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_length_unit_point
    end interface

    interface
        pure module subroutine set_drawing_name (this, name)
        implicit none
            character (*), intent (in)      :: name
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_name
    end interface

    interface
        pure module subroutine set_drawing_width (this, width)
        implicit none
            class (drawing), intent (inout) :: this
            real, intent (in)               :: width
        end subroutine set_drawing_width
    end interface

    interface
        module subroutine write_drawing_size_settings (this, unit)
        implicit none
            class (drawing), intent (in)    :: this
            integer, intent (in), optional  :: unit
        end subroutine write_drawing_size_settings
    end interface

    interface
        module subroutine write_library_version_header (unit)
        implicit none
            integer, intent (in), optional  :: unit
        end subroutine write_library_version_header
    end interface
end module libf18asy

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
