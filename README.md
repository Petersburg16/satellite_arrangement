# satellite_arrangement

Please run these in Matlab after version 2023a!

Examples in folder are out of time.

## Install environment dependencies

### Install C++ Compiler
Please open matlab "get add ons", then search and install "MATLAB Support for MingGW-w64 C/C++/Fortran Compiler".
Then run `mex -setup` or `mex -setup c++` in Matlab Command Window to set up a C/C++ compiler for matlab.

### Install Mtimesx toolbox
Please open matlab "get add ons", then search and install "MTIMESX - Fast Matrix Multiply with Multi-Dimensional Support".
In this step we must change line 166 in file mtimesx_build.m in to `mexopts = [prefdir '\mex_C_win64.xml"];`

## Finish
After do these befor you should run main function successfully, enjoy :).

