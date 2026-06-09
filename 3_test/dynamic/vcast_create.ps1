#############################################################################################################
#############################################################################################################
### 	Put this file inside .\tools\vectorCAST\ folder and launch it
###		Adapt $vcast_name, $keil_name and $VECTORCAST_DIR as needed!
###		Script can be called with parameters to adapt settings
###
###		Script Version: 0.2 
###		Script created by sc3mi
###		Last Modified: 16.03.2020
#############################################################################################################

#######################################################
### Adapt these variables on your needs or pass them via options on commandline!
#######################################################

param(
	[string]$vcast_name='vibro',
	[string]$keil_name='vibro.uvprojx',
	[switch]$gen_tcases,
	[switch]$mcdc
)

#######################################################
### Adapt these settings on your system
#######################################################
$PSScriptRoot = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$DIR=$PSScriptRoot
$VECTORCAST_DIR='C:\VCAST\20sp1'
$Env:SRC_DIR1 = Resolve-Path "${DIR}\..\.."

#######################################################
### Expert settings. Don't modify those settings unless
###	you know what you are doing!
#######################################################
$VCAST_PRJ=$vcast_name
$KEIL_PRJ=$keil_name

#######################################################
### Expert settings. Don't modify those settings unless
###	you know what you are doing!
#######################################################
function main
{
	# Output Configuration
	Write-Host "VCast Project Name: $vcast_name"
	Write-Host "KEIL Project Name:  $keil_name"
	Write-Host "Option Generate TestCases:    $gen_tcases"
	Write-Host "Option Create MCDC TestCases: $mcdc"

	#######################################################
	### Execute build process to collect build information
	#######################################################
	& "$VECTORCAST_DIR\vcshell.exe" --db="${VCAST_PRJ}.db" --vcaliases="ArmCC=gcc" --expand=--Via=1 uv4.exe -r -j0 -l build.log $Env:SRC_DIR1\1_source\${KEIL_PRJ}

	#######################################################
	### Create CCAST_.cfg
	#######################################################
	create_ccast_cfg

	#######################################################
	### Find all *.c source files in database. If there was
	### already a previous run where files found, only
	### add the new files.
	#######################################################
	New-Item -ItemType "directory" -Path "temp"
	& "$VECTORCAST_DIR\vcdb.exe" --db="${VCAST_PRJ}.db" --cfg="." --cmd-verb="ArmCC" getfiles > .\vcdb_out.txt 2>&1

	# check if there was already a successfull run in the past
	$vcdb_result = Test-Path -LiteralPath "${DIR}\${VCAST_PRJ}\vcdb_out.txt"
	if( $vcdb_result -eq $false )
	{
		# Create Project
		& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --cfg="${DIR}\CCAST_.CFG" --create
		& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --level="VectorCAST_MinGW_C/TestSuite" --delete
	}
	else
	{
		# Create a diff of the last run 
		compare-object (get-content "${DIR}\vcdb_out.txt") (get-content "${DIR}\${VCAST_PRJ}\vcdb_out.txt") -PassThru | Out-File "${DIR}\vcdb_temp.txt"
		Remove-Item "${DIR}\${VCAST_PRJ}\vcdb_out.txt"
		Move-Item -Path "${DIR}\vcdb_out.txt" -Destination "${DIR}\${VCAST_PRJ}\vcdb_out.txt"
		Move-Item -Path "${DIR}\vcdb_temp.txt" -Destination "${DIR}\vcdb_out.txt"
	}

	#######################################################
	### Create a test environment for every source file 
	#######################################################
	cd temp
	$last_group = ''
	foreach($line in Get-Content .\..\vcdb_out.txt) {
		$folder = Split-Path -Path $line
		$file = Split-Path -Path $line -Leaf -Resolve
		$group = Split-Path (Split-Path $line -Parent) -Leaf
		
		$cur_dir = Get-Location
		Set-Location $folder
		& "$VECTORCAST_DIR\clicast.exe" -lc ENvironment SCript Quick $file
		Set-Location $cur_dir
		
		# Copy script to local folder
		$env_base = (Get-Item $line ).Basename
		$env_base_upper = $env_base.ToUpper()
		Copy-Item "$folder\\${env_base}.env" -Destination ".\"
		Remove-Item "$folder\\${env_base}.env"
		
		#Import environment in project
		cd ..

		# import environment
		& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" -g "${group}" --level="VectorCAST_MinGW_C/unit_test" --force --import ".\\temp\\${env_base}.env"
		
		#settings on group
		if($group -ne $last_group)
		{
			$last_group = $group
			vcast_set_config_group
		}
		
		vcast_set_config_env
		cd temp
	}

	# Migrate scripts to workspace
	cd ..
	if($gen_tcases -eq $true)
	{
		& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --level "VectorCAST_MinGW_C/unit_test" --build
		& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --level "VectorCAST_MinGW_C/unit_test" --clicast-args tools AUTO_Test_generation temp.tst
		
		if($mcdc -eq $true)
		{
			& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --level "VectorCAST_MinGW_C/unit_test" --clicast-args tools AUTO_Mcdc_test_generation temp.tst
		}
		
		& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --level "VectorCAST_MinGW_C/unit_test" --clicast-args test script run temp.tst 
		& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --level "VectorCAST_MinGW_C/unit_test" --apply-changes --force 
	}

	if( $vcdb_result -eq $false )
	{
		Move-Item -Path "${DIR}\vcdb_out.txt" -Destination "${DIR}\${VCAST_PRJ}\vcdb_out.txt"
	}
	else
	{
		Remove-Item vcdb_out.txt
		Remove-Item "${DIR}\${VCAST_PRJ}\CCAST_.CFG"
	}
	Move-Item -Path "${DIR}\CCAST_.CFG" -Destination "${DIR}\${VCAST_PRJ}\CCAST_.CFG"

	# Set Settings on testsuite
	vcast_set_config_testsuite

	# Cleanup temp folder and logs
	Remove-Item temp -Force -Confirm:$false -Recurse
	Remove-Item build.log

	# Wait for user input
	Write-Host "Script finished"
	pause
}

