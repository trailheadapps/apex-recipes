@echo OFF
cd %CD%/..

rem Set parameters
set ORG_ALIAS=apex-recipes

@echo:
echo Installing Apex Recipes scratch org (%ORG_ALIAS%)
@echo:

rem Install script
echo Cleaning previous scratch org...
cmd.exe /c sfdx force:org:delete -p -u %ORG_ALIAS% 2>NUL
@echo:

echo Creating scratch org...
cmd.exe /c sfdx force:org:create -s -f config/project-scratch-def.json -d 30 -a %ORG_ALIAS%
call :checkForError
@echo:

echo Pushing source...
cmd.exe /c sfdx force:source:push
call :checkForError
@echo:

echo Assigning permission sets...
cmd.exe /c sfdx force:user:permset:assign -n Apex_Recipes
call :checkForError
@echo:

echo Importing sample data...
cmd.exe /c sfdx force:data:tree:import -p data/data-plan.json
call :checkForError
cmd.exe /c sfdx force:data:tree:import -p data/data-plan2.json
call :checkForError
@echo:

echo Runing Apex setup script...
cmd.exe /c sfdx force:apex:execute --apexcodefile data/setup.apex
call :checkForError
@echo:

rem Report install success if no error
@echo:
if ["%errorlevel%"]==["0"] (
  echo Installation completed.
  @echo:
  cmd.exe /c sfdx force:org:open -p lightning/n/Apex_Recipes
)

:: ======== FN ======
GOTO :EOF

rem Display error if the install has failed
:checkForError
if NOT ["%errorlevel%"]==["0"] (
    echo Installation failed.
    exit /b %errorlevel%
)