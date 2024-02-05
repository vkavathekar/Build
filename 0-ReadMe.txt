1. Create a build folder, say buildDevel.
2. Copy all files in this folder to above folder
3. Open a CMD window
4. Nagvigate to build folder, such as buildDevel
5. Run BuildRelease.bat <tag>.
   <tag> is the git tag for this build.
6. After complete, two new folders are created in build folder:
   6.1. pmsoft - this folder containa the code for this build
   6.2. msi-<tag> - where the <tag> is the string in previous step.
                    This folder contains all binaries
** Currently "OwensHMI" under the msi folder may not contain Owens HMI app.
   Manually build that app and copy the solution's bin\Debug to OWensHMI\Debug

