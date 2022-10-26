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
public
    !> This library's version.
    character (*), parameter    :: library_version = 'v0.0.0'

    !> The Asymptote drawing to produce.
    type, public    :: drawing
        character (:), pointer, private :: compiler         => null ()
        character (:), pointer, private :: name             => null ()
        character (:), pointer, private :: output_format    => null ()
    contains
        final                           :: finalise_drawing
        procedure, pass (this), public  :: drawing_can_be_exported
        procedure, pass (this), public  :: export       => export_drawing
        procedure, pass (this), public  :: get_name     => get_drawing_name
        procedure, pass (this), public  :: set_eps      => set_drawing_eps
        procedure, pass (this), public  :: set_name     => set_drawing_name
        procedure, pass (this), public  :: set_pdf      => set_drawing_pdf
        procedure, pass (this), public  :: set_pdflatex => set_drawing_pdflatex
    end type drawing

    interface drawing
        pure module function init_drawing (name)
        implicit none
            character (*), intent (in)  :: name
            type (drawing)              :: init_drawing
        end function init_drawing
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
        pure module subroutine get_drawing_name (this, name)
        implicit none
            character (:), pointer, intent (out)    :: name
            class (drawing), intent (in)            :: this
        end subroutine get_drawing_name
    end interface

    interface
        pure module subroutine set_drawing_eps (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_eps
    end interface

    interface
        pure module subroutine set_drawing_name (this, name)
        implicit none
            character (*), intent (in)      :: name
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_name
    end interface

    interface
        pure module subroutine set_drawing_pdf (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_pdf
    end interface

    interface
        pure module subroutine set_drawing_pdflatex (this)
        implicit none
            class (drawing), intent (inout) :: this
        end subroutine set_drawing_pdflatex
    end interface
end module libf18asy

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
