@echo on

REM Check Tag
if "%1" == "" GOTO NeedTag

git clone https://ghes.multibeamcorp.com/System2/pmsoft.git

set msiDir="msi-%1"
mkdir %msiDir%

echo.
echo.
echo -------- From Tag %1 ----------
echo.
echo.

mkdir %msiDir%

cd pmsoft

git checkout %1

git show %1 >..\%msiDir%\Tag%1.txt

echo %time%] Clean Solution
"C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\devenv.exe" pmsoft.sln /clean
echo %time%] Build Solution
"C:\Program Files\Microsoft Visual Studio\2022\Professional\Common7\IDE\devenv.exe" pmsoft.sln /build Release-Installer
echo %time%] Solution Built

cd ..
echo copy Multibeam.MEBL.ComponentHost.Setup.msi
xcopy /v pmsoft\Multibeam.MEBL.ComponentHost.Setup\Release\Multibeam.MEBL.ComponentHost.Setup.msi %msiDir%
echo copy Multibeam.MEBL.EngineeringGUI.Setup.msi 
xcopy /v pmsoft\Multibeam.MEBL.EngineeringGUI.Setup\Release\Multibeam.MEBL.EngineeringGUI.Setup.msi %msiDir%

echo copy DataCollector
mkdir %msiDir%\DataCollector
xcopy /e /v /q pmsoft\Multibeam.MEBL.DataCollectorService\bin\Release\ %msiDir%\DataCollector\Release\

GOTO Done

:NeedTag
echo.
echo !!!!!!!!   NEED TAG   !!!!!!!!!!
echo Syntax: BuildRelease.bat tag
echo.

:Done
echo Build Done
echo.
echo %msiDir%\Tag%1.txt
echo ............................
Type %msiDir%\Tag%1.txt
