@echo off

REM Check Tag
if "%1" == "" GOTO NeedTag

CALL buildCreateTag.bat %1

CALL buildFromTag.bat %1

CALL BuildOWensHMI.bat %1

GOTO Done

:NeedTag
echo.
echo !!!!!!!!   NEED TAG   !!!!!!!!!!
echo Syntax: %0 tag
echo.
GOTO Exit

:Done
echo.
echo Build Done
echo.

:Exit