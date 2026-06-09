Write-Host Set the version of VectorCAST.
$env:VECTORCAST_DIR="C:\VCAST\21"
$env:VCAST_RPTS_PRETTY_PRINT_HTML='TRUE'
$env:VCAST_RPTS_SELF_CONTAINED='FALSE'
$env:WORKSPACE=$PSScriptRoot
$env:VCAST_PROJ="vibro"
Write-Host Set the location license file
Write-Host Licenses can be read from cache, standard location or location provided here.
Write-Host set VECTOR_LICENSE_FILE=C:\VCAST\FLEXlm\vector-DEMO.lic
Write-Host set LM_LICENSE_FILE=C:\VCAST\FLEXlm\vector-DEMO.lic

Write-Host If connection to a license server is used instead then it will port@server.
Write-Host set VECTOR_LICENSE_FILE=27000@dpre-lpt-1

Write-Host Disable reading from cache. This way the license file is read each time VectorCAST is started.
$env:LM_APP_DISABLE_CACHE_READ = '1'

Write-Host Some potential compilers must be set in the path.
Write-Host call "C:\Program Files (x86)\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"
$old_path = $env:path
$env:path = "$env:VECTORCAST_DIR\MinGW\bin;$old_path"

Write-Host Environment variables can be used inside of VectorCAST.
$env:SRC_DIR1 = Resolve-Path "${env:WORKSPACE}\..\.."

Set-Location 
Write-Host Rebase Database to a file of current folder
$vcdb_result = &"${env:VECTORCAST_DIR}\vcdb" --db="${env:WORKSPACE}\${env:VCAST_PROJ}.db" --file=vibro.c getfilename
foreach ($line in $vcdb_result)
{
    Write-host "$line"
	&"${env:VECTORCAST_DIR}\vcdb" --db="${env:WORKSPACE}\${env:VCAST_PROJ}.db" rebase --from="$line" --to="${env:SRC_DIR1}\1_source\srv\vibro.c"
}