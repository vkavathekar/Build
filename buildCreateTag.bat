@echo on

if "%1" == "" GOTO NeedTag

git clone https://ghes.multibeamcorp.com/System2/pmsoft.git

REM tag
set message="Tag %1 at %date%, %time%"
echo %message%

cd pmsoft

git tag -a %1 -m %message%
git push origin %1

cd..

del /s/f/q pmsoft >nul

rmdir /s/q pmsoft

GOTO Done

:NeedTag
echo.
echo !!!!!!!!   NEED TAG   !!!!!!!!!!
echo Syntax: %0 tag
echo.

:Done
echo.
dir
echo.
echo Make Tag Done
echo.