#######################################################
### Setup config for complete testsuite
#######################################################
function vcast_set_config_testsuite
{
	& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --cfg="${DIR}\${VCAST_PRJ}\CCAST_.CFG" --migrate-to-workspace
	& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --level="VectorCAST_MinGW_C/unit_test" --config="COVERAGE_TYPE=Statement+Branch" 
	& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --level="VectorCAST_MinGW_C/unit_test" --config="VCDB_FILENAME=`$(SRC_DIR1)\3_test\dynamic\${VCAST_PRJ}.db"
	& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --level="VectorCAST_MinGW_C/unit_test" --config="VCDB_CMD_VERB=ArmCC"
	& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --level="VectorCAST_MinGW_C/unit_test" --config="VCAST_FILE_VERSION_COMMAND=svn info"
	& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --level="VectorCAST_MinGW_C/unit_test" --config="C_COMPILER_TAG=BUILTIN_MINGW_63_C"
	& "$VECTORCAST_DIR\manage.exe" -p "${VCAST_PRJ}" --level="VectorCAST_MinGW_C/unit_test" --config="C_COMPILER_CFG_SOURCE=CONFIG_FILE_63"
}

#######################################################
### Setup config for group
#######################################################
function vcast_set_config_group
{
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --config="COVERAGE_TYPE=Statement+Branch" --force
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --config="VCDB_FILENAME=`$(SRC_DIR1)\3_test\dynamic\${VCAST_PRJ}.db" --force
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --config="VCDB_CMD_VERB=ArmCC" --force
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --config="VCAST_FILE_VERSION_COMMAND=svn info" --force
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --config="C_COMPILER_TAG=BUILTIN_MINGW_63_C" --force
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --config="C_COMPILER_CFG_SOURCE=CONFIG_FILE_63" --force
}

#######################################################
### Setup config for environment
#######################################################
function vcast_set_config_env
{
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --migrate-to-workspace --force
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --config="COVERAGE_TYPE=Statement+Branch" --force
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --config="VCDB_FILENAME=`$(SRC_DIR1)\3_test\dynamic\${VCAST_PRJ}.db" --force
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --config="VCDB_CMD_VERB=ArmCC" --force
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --config="VCAST_FILE_VERSION_COMMAND=svn info" --force
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --config="C_COMPILER_TAG=BUILTIN_MINGW_63_C" --force
	& "$VECTORCAST_DIR\manage.exe" --silent -p "${VCAST_PRJ}" -g "${group}" --level "VectorCAST_MinGW_C/unit_test" -e "ENV_${env_base_upper}" --config="C_COMPILER_CFG_SOURCE=CONFIG_FILE_63" --force
}

