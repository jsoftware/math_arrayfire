if "%vctoolsversion%"=="" call vcvars64.bat
nmake target=%1 backend=%2 /A /F makefile_win