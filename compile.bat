@echo off


set FULL_FILENAME=%~1
set FILENAME=%~n1
set DIRNAME=%~dp1
set FILE_EXT=%~x1
set FILENAME_EXT=%FILENAME%%FILE_EXT%


REM DEBUG
REM echo Full File Name: "%FULL_FILENAME%"
REM echo File Name: "%FILENAME%"
REM echo File Directory: "%DIRNAME%"
REM echo File Extension: "%FILE_EXT%"
REM echo File Name with Extension: "%FILENAME_EXT%"

set CC_BIN=gcc
set CPP_BIN=g++
set GHC_BIN=ghc
set PYTHON_BIN=C:\Users\Reemus_Kumar_Vincent\AppData\Local\Programs\Python\Python39\python.exe
set SCALA_BIN=scalac.bat
set JAVA_BIN=javac
set GOLANG_BIN=go

set CC_EXT=.c
set CPP_EXT1=.c++
set CPP_EXT2=.cpp
set CPP_EXT3=.cxx
set GHC_EXT=.hs
set SCALA_EXT=.scala
set JAVA_EXT=.java
set PYTHON_EXT=.py
set GOLANG_EXT=.go

REM set CPP_OPTIONS=-std=c++11
set CPP_OPTIONS=
set LIB_FLAGS=
set INCLUDE_DIR=
set LIB_DIR=

REM Change Directory
cd "%DIRNAME%"

IF /I %FILE_EXT% == %CC_EXT%  GOTO __CCOMPILE
IF /I %FILE_EXT% == %CPP_EXT1% GOTO __CPPCOMPILE
IF /I %FILE_EXT% == %CPP_EXT2% GOTO __CPPCOMPILE
IF /I %FILE_EXT% == %CPP_EXT3% GOTO __CPPCOMPILE
IF /I %FILE_EXT% == %GHC_EXT% GOTO __HSKCOMPILE
IF /I %FILE_EXT% == %SCALA_EXT% GOTO __SCALACOMPILE
IF /I %FILE_EXT% == %JAVA_EXT% GOTO __JAVACOMPILE
IF /I %FILE_EXT% == %PYTHON_EXT% GOTO __PYTHONCOMPILE
IF /I %FILE_EXT% == %GOLANG_EXT% GOTO __GOLANGCOMPILE
GOTO END

:__CCOMPILE
echo --- Compiling C Program ... ---

REM -- Check for thread usage
findstr "thread" %FILENAME_EXT% >NUL
if ERRORLEVEL 0 set LIB_FLAGS=%LIB_FLAGS% -lpthread

call %CC_BIN% %FILENAME_EXT%  -o %FILENAME%.exe %LIB_FLAGS% & IF ERRORLEVEL 1 (echo. && echo "ERROR - Compilation Error - Please Fix !!!" ) ELSE echo "Compilation success !!!"
GOTO END

:__CPPCOMPILE
echo --- Compiling C++ Program ... ---

REM -- Check for thread usage
findstr /I "thread" %FILENAME_EXT% >NUL 2>&1
if ERRORLEVEL 1 (
    echo "No Threading..."
) else (
    set LIB_FLAGS=%LIB_FLAGS% -lpthread
)

REM -- Check for OpenGL
findstr /I "OpenGL" %FILENAME_EXT% >NUL 2>&1
if ERRORLEVEL 1 (
    echo "No OpenGL..."
) else (
    set LIB_FLAGS=%LIB_FLAGS% -lglu32 -lopengl32
)

REM -- Check for SFML
findstr /I "sfml" %FILENAME_EXT% >NUL 2>&1
if ERRORLEVEL 1 (
    echo "No SFML"
) else (
    echo "SFML Library ..."
    set LIB_FLAGS=%LIB_FLAGS% -lsfml-graphics -lsfml-window -lsfml-system -lsfml-audio
    set LIB_DIR=%LIB_DIR% -L C:\MyPrograms\lib\SFML-2.5.1\lib
    set INCLUDE_DIR=%INCLUDE_DIR% -I C:\MyPrograms\lib\SFML-2.5.1\include
)

