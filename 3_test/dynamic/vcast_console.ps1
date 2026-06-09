$DIR=$args[0]
if (!$DIR) {
	$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
	$DIR=$PSScriptRoot
}
$env:WORKSPACE=$DIR

$WAIT_LOOP_CNT=24
$env:VCAST_PROJ='vibro'
$VCM_PROJ=$env:VCAST_PROJ

$VCAST_REPORT=Resolve-Path "$DIR\..\..\1_source\build-uv\VC_Report"

###################################################################################################################################
### Set environmental variables
###################################################################################################################################
& "${DIR}\vcast_env.ps1" | Out-Null

###################################################################################################################################
### Section to adapt chrome headless processing
###################################################################################################################################
Remove-Item "${VCAST_REPORT}" -Recurse -ErrorAction Ignore
New-Item -Path "${VCAST_REPORT}" -ItemType "directory"

& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\managewait.py" --wait_time 30 --wait_loops $WAIT_LOOP_CNT --command_line "--project `"${DIR}\${VCM_PROJ}.vcm`" --status"
& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\managewait.py" --wait_time 30 --wait_loops $WAIT_LOOP_CNT --command_line "--project `"${DIR}\${VCM_PROJ}.vcm`" --force --release-locks"
& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\managewait.py" --wait_time 30 --wait_loops $WAIT_LOOP_CNT --command_line "--project `"${DIR}\${VCM_PROJ}.vcm`" --config VCAST_CUSTOM_REPORT_FORMAT=HTML"
& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\managewait.py" --wait_time 30 --wait_loops $WAIT_LOOP_CNT --command_line "--project `"${DIR}\${VCM_PROJ}.vcm`" --build-execute --incremental --output `"${VCAST_REPORT}\${VCM_PROJ}_rebuild.html`" "

& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\managewait.py" --wait_time 30 --wait_loops $WAIT_LOOP_CNT --command_line "--project `"${DIR}\${VCM_PROJ}.vcm`" --config VCAST_CUSTOM_REPORT_FORMAT=HTML"
& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\generate-results.py" --junit --wait_time 30 --wait_loops $WAIT_LOOP_CNT "`"${DIR}\${VCM_PROJ}.vcm`"" 
& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\managewait.py" --wait_time 30 --wait_loops $WAIT_LOOP_CNT --command_line "--project `"${DIR}\${VCM_PROJ}.vcm`" --full-status=`"${VCAST_REPORT}\${VCM_PROJ}_ut_full_report.html`""
& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\managewait.py" --wait_time 30 --wait_loops $WAIT_LOOP_CNT --command_line "--project `"${DIR}\${VCM_PROJ}.vcm`" --create-report=aggregate   --output=`"${VCAST_REPORT}\${VCM_PROJ}_aggregate_report.html`""
& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\managewait.py" --wait_time 30 --wait_loops $WAIT_LOOP_CNT --command_line "--project `"${DIR}\${VCM_PROJ}.vcm`" --create-report=metrics     --output=`"${VCAST_REPORT}\${VCM_PROJ}_metrics_report.html`""
& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\managewait.py" --wait_time 30 --wait_loops $WAIT_LOOP_CNT --command_line "--project `"${DIR}\${VCM_PROJ}.vcm`" --create-report=environment --output=`"${VCAST_REPORT}\${VCM_PROJ}_environment_report.html`""
& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\managewait.py" --wait_time 30 --wait_loops $WAIT_LOOP_CNT --command_line "--project `"${DIR}\${VCM_PROJ}.vcm`" --full-status > `"${VCAST_REPORT}\${VCM_PROJ}_full_report.txt`""
& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\gen-combined-cov.py" "${VCAST_REPORT}\${VCM_PROJ}_aggregate_report.html" "${DIR}\${VCM_PROJ}.vcm"
& "$env:VECTORCAST_DIR\vpython" "$DIR\vc_scripts\getTotals.py" "${VCAST_REPORT}\${VCM_PROJ}_full_report.txt"

Move-Item -Path "${DIR}\xml_data" -Destination "${VCAST_REPORT}\xml_data"
Move-Item -Path "${DIR}\management" -Destination "${VCAST_REPORT}\management"
Move-Item -Path "${DIR}\${VCM_PROJ}_system_tests_status.html" -Destination "${VCAST_REPORT}\${VCM_PROJ}_system_tests_status.html"