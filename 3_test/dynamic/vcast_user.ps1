
Write-Host Source the content in the startup script.
.\vcast_env.ps1

Write-Host Use this to make the folder of this startup.bat the working directory of VectorCAST.
Write-Host This will be the directory of the startup if double clicked.
Write-Host c:
Write-Host cd %~dp0

Write-Host Conventional way of setting the working directory of VectorCAST.
Write-Host One separate folder for each compiler as compiler settings are stored in CCAST_.CFG in the working directory.
Write-Host Compiler settings can not be shared. 


Write-Host Start the GUI version of VectorCAST.
& "$env:VECTORCAST_DIR\vcastqt" -lc
