# Copyright 2018 by Martin Moene
#
# https://github.com/martinmoene/kalman-estimator
#
# Distributed under the Boost Software License, Version 1.0.
# (See accompanying file LICENSE.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

cmake_minimum_required( VERSION 3.5 )

project( example_avr LANGUAGES CXX )

# Target default options and definitions:

set( OPTIONS "" )
set( DEFINITIONS "" )

# Sources (.cpp) and their base names:

set( SOURCES
    avr-adc-dac-isr-atmega.e.cpp
    avr-adc-isr.e.cpp
    avr-blink-led-isr.e.cpp
    avr-blink-led.e.cpp
    avr-fade-led.e.cpp
    avr-kalman-sim.e.cpp
)

# Function to create a target:

function( make_target source )
    string( REPLACE ".cpp" "" target "${source}" )
    add_avr_executable            ( ${target} ${source}  )
#        avr_target_compile_options    ( ${target} PRIVATE ${OPTIONS} )
#        avr_target_compile_definitions( ${target} PRIVATE ${DEFINITIONS} )
#        avr_target_link_libraries     ( ${target} PRIVATE kalman-estimator )
endfunction()

# Targets:

enable_testing()

foreach( target ${SOURCES} )
    make_target( ${target} )
endforeach()

# end of file
