REM @echo off

REM Check Tag
if "%1" == "" GOTO NeedTag

del /s/f/q pmsoft >nul
rmdir /s/q pmsoft

git clone https://ghes.multibeamcorp.com/System2/pmsoft.git

set msiDir="msi-%1"
mkdir %msiDir%

cd pmsoft
git checkout %1
git show %1 >..\%msiDir%\Tag%1.txt

mkdir OwensDesign.MbProcessModuleHmi\bin
mkdir OwensDesign.MbProcessModuleHmi\bin\Debug

echo %time%] Clean Owens HMI
"C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\devenv.exe" OwensDesign.MbProcessModule.sln /clean
echo %time%] Build Owens HMI
"C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\devenv.exe" OwensDesign.MbProcessModule.sln /build Debug

IF Exist OwensDesign.MbProcessModuleHmi\bin\Debug\*.exe GOTO DoneHMI

echo %time%] 2Nd Build Owens HMI
"C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\devenv.exe" OwensDesign.MbProcessModule.sln /build Debug

:DoneHMI

echo Check HMI exe
dir OwensDesign.MbProcessModuleHmi\bin\Debug\*.exe
echo %time%] Owens HMI Built

cd ..
mkdir %msiDir%\OwensHMI
xcopy /e /v /q pmsoft\OwensDesign.MbProcessModuleHmi\bin\Debug\ %msiDir%\OwensHMI\Debug\

GOTO Done

:NeedTag
echo.
echo !!!!!!!!   NEED TAG   !!!!!!!!!!
echo Syntax: BuildRelease.bat tag
echo.

:Done
echo Build Owens HMI Done
echo.
rem echo msi\Tag%1.txt
rem Type msi\Tag%1.txt
