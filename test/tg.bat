:: Copyright 2018 by Martin Moene
::
:: https://github.com/martinmoene/kalman-estimator
::
:: Distributed under the Boost Software License, Version 1.0.
:: (See accompanying file LICENSE.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

@echo off & setlocal enableextensions enabledelayedexpansion
::
:: tg.bat - compile & run tests (GNUC).
::

:: if no std is given, use c++11

set std=%1
set args=%2 %3 %4 %5 %6 %7 %8 %9
if "%1" == "" set std=c++17

set   gpp=g++

call :CompilerVersion version
echo %gpp% %version%: %std% %args%

set ke_feature=^
    -DKE_USE_STATIC_EXPECT=1

set lest_defines=^
    -Dlest_FEATURE_AUTO_REGISTER

set cxx_flags=-Wpedantic -Wno-padded -Wno-missing-noreturn

set ke_program=main.t.exe
set ke_sources=main.t.cpp core.t.cpp stdcpp.t.cpp biquad.t.cpp biquad-cascade.t.cpp fixed-point.t.cpp matrix.t.cpp

%gpp% -std=%std% -O2 -Wall -Wextra %cxx_flags% %ke_feature% %lest_defines% -o %ke_program% -isystem lest -I../include %ke_sources% && %ke_program%

endlocal & goto :EOF

:: subroutines:

:CompilerVersion  version
echo off & setlocal enableextensions
set tmpprogram=_getcompilerversion.tmp
set tmpsource=%tmpprogram%.c

echo #include ^<stdio.h^>     > %tmpsource%
echo int main(){printf("%%d.%%d.%%d\n",__GNUC__,__GNUC_MINOR__,__GNUC_PATCHLEVEL__);} >> %tmpsource%

%gpp% -o %tmpprogram% %tmpsource% >nul
for /f %%x in ('%tmpprogram%') do set version=%%x
del %tmpprogram%.* >nul
endlocal & set %1=%version%& goto :EOF