#######################################################
### Create CCAST_.CFG
#######################################################
function create_ccast_cfg
{
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCDB_FILENAME "`$(SRC_DIR1)\3_test\dynamic\${VCAST_PRJ}.db"
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCDB_CMD_VERB ArmCC
	& "$VECTORCAST_DIR\clicast.exe" -lc option ASM_FUNCS_BEHAVE_AS_INLINES FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option ASSEMBLER_CMD 
	& "$VECTORCAST_DIR\clicast.exe" -lc option AUTO_INCLUDE 
	& "$VECTORCAST_DIR\clicast.exe" -lc option COMREADER_ENABLED FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option COVERAGE_TYPE STATEMENT+BRANCH
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_ALT_COMPILE_CMD 
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_ALT_EDG_FLAGS 
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_ALT_PREPROCESS_CMD 
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_COMPILER_CFG_SOURCE CONFIG_FILE_63
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_COMPILER_FAMILY_NAME 
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_COMPILER_HIERARCHY_STRING VectorCAST MinGW_C
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_COMPILER_OUTPUT_FLAG -o
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_COMPILER_PY_ARGS 
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_COMPILER_TAG BUILTIN_MINGW_63_C
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_COMPILER_VERSION_CMD gcc --version
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_COMPILE_CMD gcc -c -g
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_COMPILE_CMD_FLAG -c
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_COMPILE_EXCLUDE_FLAGS -o**
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_DEBUG_CMD gdb
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_DEBUG_HELP_FILE 
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_DEFINE_FLAG -D
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_DEFINE_LIST VCAST TESSY
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_EDG_FLAGS -w --gcc --gnu_version 60300 --mingw
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_EXECUTE_CMD 
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_EXEC_HELP_FILE 
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_INCLUDE_FLAG -I
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_LINKER_VERSION_CMD ld --version
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_LINK_CMD gcc -g
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_LINK_OPTIONS 
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_OBJECT_EXT .o
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_OUTPUT_FLAG -o
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_PREPROCESS_CMD gcc -E -C
	& "$VECTORCAST_DIR\clicast.exe" -lc option C_PREPROCESS_FILE 
	& "$VECTORCAST_DIR\clicast.exe" -lc option EXECUTABLE_EXTENSION 
	& "$VECTORCAST_DIR\clicast.exe" -lc option MAX_VARY_RANGE 20
	& "$VECTORCAST_DIR\clicast.exe" -lc option PRECOMPILE_CMD 
	& "$VECTORCAST_DIR\clicast.exe" -lc option PRECOMPILE_EXT 
	& "$VECTORCAST_DIR\clicast.exe" -lc option SBF_LOC_MEMBER_IN_NSP DECL_NAMESPACE
	& "$VECTORCAST_DIR\clicast.exe" -lc option SBF_LOC_MEMBER_OUTSIDE_NSP DECL_NAMESPACE
	& "$VECTORCAST_DIR\clicast.exe" -lc option SBF_LOC_NONMEMBER_IN_NSP DECL_NAMESPACE
	& "$VECTORCAST_DIR\clicast.exe" -lc option SBF_LOC_NONMEMBER_OUTSIDE_NSP DECL_NAMESPACE
	& "$VECTORCAST_DIR\clicast.exe" -lc option SOURCE_EXTENSION .c
	& "$VECTORCAST_DIR\clicast.exe" -lc option SUBSTITUTE_CODE_FOR_C_FILE FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_ALT_WB_METHOD FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_ASSEMBLY_FILE_EXTENSIONS s
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_ASSIGN_WITHOUT_COPY_CTOR TRUE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_AUTO_CLEAR_TEST_USER_CODE FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_AVOID_COMMA_OPERATOR FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_BUFFER_OUTPUT FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_COLLAPSE_STD_HEADERS COLLAPSE_SYSTEM_HEADERS
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_COMMAND_LINE_DEBUGGER TRUE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_COMPILER_SUPPORTS_CPP_CASTS FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_COVERAGE_FOR_AGGREGATE_INIT TRUE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_C_FILE_EXTENSIONS c
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_DISABLE_CPP_EXCEPTIONS FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_DISABLE_STD_STRING_DETECTION FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_DISABLE_STD_WSTRING_DETECTION TRUE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_DISABLE_TI_BITFIELD FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_DISABLE_TI_STRING FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_DISPLAY_UNINST_EXPR FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_DUMP_BUFFER FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_ENABLE_FUNCTION_CALL_COVERAGE FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_ENVIRONMENT_FILES 
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_ESCAPE_LINE_DIRECTIVES FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_EXECUTE_WITH_STDIO FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_EXECUTE_WITH_STDOUT FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_FAR_STDIN_DATA FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_FILE_INDEX TRUE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_FILE_PREFIX 
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_FILE_VERSION_COMMAND svn info
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_FORCE_ELAB_TYPE_SPEC TRUE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_FORCE_NO_USERGLOBALS FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_GH_INTEX_CMD 
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_GH_INT_FILE 
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_HAS_LONGLONG TRUE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_INST_FILE_MAX_LINES 0
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_MAIN FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_MAX_COVERED_SUBPROGRAMS 1000
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_MAX_HEAP_SIZE 1000
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_MAX_MCDC_STATEMENTS 1000
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_MAX_STRING_LENGTH 1000
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_MICROSOFT_LONG_LONG FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_MINIMAL_TERMINATION FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_NO_EXIT FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_NO_FFLUSH FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_NO_FLOAT FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_NO_LIMITS FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_NO_LONG_DOUBLE TRUE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_NO_MALLOC FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_NO_SETJMP FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_NO_SIGNAL FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_NO_STDIN FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_NO_STDLIB FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_NO_STD_FILES FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_OUTPUT_BUFFER_SIZE 20000
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_PREPEND_TO_PATH_DIRS "${VECTORCAST_DIR}\MinGW\bin"
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_PREPROCESS_PREINCLUDE 
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_REMOVE_PREPROCESSOR_COMMENTS TRUE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_STDIO FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_TYPEOF_OPERATOR TRUE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_USE_COMPOUND_FOR_BATCH FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_USE_EDG_PREPROCESSOR FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_USE_STATIC_MEMORY FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_USE_STD_STRING TRUE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_USE_VCPP FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option VCAST_VXWORKS FALSE
	& "$VECTORCAST_DIR\clicast.exe" -lc option WHITEBOX YES 
}

#Entry Point for Script
main
exit 0