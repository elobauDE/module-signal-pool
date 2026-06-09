rem ---------------------------------------------
rem -- Copyright 2020 Vector Informatik, GmbH. --
rem ---------------------------------------------
rem This is a simple .bat file that can be used to provide
rem double click access to all of the tasks associated with using
rem the VectorCAST Automation controller

@echo off

rem Set-up the path to the VectorCAST installation
set vectorcast_dir=c:\vcast\26
set path=%vectorcast_dir%\mingw\bin;%path%

 
rem Use the V: drive to point to the current working directory
rem This makes the VectorCAST projects that we build portable,
if EXIST V:\\NUL subst /d v:
subst v: %CD%\..\..

rem Switch to the V: drive, and CD to the top
v:
cd \3_test\dynamic

rem Start a command shell for the user
echo ----------------------------------------------------------------
echo Use this command to start the automation controller:
echo     %vectorcast_dir%\vpython startAutomation.py --interactive
echo ----------------------------------------------------------------
cmd /k

rem un-map any drives that were used
subst /d v:

exit

