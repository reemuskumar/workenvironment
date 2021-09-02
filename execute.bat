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

REM Change Directory
cd "%DIRNAME%"

echo ++++++++++++++++++++++++++++++++++++++++
echo Executing  %FILENAME_EXT%  ...
echo ++++++++++++++++++++++++++++++++++++++++

set CC_BIN=gcc
set CPP_BIN=g++
set GHC_BIN=ghc
set RUBY_BIN=ruby
set PYTHON_BIN=C:\Users\Reemus_Kumar_Vincent\AppData\Local\Programs\Python\Python39\python.exe
set PYTHON27_BIN=python27
set SCALA_BIN=scala.bat
set JAVA_PATH="C:\Reemus Kumar\Softwares\jdk-14.0.2\bin"
set JAVA_BIN=java
set GOLANG_BIN=go


set CC_EXT=.c
set CPP_EXT=.c++
set CPP11_EXT=.cpp
set CPP14_EXT=.cxx
set GHC_EXT=.hs
set PY_EXT=.py
set RUBY_EXT=.rb
set SCALA_EXT=.scala
set JAVA_EXT=.java
set GOLANG_EXT=.go

IF /I %FILE_EXT% == %CPP_EXT% GOTO __CPPEXEC
IF /I %FILE_EXT% == %CPP11_EXT% GOTO __CPP11EXEC
IF /I %FILE_EXT% == %CPP14_EXT% GOTO __CPP14EXEC
IF /I %FILE_EXT% == %CC_EXT%  GOTO __CEXEC
IF /I %FILE_EXT% == %GHC_EXT% GOTO __HSKEXEC
IF /I %FILE_EXT% == %PY_EXT% GOTO __PYTHONEXEC
IF /I %FILE_EXT% == %RUBY_EXT% GOTO __RUBYEXEC
IF /I %FILE_EXT% == %SCALA_EXT% GOTO __SCALAEXEC
IF /I %FILE_EXT% == %JAVA_EXT% GOTO __JAVAEXEC
IF /I %FILE_EXT% == %GOLANG_EXT% GOTO __GOLANGEXEC
GOTO END

:__CEXEC
call %FILENAME%
GOTO END

:__CPPEXEC
findstr /I "sfml" %FILENAME_EXT% > NUL
if ERRORLEVEL 1 (
    echo "No SFML ..." >NUL
) else (
    set PATH="%PATH%";C:\MyPrograms\lib\SFML-2.5.1\bin
)
call %FILENAME%
GOTO END

:__CPP11EXEC
findstr /I "sfml" %FILENAME_EXT% > NUL
if ERRORLEVEL 1 (
    echo "No SFML ...">NUL
) else (
    set PATH="%PATH%";C:\MyPrograms\lib\SFML-2.5.1\bin
)
call %FILENAME%
GOTO END

:__CPP14EXEC
findstr /I "sfml" %FILENAME_EXT% > NUL
if ERRORLEVEL 1 (
    echo "No SFML ...">NUL
) else (
    set PATH="%PATH%";C:\MyPrograms\lib\SFML-2.5.1\bin
)
call %FILENAME%
GOTO END

:__HSKEXEC
call %FILENAME%
GOTO END

:__PYTHONEXEC
call %PYTHON_BIN% %FILENAME_EXT%
GOTO END


:__RUBYEXEC
call %RUBY_BIN% %FILENAME_EXT%
GOTO END

:__SCALAEXEC
call %SCALA_BIN% %FILENAME%
GOTO END

:__JAVAEXEC
SET "PATH=%JAVA_PATH%;%PATH%"
call %JAVA_BIN% %FILENAME%
GOTO END

:__GOLANGEXEC
call %FILENAME%
GOTO END

:END
echo.
echo ++++++++++++++++++++++++++++++++++++++++
echo Execution - Completed !!!