REM -- Check for FLTK
findstr /I "fltk" %FILENAME_EXT% >NUL 2>&1
if ERRORLEVEL 1 (
    echo "No FLTK"
) else (
    echo "FLTK Library ..."
    set LIB_FLAGS=%LIB_FLAGS% -lfltk_forms -lfltk_gl -lfltk_images -lfltk -lfltk_jpeg -lfltk_png -lfltk_z -lpthread -lgdi32 -lole32 -luuid -lcomctl32  -lwsock32 -lsupc++
    set LIB_DIR=%LIB_DIR% -L C:\MyPrograms\lib\fltk-1.3.5\build\lib
    set INCLUDE_DIR=%INCLUDE_DIR% -I C:\MyPrograms\lib\fltk-1.3.5
)

findstr /I "c++11" %FILENAME_EXT% >NUL 2>&1
if ERRORLEVEL 1 (
    REM "C++ Program..."
) else (
    set CPP_OPTIONS=-std=c++11
)

findstr /I "c++17" %FILENAME_EXT% >NUL 2>&1
if ERRORLEVEL 1 (
    REM "C++ Program..."
) else (
    set CPP_OPTIONS=-std=c++17
)

findstr /I "c++20" %FILENAME_EXT% >NUL 2>&1
if ERRORLEVEL 1 (
    REM "C++ Program(20)..."
) else (
    set CPP_BIN=C:\cygwin64\bin\g++
    set CPP_OPTIONS=-std=c++20
)

echo "Compiling : %CPP_BIN% %INCLUDE_DIR% %FILENAME_EXT% -o %FILENAME%.exe %CPP_OPTIONS% %LIB_DIR% %LIB_FLAGS%"

call %CPP_BIN% %INCLUDE_DIR% %FILENAME_EXT% -o %FILENAME%.exe %CPP_OPTIONS% %LIB_DIR% %LIB_FLAGS% & IF ERRORLEVEL 1 (echo. && echo "ERROR - Compilation Error - Please Fix !!!" ) ELSE echo "Compilation success !!!"

GOTO END

:__HSKCOMPILE
echo --- Compiling Haskell Program ... ---
echo %GHC_BIN% --make %FILENAME_EXT%  -o %FILENAME%.exe 
call %GHC_BIN% --make %FILENAME_EXT%  -o %FILENAME%.exe & IF ERRORLEVEL 1 (echo. && echo "ERROR - Compilation Error - Please Fix !!!" ) ELSE echo "Compilation success !!!"
GOTO END

:__SCALACOMPILE
echo --- Compiling Scala Program ... ---
call %SCALA_BIN% %FILENAME_EXT%  & IF ERRORLEVEL 1 (echo. && echo "ERROR - Compilation Error - Please Fix !!!" ) ELSE echo "Compilation success !!!"
GOTO END

:__JAVACOMPILE
echo --- Compiling JAVA Program ... ---
echo "%JAVA_BIN% %FILENAME_EXT%"
call %JAVA_BIN% %FILENAME_EXT%  & IF ERRORLEVEL 1 (echo. && echo "ERROR - Compilation Error - Please Fix !!!" ) ELSE echo "Compilation success !!!"
GOTO END

:__PYTHONCOMPILE
echo --- Compiling Python Program ... ---
echo %PYTHON_BIN% -m py_compile %FILENAME_EXT%
call %PYTHON_BIN% -m py_compile %FILENAME_EXT%  & IF ERRORLEVEL 1 (echo. && echo "ERROR - Compilation Error - Please Fix !!!" ) ELSE echo "Compilation success !!!"
GOTO END

:__GOLANGCOMPILE
echo --- Compiling Go Program ... ---
echo "%GOLANG_BIN% build %FILENAME_EXT%"
call %GOLANG_BIN% build %FILENAME_EXT%  & IF ERRORLEVEL 1 (echo. && echo "ERROR - Compilation Error - Please Fix !!!" ) ELSE echo "Compilation success !!!"
GOTO END

:END
exit /b %ERRORLEVEL%
