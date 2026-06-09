
REM Set the version of VectorCAST.
set vectorcast_dir=C:\VCAST\26
REM Set the vcshell db name
set db_filename=module-signal-pool.db
REM Set uvprojx name
REM set uvprojx=uhd.uvprojx

REM Set the location license file
REM Licenses can be read from cache, standard location or location provided here.
REM set VECTOR_LICENSE_FILE=C:\VCAST\FLEXlm\vector-DEMO.lic
REM set LM_LICENSE_FILE=C:\VCAST\FLEXlm\vector-DEMO.lic

REM If connection to a license server is used instead then it will port@server.
REM set VECTOR_LICENSE_FILE=27000@dpre-lpt-1

REM Disable reading from cache. This way the license file is read each time VectorCAST is started.
set LM_APP_DISABLE_CACHE_READ=1

REM Some potential compilers must be set in the path.
REM call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"
set path=%vectorcast_dir%\MinGW\bin;%path%

REM Environment variables can be used inside of VectorCAST.
set SRC_DIR1=%~dp0..\..\

REM Delete and recreate vcshell database
REM del %db_filename%
REM %VECTORCAST_DIR%\vcshell --vcaliases="ArmCC=gcc" --expand=--Via=1 uv4.exe -r -j0 -l build.log %SRC_DIR1%1_source\%uvprojx% --db=%db_filename%

REM Use this to make the folder of this startup.bat the working directory of VectorCAST.
REM This will be the directory of the startup if double clicked.
REM c:
REM cd %~dp0

REM Conventional way of setting the working directory of VectorCAST.
REM One separate folder for each compiler as compiler settings are stored in CCAST_.CFG in the working directory.
REM Compiler settings can not be shared. 

REM Start the GUI version of VectorCAST.
start %vectorcast_dir%\vcastqt -e %~dp0\module-signal-pool\vc_project\module-signal-pool_project.vcm