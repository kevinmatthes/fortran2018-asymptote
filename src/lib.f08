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
!> \file lib.f08
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

    !> An Asymptote command to execute.
    type, public    :: command
        type (path), pointer, private       :: draw => null ()
        type (command), pointer, private    :: next => null ()
    contains
        final                           :: finalise_command
        procedure, pass (this), public  :: write            => write_command
    end type command

    !> The Asymptote drawing to produce.
    type, public    :: drawing
        character (:), allocatable, private :: compiler
        character (:), allocatable, private :: length_unit
        character (:), allocatable, private :: name
        character (:), allocatable, private :: output_format
        logical, private                    :: aspect           = .true.
        real, private                       :: height           = 0.0
        real, private                       :: width            = 0.0
    contains
        final                           :: finalise_drawing
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

        procedure, pass (this), private :: write_output_settings               &
                                        => write_drawing_output_settings

        procedure, pass (this), private :: write_size_settings                 &
                                        => write_drawing_size_settings
    end type drawing

    !> A 2D point on the canvas.
    type, public    :: pair
        real, private   :: fst  = 0.0
        real, private   :: snd  = 0.0
    contains
        procedure, pass (this), public  :: write    => write_pair
    end type pair

    !> A path of 2D points to draw.
    type, public    :: path
        type (pair), allocatable, private   :: point
        type (path), pointer, private       :: line     => null ()
    contains
        final                           :: finalise_path
        procedure, pass (this), public  :: write            => write_path
    end type path

    private :: conditional_free
    private :: write_library_version_header
    private :: write_string_assignment
    public  :: operator (.line.)
    public  :: draw
    public  :: finalise

    interface operator (.line.)
        pure module function line_pair_pair (beginning, ending)
        implicit none
            type (pair), intent (in)    :: beginning
            type (pair), intent (in)    :: ending
            type (path)                 :: line_pair_pair
        end function line_pair_pair
    end interface operator (.line.)

    interface conditional_free
        pure module subroutine conditional_free_character (object)
        implicit none
            character (:), allocatable, intent (inout)  :: object
        end subroutine conditional_free_character

        pure recursive module subroutine conditional_free_command (object)
        implicit none
            type (command), pointer, intent (inout) :: object
        end subroutine conditional_free_command

        pure module subroutine conditional_free_pair (object)
        implicit none
            type (pair), allocatable, intent (inout)    :: object
        end subroutine conditional_free_pair

        pure recursive module subroutine conditional_free_path (object)
        implicit none
            type (path), pointer, intent (inout)    :: object
        end subroutine conditional_free_path
    end interface conditional_free

    interface draw
        impure module function draw_command (curve)
        implicit none
            type (command)                      :: draw_command
            type (path), pointer, intent (in)   :: curve
        end function draw_command
    end interface draw

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
        impure module function export_drawing (this)
        implicit none
            class (drawing), intent (in)    :: this
            logical                         :: export_drawing
        end function export_drawing
    end interface

    interface finalise
        pure recursive module subroutine finalise_command (this)
        implicit none
            type (command), intent (inout)  :: this
        end subroutine finalise_command

        pure module subroutine finalise_drawing (this)
        implicit none
            type (drawing), intent (inout)  :: this
        end subroutine finalise_drawing

        pure recursive module subroutine finalise_path (this)
        implicit none
            type (path), intent (inout) :: this
        end subroutine finalise_path
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
            character (:), allocatable, intent (out)    :: compiler
            class (drawing), intent (in)                :: this
        end subroutine get_drawing_compiler
    end interface

    interface
        pure module subroutine get_drawing_format (this, output_format)
        implicit none
            character (:), allocatable, intent (out)    :: output_format
            class (drawing), intent (in)                :: this
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
            character (:), allocatable, intent (out)    :: length_unit
            class (drawing), intent (in)                :: this
        end subroutine get_drawing_length_unit
    end interface

    interface
        pure module subroutine get_drawing_name (this, name)
        implicit none
            character (:), allocatable, intent (out)    :: name
            class (drawing), intent (in)                :: this
        end subroutine get_drawing_name
    end interface

    interface
        pure module function get_drawing_width (this)
        implicit none
            class (drawing), intent (in)    :: this
            real                            :: get_drawing_width
        end function get_drawing_width
    end interface

    interface pair
        pure module function initialise_pair (fst, snd)
        implicit none
            real, intent (in), optional :: fst
            real, intent (in), optional :: snd
            type (pair)                 :: initialise_pair
        end function initialise_pair
    end interface pair

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
        impure recursive module subroutine write_command    ( this         &
                                                            , unit         &
                                                            , length_unit  &
                                                            )
        implicit none
            character (*), intent (in), optional    :: length_unit
            class (command), intent (in)            :: this
            integer, intent (in), optional          :: unit
        end subroutine write_command
    end interface

    interface
        impure module subroutine write_drawing_output_settings (this, unit)
        implicit none
            class (drawing), intent (in)    :: this
            integer, intent (in), optional  :: unit
        end subroutine write_drawing_output_settings
    end interface

    interface
        impure module subroutine write_drawing_size_settings (this, unit)
        implicit none
            class (drawing), intent (in)    :: this
            integer, intent (in), optional  :: unit
        end subroutine write_drawing_size_settings
    end interface

    interface
        impure module subroutine write_library_version_header (unit)
        implicit none
            integer, intent (in), optional  :: unit
        end subroutine write_library_version_header
    end interface

    interface
        impure module subroutine write_pair (this, unit, length_unit)
        implicit none
            character (*), intent (in), optional    :: length_unit
            class (pair), intent (in)               :: this
            integer, intent (in), optional          :: unit
        end subroutine write_pair
    end interface

    interface
        impure recursive module subroutine write_path (this, unit, length_unit)
        implicit none
            character (*), intent (in), optional    :: length_unit
            class (path), intent (in)               :: this
            integer, intent (in), optional          :: unit
        end subroutine write_path
    end interface

    interface
        impure module subroutine write_string_assignment    ( variable         &
                                                            , string           &
                                                            , unit             &
                                                            )
        implicit none
            character (*), intent (in)      :: string
            character (*), intent (in)      :: variable
            integer, intent (in), optional  :: unit
        end subroutine write_string_assignment
    end interface
end module libf18asy

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
