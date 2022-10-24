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
!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

module libf18asy
implicit none
public
    !> This library's version.
    character (*), parameter :: version = 'v0.0.0'

    !> The Asymptote drawing to produce.
    type, public :: asymptote
        !> This drawing's name.
        character (:), allocatable, private :: name
    contains
        !> \sa output_drawing \return Nothing.
        generic :: write ( !> \sa output_drawing
                           formatted
                         ) => output_drawing

        !> \sa output_drawing \return Nothing.
        procedure, nopass       :: output_drawing

        !> \sa set_name \return Nothing.
        procedure, pass (this)  :: set_name
    end type asymptote

    interface
        module subroutine output_drawing                                       &
            (this, unit, io_type, value_list, io_status, io_message)
        implicit none
            character (*), intent (in)          :: io_type
            character (*), intent (inout)       :: io_message
            class (asymptote), intent (in)      :: this
            integer, dimension (:), intent (in) :: value_list
            integer, intent (in)                :: unit
            integer, intent (out)               :: io_status
        end subroutine
    end interface

    interface
        pure module subroutine set_name (this, name)
        implicit none
            character (*), intent (in)          :: name
            class (asymptote), intent (inout)   :: this
        end subroutine set_name
    end interface
end module libf18asy

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
