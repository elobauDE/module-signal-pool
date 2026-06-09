#---------------------------------------------
#-- Copyright 2022 Vector Informatik, GmbH. --
#---------------------------------------------


import queue
import argparse
import contextlib
import glob
import os
import platform
import re
import shutil
import shlex
import subprocess
import sys
import tempfile
import threading
import time
import traceback
import json

from vector.lib.core import VC_Status
from vector.lib.core.system import get_vectorcast_install_dir
from xml.etree.ElementTree import ElementTree

'''
This is a quick-start utility that uses operates on an exiting vcshell.db to:

    Create a coverage project for all files in the database
    Instrument these files for a particular level of coverage
    
    Create Unit Test Environment Scripts
    
    Create a Manage Project with all of those pieces
    
    Build a subset of the test environments
    
    Create Basis Path test for those environments

'''

toolName = 'VectorCAST-QuickStart Utility'

globalCoverageProjectExists=True
globalParallelInstCoverProject=""

# Parameter Default
parameterNotSetString = '<notset>'

# To make the building as fast as possible, these values allow us to  only process
# a sub-set of the files that exist in the vcshell.db to increase speed
maximumFilesToSystemTest=sys.maxsize
maximumFilesToUnitTest=sys.maxsize
maximumUnitTestsToBuild=0

# This file contains the list of source files to process for this pass
listOfFilenamesFile = 'vcast-latest-filelist.txt'
# This file will contain the cumulative list of files in the project
listOfFilesInProject = 'vcast-inproject-filelist.txt'
listOfEnvironmentsInProject = 'vcast-inproject-envirolist.txt'

vcWorkArea='vcast-workarea'
vcshellDbName='vcshell.db'
vcshellCommandVerb='ArmClang'
vcManageDirectory='vc_project'
vcCoverDirectory='vc_coverage'
vcScriptsDirectory='vc_ut_scripts'
vcHistoryDirectory='vc_history'
vcPrepDirectory='vc_prep'
vcPrepMap = "prepared_files.json"
vcEnterpriseMode = False
addBasisPathTest = True
useParallelInst = False

# These global are set for each run of the utiltity
# compilerNodeName is the location where we will insert new environments
defaultCompilerNodeName = 'UnitTestingCompilerNode'
compilerNodeName = defaultCompilerNodeName
# currentLanguage controls the name of the test suites and groups
currentLanguage = 'none'

# Unit Test Configuration Files
ADA_CONFIG_FILE = 'ADACAST_.CFG'
C_CONFIG_FILE = 'CCAST_.CFG'

# Controls the output of the stdout from all VectorCAST commands
verboseOutput = False

# Controls the updating of system_test.py
globalUpdateSystemTestPy = True

# Controls the failing/continuing of the scripts after a VectorCAST command fails
globalAbortOnError = False

#Control whether envscript.py needs to be called with --blackbox 
globalBlackBoxEnv = False

# These variables are constructed from the --projectname arg
coverageProjectName=""
manageProjectName=""

# This is the startup directory where the script is being run
originalWorkingDirectory=os.getcwd()
cfgFileLocation=os.getcwd()

#IncludePath Override include and exclude paths
excludeList = []
includeList = []

# This is the location of the vcshell.db file, passed in by the caller
# It might be the same as the originalWorkingDirectory
vcshellDBlocation=''


# This is the make command info from the database
topLevelMakeCommand = ''
topLevelMakeLocation = ''
applicationList = []


clicastVersion = ''
vcInstallDir = get_vectorcast_install_dir()
locationOfInstrumentScript=os.path.join (vcInstallDir,'python','vector','apps','vcshell')
pathToUnInstrumentScript=os.path.join (vcInstallDir,'python','vector','apps','AutomationController','UnInstrument.py')
pathToEnvCreateScript=os.path.join (vcInstallDir,'python','vector','apps','vcshell','EnvCreate.py')

listOfAllFiles = []    # List of all files in the DB
listOfFiles = []       # List of files selected for addition
listOfAddedFiles = []  # List of files added
listOfPaths = []       # List of paths from DB

# Contains the status message to display at the end of the run
summaryStatusFileHandle = 0


class VCCommandError(Exception):
    """ Raised when a VectorCAST Command fails to complete successfully. """

class FlexLMError(VCCommandError):
    """ Raised when a VectorCAST Command is not licensed. """



def setVcWorkArea(vcastWorkArea):
    '''
        Api to set the global variables vcastWorkArea
    '''
    global vcWorkArea
    vcWorkArea=vcastWorkArea

def setVcshellDbName(vcshellDB):
    '''
        Api to set the global variable vcshellDbName
    '''
    global vcshellDbName
    vcshellDbName=vcshellDB

def setVcshellCommandVerb(vcshellCmdVerb):
    '''
    Api to set the global variable vcshellCommandVerb
    None represents using the default verb for the compiler cfg
    '''
    global vcshellCommandVerb
    vcshellCommandVerb=vcshellCmdVerb

def addToSummaryStatus (message):
    '''
    This is just a wrapper so that we can capture the main status messages for
    display at the end of the process
    '''
    global summaryStatusFileHandle

    print(message)

    if not summaryStatusFileHandle:
        return

    summaryStatusFileHandle.write(message + '\n')
    summaryStatusFileHandle.flush()


def sectionBreak (message):
    print('\n\n')   
    print('-' * 78)
    print('-' * 78)
    if len (message) > 0:
        print(message)
        print('-' * 78)
        print('-' * 78)
    
    
def getTimeString (milliSeconds):
    '''
    Convert a milliseconds float value to a seconds string
    '''
    seconds = milliSeconds/1000
    if seconds > 60: 
        return "%1.1f " % (seconds/60) + ' minutes'
    else:
        return "%1.1f " % (seconds) + ' seconds'
        
    
def fatalError (errorString):
    print(errorString);
    print ('Terminating ...\n\n')
    raise Exception ('VCAST Termination Error')    
    

_cached_is_cuda = None

def isCuda():
    """
    Return a boolean indicating if the CCAST_.CFG in the current
    directory specifies a CUDA configuration. 

    Determined by looking for one of the following in C_DEFINE_LIST:
        VCAST_GPGPU (preferred)
        VCAST_CUDA (legacy projects)
    """
    # only calculate once
    global _cached_is_cuda
    if _cached_is_cuda is None:
        defineList = readCFGoption ('C_DEFINE_LIST')
        _cached_is_cuda = ("VCAST_GPGPU" in defineList or 
                "VCAST_CUDA" in defineList)
    return _cached_is_cuda


def queued_pipe_reader(pipe, queue):
    """
    Iterates through the available lines in the pipe and puts them to the queue.

    Args:
        pipe: The pipe to iteratively read lines from.
        queue: The queue to put read lines to.
    """
    try:
        with pipe:
            # Iterate through the pipe until the pipe is closed (i.e., EOF is
            # received). When the pipe is open, this blocks until a line is
            # available in the pipe buffer.
            for line in iter(pipe.readline, ''):
                queue.put((pipe, line))
    finally:
        # Put a None object in the queue to indicate that the pipe is closed.
        queue.put(None)

    
def runVCcommand(command, abortOnError=False, cwd=None):
    """Spawn a child process for the given VectorCAST command.

    Args:
        command: The VectorCAST command to be spawned. Note: The VectorCAST
                 install directory (vcInstallDir) is prepended to the command
                 before it is spawned.

        abortOnError: If true, an exception is raised when a non-zero exit code
                      is returned from the child process. Note: If the global
                      abort-on-error variable (globalAbortOnError), then an
                      exception will be raised for a non-zero exit code
                      regardless of the value for this parameter.

    Returns:
        output_lines: A string of all stdout and stderr lines from the child
                      process.
        exit_code: The exit code of the spawned child process.

    Raises:
        Exception: An exception is raised if (1) a licensing error occurs,
                   (2) the child process encounters a project lock conflict, or
                   (3) abort-on-error (local or global) is enabled and a
                   non-zero exit code is returned from the child process.
    """
    output_lines, exit_code = __toVCcommandStatus(command, cwd)
    if exit_code != 0:
        if abortOnError or globalAbortOnError:
            print('   Command returned a non-zero exit code: {}'
                .format(exit_code))
            print('   stdout/stderr =>')
            print(output_lines)
            raise VCCommandError('VectorCAST command failed')

    return output_lines, exit_code

def __toVCcommandStatus(command, cwd=None):
    vc_command = os.path.join(vcInstallDir, command)
    print('   running command: {}'.format(vc_command))
    p = subprocess.Popen(vc_command, stdout=subprocess.PIPE,
                         stderr=subprocess.PIPE, encoding='utf-8',
                         shell=True, bufsize=1,
                         cwd=cwd)
    q = queue.Queue()
    threading.Thread(target=queued_pipe_reader, args=[p.stdout, q]).start()
    threading.Thread(target=queued_pipe_reader, args=[p.stderr, q]).start()
    # We iterate through the queue (blocking when the queue is empty) until
    # a None object is fetched. The None object signals the closure of one pipe.
    # This is done twice (i.e., range(2)) to ensure the  closure of both pipes
    # (p.stdout and p.stderr). The scope of the each of the launched threads is
    # limited to the scope of its target (the queued_pipe_reader function).
    # Therefore, reaping of the two expected None objects is functionally
    # equivalent to joining the threads; only the main thread remains at the
    # end of the loop.
    stdout_lines = stderr_lines = ''
    for _ in range(2):
        for source, line in iter(q.get, None):
            if source == p.stderr:
                stderr_lines += line
                sys.stderr.write(line if verboseOutput else '.')
            else:
                stdout_lines += line
                sys.stdout.write(line if verboseOutput else '.')
    # Wait for the spawned child process to complete.
    exit_code = p.wait()
    # We join the stdout and stderr lines, in that order, to match legacy
    # behavior where stdout lines are presented before those from stderr.
    output_lines = stdout_lines + stderr_lines
    sys.stdout.write('\n')
    if 'FLEXlm Error:' in output_lines:
        print('FLEXlm error while running VectorCAST command')
        print(re.search('FLEXlm Error:(.*)\n', output_lines).group(1))
        raise FlexLMError('FLEXlm Error')
    elif 'Unable to obtain read lock' in output_lines:
        print('   work-area: "{}"'.format(os.getcwd()))
        print('   Project "{}" is locked by another user.'
            .format(manageProjectName))
        print('   Close this connection or choose a different work-area.')
        fatalError('Work-area Project is locked')

    return output_lines, exit_code
    

def readCFGoption (optionName):
    '''
    This function will look for optionName in the local directory
    CCAST_.CFG file and return the value.  If the option is not
    found or there is not a CCAST_.CFG file we return ""
    '''
    optionValue, exitCode = __toVCcommandStatus('vcutil -lc get_option ' + optionName)
    if exitCode == 0:
        return optionValue.rstrip('\n')
    else:
        return ''
       
def readAdaCFGoption (optionName):
    ''' 
    vcutil does not work for ada ...
    '''
    cfgFile = open (ADA_CONFIG_FILE, 'r', encoding='utf-8')
    for line in cfgFile.readlines():
        if line.startswith (optionName+':'):
            return line.split (':')[1].strip()

    
def runPythonScript (scriptLocation, scriptFile, argString):
    '''
    This function will dynamically import and call a python script
    rather than starting vpython.  Hopefully this is faster
    
    Leaving this un-used for now.
    '''
    # Dynamically import the correct python file
    sys.path.append (scriptLocation)
    pyFile = __import__(scriptFile)
    
    argList = [scriptFile]
    argList += argString.split()
    sys.argv = argList
    pyFile.main()

def get_backup_filename(original_filename):
    return original_filename + '.vcast.bak'

class UnInstrumentSourceFilesCommand:

    def execute(self, list_of_sources_file):
        with open(list_of_sources_file, 'r', encoding='utf-8') as f:
            sources = f.read().splitlines()

        [self.__uninstrument(source) for source in sources]

    def __uninstrument(self, source):
        # "Uninstrument" source by restoring backup to original
        self.__move(get_backup_filename(source), source)

        # [DEPRECATED: May be removed in future versions]
        # Remove any legacy CUDA workflow files that happen to exist
        self.__remove(get_legacy_cuda_filename(source))

    def __move(self, source, destination):
        if not os.path.isfile(source):
            return

        shutil.copy(source, destination)
        os.remove(source)

    def __remove(self, path):
        if os.path.isfile(path):
            os.remove(path)

def unInstrumentSourceFiles():
    '''
    This function will spin through the files in listOfFilesInProject and
    un-instrument them.

    Note: This will also restore the original source for any prepared CUDA
    aggregator files, which will cause a warning if one subsequently tries
    to un-split. However, since restoring the aggregator is the last
    action done during un-split this is actually okay.
    '''
    existingFiles = os.path.join(
        originalWorkingDirectory,
        vcWorkArea,
        listOfFilesInProject)
    if os.path.isfile(existingFiles):
        UnInstrumentSourceFilesCommand().execute(existingFiles)
    else:
        runVCcommand('vpython %s' % pathToUnInstrumentScript)


def unPrepareSourceFiles(): 
    '''
    This function will spin through the list of listOfFilesInProject
    un-split any that were processed by the GPU workflow scripts.

    Note: This function is not called during uninstrument, as that
    workflow takes the more pragmatic approach of just restoring the
    aggregator units and blasting the prep_dir.
    '''
    prep_dir = os.path.join(originalWorkingDirectory, vcWorkArea, vcPrepDirectory)

    if not os.path.isdir(prep_dir):
        # Prep dir is missing; not much we can do
        addToSummaryStatus(f"    warning: Cannot find preparation directory {prep_dir}")
        return

    # The vcshell.db database 
    db_file = os.path.join(vcshellDBlocation, vcshellDbName)

    # List of files added to the coverage project
    # 
    # Notes:
    # 1. listOfFilesInProject is the path to a file containing
    #    a list of the original source files added to the project
    #    (i.e. not the CUDA-prepared files that might actually be
    #    included). In order to use this list for reversing the
    #    CUDA preparation, we also need a source for determining
    #    what variants were prepared. See logic below. 
    # 
    # 2. The list is cumulative across multiple runs of the
    #    AutomationController and (assuming no corruption or
    #    manual modifications to the project) should be authoritative.
    #    (A more reliable approach would be to query the project
    #    directly using the DataAPI, but currently AC does not use
    #    DataAPI, so it's perhaps not worth adding the extra
    #    dependency if this method works.)
    filelist_file = os.path.join(originalWorkingDirectory, vcWorkArea, listOfFilesInProject)

    # The (un)prepare script
    script_dir = os.path.join(os.environ["VECTORCAST_DIR"], "DATA", "cuda")
    script_name = os.path.join(script_dir, "prepare_multiple_issue_source.py")

    # Determine arguments for prepare script
    script_args = []
    if os.path.isfile(db_file):
        # Preferred method: If we have access to the vcshell
        # database and (optionally) file list, then we can
        # call the prepare script directly with options mirroring
        # the preparation done in __build_coverage_project.
        # The database is used to determine what variants were
        # previously prepared. (Assumption: The database has not been
        # updated/modified since the files were prepared.)
        script_args.append(f"--db={db_file}")

        # Use file list if present. Skip if it's not there.
        # (Prepare script will attempt to un-split all files in DB)
        if os.path.isfile(filelist_file):
            script_args.append(f"--filelist={filelist_file}")

        # Lastly, we need --prep_dir and --reverse, but those are
        # provided as we catch up...

    # Alternative method: If we're missing the database, then we 
    # can proceed with just the --prep_dir, and the prepare script
    # will inspect the "config" units in that directory to derive
    # the original file list. 
    # In this usage, it's important NOT to include --filelist, as
    # that would block the prepare script logic that that derives
    # the prepared variants from the preparation directory.
    script_args.append(f"--prep_dir={prep_dir}")

    # Add --reverse to un-prepare
    script_args.append("--reverse")
    arg_string = " ".join(script_args)

    # Call script
    cmd = f'vpython {script_name} {arg_string}'

    # Ensure that script ran to completion
    stdOut, exitCode = runVCcommand(cmd)
    if exitCode != 0: 
        fatalError(f"ERROR: Cannot reverse preparation:\n{stdOut}")


def filterTheFileList (fullFileList):
    '''
    This function takes in the full list of files from the vcshell.db and
    filters it down to the files of interest for the current run.  The 
    first filter is to remove any files that already exist in the cover
    project, the second filter is based on the user-supplied: maximumFilesToSystemTest
    '''

    global maximumFilesToSystemTest
    localFileList = fullFileList[:]
    listItemsToRemove = []
    fileCount = 0
    
    # First step is to remove any files that are already in the coverage project
    if os.path.isdir (os.path.join (originalWorkingDirectory, vcWorkArea)):
        existingFiles = os.path.join (originalWorkingDirectory, vcWorkArea, listOfFilesInProject)
        if os.path.isfile (existingFiles):
            addToSummaryStatus ('   checking the existing project files ... ')
            oldFile = open (existingFiles, 'r', encoding='utf-8')
            lines = oldFile.readlines()
            for line in lines: 
                strippedLine = line.strip()
                if strippedLine in localFileList:
                    localFileList.remove (strippedLine)
    
    # If we have more files than the requested max, then truncate.
    if len (localFileList) > maximumFilesToSystemTest:
        # take the first N files
        addToSummaryStatus ('   limiting file list to (MAXIMUM_FILES_TO_SYSTEM_TEST)=' + str (maximumFilesToSystemTest))
        localFileList = localFileList[0:maximumFilesToSystemTest]
      
    return localFileList


def writeFileListToFile (list):
    
    global listOfFilenamesFile
    
    listFile = open (listOfFilenamesFile, 'w', encoding='utf-8')
    for file in list:
        listFile.write (file + '\n')
    
    listFile.close()
    

def initializeCFGfile (compilerCFG, vcdbFlagString):
    ''' 
    This function will create a CCCAST_.CFG file in the 
    originalWorkingDirectory.  This file will either be created from
    the compilerCFG which will be either a VC template name of the
    path to an existing CFG file.  This will allow the rest of
    the tool to use: os.path.join (originalWorkingDirectory, C_CONFIG_FILE)
    as the correct file
    '''
    
    if os.path.isfile (compilerCFG):
        # If the user passed in the location of the local CCAST_.CFG 
        # we don't need to do anything
        if os.path.isfile (C_CONFIG_FILE) and (os.stat(compilerCFG) == os.stat(C_CONFIG_FILE)):
            pass
        else:
            shutil.copyfile(compilerCFG, C_CONFIG_FILE)
    else:
        stdOut, exitCode = runVCcommand ('clicast -lc template ' + compilerCFG, True)
        
    # Now setup any command over-rides that are requested by the configuration
    # By doing the option changes here we are setting the value in the base CCAST_.CFG
    # which gets copied everywhere in the vcast-workarea.
    stdOut, exitCode = runVCcommand ('clicast -lc option vcast_vcdb_flag_string ' + vcdbFlagString)
    
    
def getCFGfile ():
    '''
    This function will copy the CFG from the orignalWorkingDirectory
    to the current working directory.  We delete any existing CFG
    files in the destination area, so that we only have the CCAST
    or the ADACAST depending on the type of enviro we are adding.
    '''
    global cfgFileLocation
    
    cfgFile = os.path.join (cfgFileLocation, C_CONFIG_FILE)
    # if there is a local file, and it is the one we want then do nothing
    if os.path.isfile(cfgFile):
        if os.path.isfile (C_CONFIG_FILE) and (os.stat (cfgFile) == os.stat (C_CONFIG_FILE)):
            pass
        elif os.path.isfile (cfgFile):
            shutil.copyfile(cfgFile, C_CONFIG_FILE)
    cfgFile = os.path.join (cfgFileLocation, ADA_CONFIG_FILE)
    if os.path.isfile(cfgFile):
        if os.path.isfile (ADA_CONFIG_FILE) and (os.stat (cfgFile) == os.stat (ADA_CONFIG_FILE)):
            pass
        elif os.path.isfile (cfgFile):
            shutil.copyfile(cfgFile, ADA_CONFIG_FILE)
    
    
    

def buildWorkarea():

    global coverageProjectName
    global manageProjectName

    workAreaPath = os.path.join (os.getcwd(), vcWorkArea)
    
    # Pre September 2017 we use vc_manage to store the manage project
    # Now we use vc_project ... to handle this, we check for this case
    # and delelete the old vcast-workarea if necessary
    addToSummaryStatus ('Checking for old work-area ...')
    oldPath = os.path.join (workAreaPath, 'vc_manage')
    if os.path.isdir (oldPath):
       addToSummaryStatus ('   removing old work-area instance')
       shutil.rmtree (workAreaPath)

    createWorkspace = True
    # If we already have a workarea
    if os.path.isdir (workAreaPath):
        # check to make sure the .vcm file is present
        # build_vce does not add empty cover project, so manage created
        # using automation controller need not always contain cover project
        fullManageProject = '{}.vcm'.format(
            os.path.join(workAreaPath, vcManageDirectory, manageProjectName))
        if os.path.isfile(fullManageProject):
            # if they are, use them and update ...
            addToSummaryStatus('   found existing work area')
            os.chdir(vcWorkArea)
            projectMode = 'update'
            createWorkspace = False
        else:
            addToSummaryStatus(
                'The workspace seems to be corrupted, deleting ...')
            dirs = [vcCoverDirectory, vcManageDirectory, vcScriptsDirectory,
                    vcHistoryDirectory, vcPrepDirectory]
            for dir_ in dirs:
                fullDir = os.path.join(workAreaPath, dir_)
                print('   Trying to delete: {}'.format(fullDir))
                if os.path.isdir(fullDir):
                    shutil.rmtree (fullDir)
            createWorkspace = True

    # If we need to create workspace - do it here
    if createWorkspace: # create the workarea
        projectMode = 'new'
        addToSummaryStatus ('   creating new work area ...')
        addToSummaryStatus ('   location: ' + os.getcwd())
        #Create directory recursively 
        try:    
            os.makedirs(vcWorkArea)
        except:
            pass
        os.chdir(vcWorkArea)
        os.mkdir(vcCoverDirectory)
        os.mkdir(vcManageDirectory)
        os.mkdir(vcScriptsDirectory)
        os.mkdir(vcHistoryDirectory)
        os.mkdir(vcPrepDirectory)
        
    return projectMode

def vcshellDBarg (force=False, cfgFile=False):
    '''
    This function will return the "--db path" arg to be passed
    to the vcdb command when the location of the vcshell.db is NOT
    the same as the current working directory
    '''
    global vcshellDBlocation
    global originalWorkingDirectory
    global cfgFileLocation

    retVal = ""

    if force or vcshellDBlocation!=originalWorkingDirectory or vcshellDbName!='vcshell.db':
        retVal = '--db=' + os.path.join (vcshellDBlocation, vcshellDbName)
    else:
        retVal =""

    # pass in the CFG file if it has been specified
    if len(cfgFileLocation) > 0:
        cfg = cfgFileLocation
        if cfgFile:
           cfg = os.path.join(cfg, C_CONFIG_FILE)
        retVal = retVal + " --cfg=" + cfg

    return retVal

def vcshellVerbArg():
    '''
    Returns the " --cmd-verb=<verb>" arg to be passed to a vcdb command. If no
    command verb is configured an empty string is returned. The arg will be
    preceded by a space.
    '''
    retVal = ''

    if vcshellCommandVerb:
        retVal += ' --cmd-verb=' + vcshellCommandVerb

    return retVal

def normalizePath (path):
    '''
    This function will a path to be all lower case if we are on windows
    '''
    if os.name == 'nt':
        return path.lower()
    else:
        return path


def handleIncludePathOverRide(includePathOverRide):
    '''
    Use the include path over-ride parameter to 
    ensure that the directory types are set properly in the db
    '''
    global excludeList
    global includeList
    for dir_ in includePathOverRide:
        # Any paths with the NONE qualifier should be omitted
        pathType = dir_[1].upper()
        if pathType == 'NONE':
            # Only need to exlude if it is in the DB
            currentPath = normalizePath(dir_[0])
            if inListOfPaths(currentPath):
                excludeList.append(currentPath)
            
        # Only modify the directories that are in the database. Some of the
        # directories in the includePathOverRide list might be "adds"; in this
        # case this function call will return false.
        elif setTypeCommandNeeded(dir_):
            fullCommand = 'vcdb {} setpathtype {} {}'.format(
                vcshellDBarg(force=True), dir_[0], pathType)
            stdOut, exitCode = runVCcommand(fullCommand)
        else:
            # if we get here then this is a new directory so save it to the list
            # along with the type
            currentPath = normalizePath(dir_[0])
            # Use a tuple so that we maintain the path type
            includeList.append((currentPath, pathType))


_cached_use_legacy_cuda_workflow = None

def useLegacyCudaWorkflow():
    """
    Return a boolean indicating if the CCAST_.CFG in the current
    directory specifies that the legacy CUDA workflow should be used.
    This workflow is deprecated, and should NOT be used by most users.

    Determined by looking for VCAST_LEGACY_CUDA defined in the CCAST_.CFG
    C_DEFINE_LIST. This is the one and only way to enable and use the
    legacy workflow anymore.
    """
    # only calculate once
    global _cached_use_legacy_cuda_workflow
    if _cached_use_legacy_cuda_workflow is None: 
        defineList = readCFGoption ('C_DEFINE_LIST')
        _cached_use_legacy_cuda_workflow = "VCAST_LEGACY_CUDA" in defineList
    return _cached_use_legacy_cuda_workflow


def initialize(compilerCFG, filterFunction, vcdbFlagString, filesOfInterest,
               includePathOverRide):

    global listOfPaths
    global vcshellDBlocation
    
    
    projectMode = ''
    fullFileList = []
    fullPathList = []
    sectionBreak ('')
    
    startMS = time.time()*1000.0
 
    # Generate the compiler configuration file
    initializeCFGfile (compilerCFG, vcdbFlagString)

    # [DEPRECATED: May be removed in future versions]
    if useLegacyCudaWorkflow():
        initializeCudaArtifacts ( compilerCFG )

        # Since we go through this function exactly once, now is a good 
        # time to indicate that this workflow is deprecated without
        # being annoying about it.
        addToSummaryStatus("WARNING: Using legacy CUDA workflow (VCAST_LEGACY_CUDA). " +
            "This workflow is deprecated and may be removed in the future. Please " +
            "contact Vector Support to discuss options for upgrading your workflow."
        )

    # update to include vcdb name in report
    addToSummaryStatus('Validating {} ...'.format(vcshellDbName))
    if os.path.isfile (os.path.join (vcshellDBlocation, vcshellDbName)):
        # check the verb now, since the next validation uses it
        if vcshellCommandVerb:
            addToSummaryStatus(
                'Validating Command Verb {} ...'.format(vcshellCommandVerb))
            stdOut, _ = runVCcommand ('vcdb '
                                      + vcshellDBarg()
                                      + ' dumpverbs', True)
            for verb in vcshellCommandVerb.split(','):
                if os.path.expandvars(verb) not in stdOut:
                    # This call will exit the program
                    fatalError('Cannot find command verb: {0}, please specify '
                               'a valid command verb.\n Please use a verb or '
                               'comma separated list of verbs from this list: '
                               '{1}\n'.format(verb, stdOut.replace('\n', ',')))

        setupGlobalFileListsFromDatabase(filterFunction, filesOfInterest, vcshellDBarg() + vcshellVerbArg())

        # Create a global list of all of the directory paths in the DB
        stdOut, exitCode = runVCcommand ('vcdb ' + vcshellDBarg() + ' getpaths', True)
        fullPathList = stdOut.split('\n')
        
        for path in fullPathList:
            # We get some blank lines from the getpaths for some reason
            if len (path) > 4 and path[0]=='(' and path[2]==')' and path[3]==' ':
                # The output of the getpaths command looks like
                # (s) path, so split the (s) part into the second part of a tuple
                splitText = path.split(' ')
                listOfPaths.append((normalizePath (splitText[1]), splitText[0]))
                
        # destroy the temp list
        del fullPathList[:]
        if len (listOfPaths) > 0:
            addToSummaryStatus ('   found ' + str(len (listOfPaths)) + ' source paths')   
        handleIncludePathOverRide(includePathOverRide)
        setupApplicationBuildGlobals(vcshellDBarg())
         
    else:
        # This call will exit the program
        fatalError ('Cannot find file: %s in directory: ' % vcshellDbName + vcshellDBlocation + ', please build project with vcshell before running this script\n')  

    # Build the workarea directory structure
    projectMode = buildWorkarea()
        
    # Write the new list of files into the vcWorkArea
    writeFileListToFile (listOfFiles)
    
    endMS = time.time()*1000.0
    addToSummaryStatus ('   complete (' + getTimeString (endMS-startMS) + ')')
    
    return projectMode


def setupGlobalFileListsFromDatabase(filterFunction, filesOfInterest, vcshellArg):
    '''
    This function will set the listOfAllFiles and listOfFiles globals
    from the files in the database.
    '''

    global listOfFiles
    global listOfAllFiles

    # Create a global list of all of the files in the DB
    listOfAllFiles = prependFilesOfInterest(
        getFilesFromDatabase(filterFunction, vcshellArg),
        filesOfInterest)

    # filter based on: already in project and max size
    listOfFiles = filterTheFileList (listOfAllFiles)
    addToSummaryStatus ('   ' + str(len (listOfFiles)) + ' files will be added for system testing ... ')


def getAllFilesFromDatabase(vcshellArg):
    '''
    This function returns all the files in the database.
    '''
    stdOut, exitCode = runVCcommand ('vcdb ' + vcshellArg + ' getfiles', True)
    # strip the trailing CR and then split
    out = stdOut.rstrip('\n').split('\n')
    if len (out) == 0:
        fatalError ('No files found in %s' % vcshellDbName)
    else:
        addToSummaryStatus ('   found ' + str(len (out)) + ' total source files')

    return out

def getFilesFromDatabase(filterFunction, vcshellArg):
    '''
    This function returns the files from the database. The filter function can be used to
    filter the files.
    '''
    original = getAllFilesFromDatabase(vcshellArg)
    addToSummaryStatus ('   applying the user-defined filter to the file list ... ')
    # filterFunction is the user supplied callback function
    originalFileListLength = len (original)
    out = filterFunction(original)
    if len (out) < originalFileListLength:
        addToSummaryStatus ('   user filter reduced file count to: ' + str (len (out)))

    return out

def prependFilesOfInterest(original, filesOfInterest):
    '''
    This function moves filesOfInterest to the begining of original
    '''
    if filesOfInterest == [parameterNotSetString]:
        return original

    if os.name == "nt":
        filesOfInterest = [file.lower() for file in filesOfInterest]
    sortedListOfAllFiles = list(original)
    filesNotInDb = list(filesOfInterest)
    index = 0
    for file in original:
        if os.name == "nt":
            tempFile = file.lower()
        else:
            tempFile = file
        # If file matches any entry in filesOfInterest 
        if tempFile in filesOfInterest or os.path.basename(tempFile) in filesOfInterest:
            sortedListOfAllFiles.remove(file)
            sortedListOfAllFiles.insert(index, file)
            index += 1
            if tempFile in filesOfInterest:
                filesNotInDb.remove(tempFile)
            else:
                filesNotInDb.remove(os.path.basename(tempFile))
        # Exit the loop if all files in files of interest processed
        if not filesNotInDb:
            break
    # If the user specified file is not in db. Log the file in summary and continue
    if filesNotInDb:
       addToSummaryStatus('   File %s in FILES_OF_INTEREST not found in db' % str(filesNotInDb))
    return list(sortedListOfAllFiles)

def setupApplicationBuildGlobals(vcshellArg):
    '''
    Sets the globals related to building the applications under test.
    '''

    global topLevelMakeLocation
    global topLevelMakeCommand
    global applicationList

    topLevelMakeLocation = getTopLevelMakeLocation(vcshellArg)
    topLevelMakeCommand = getTopLevelMakeCommand(vcshellArg)
    if vcshellCommandVerb:
        vcshellArg += ' --cmd-verb=' + vcshellCommandVerb
    applicationList = getApplicationList(vcshellArg)

def getTopLevelMakeLocation(vcshellArg):
    '''
    Return the top level make directory from the database.
    '''
    cmdOutput, exitCode = __toVCcommandStatus('vcdb ' + vcshellArg + ' gettopdir')
    if exitCode==0:
        return cmdOutput.strip('\n').strip('"')
    else:
        return ''

def getTopLevelMakeCommand(vcshellArg):
    '''
    Return the top level make command from the database.
    '''
    cmdOutput, exitCode = __toVCcommandStatus('vcdb ' + vcshellArg + ' gettopcmd')
    if exitCode==0:
        return cmdOutput.strip('\n')
    else:
        return ''

def getApplicationList(vcshellArg):
    '''
    Get the application list from the database.
    '''
    stdOut, exitCode = __toVCcommandStatus(command='vcdb ' + vcshellArg + ' getapps')
    if 'Apps Not found' in stdOut:
        return []
    else:
        return stdOut.split ('\n')

def buildCoverageProject(projectMode, projectName, inplace, workingDirectory, **kwargs):
    global globalCoverageProjectExists

    try:
        start_t = time.time()
        __build_coverage_project(
            projectMode,
            projectName,
            inplace,
            workingDirectory,
            **kwargs
        )
        end_t = time.time()
        addToSummaryStatus('   complete ({})'.format(
            getTimeString((end_t - start_t) * 1000)
        ))

        globalCoverageProjectExists = True

    except (FlexLMError, VCCommandError):
        # raise an error as needed
        if globalAbortOnError:
            raise

        # If we get a flex error, we continue
        addToSummaryStatus(
            '   error creating cover project, continuing ...')
        globalCoverageProjectExists = False


def __escape_vcast_varpath(path):
    if os.name != 'nt':
        # Transform a path like $(ROOT) into '\$\(ROOT\)'
        path = shlex.quote(path.replace(r'$', r'\$')
                               .replace(r'(', r'\(')
                               .replace(r')', r'\)'))
    return path


def __build_coverage_project (project_mode, project_name, inplace, working_dir, **kwargs):
    """
    This function will build a coverage project, if base directories are specified they
    will be added to the project. The project will not be instrumented.
    """
    global listOfAddedFiles

    inst_dir = kwargs.get('instDir', '')
    base_dirs = kwargs.get('baseDirs')

    sectionBreak('')
    addToSummaryStatus ('Building Coverage Environment ' + project_name + ' ...')

    os.chdir(working_dir)

    if project_mode == 'new':
        # Get the compiler configuration file ...
        getCFGfile ()
        # [DEPRECATED: Only isCuda() will matter in future.]
        if useLegacyCudaWorkflow() or not isCuda():
            # Create project
            __cover_from_vcinst(project_name, inplace, inst_dir)

    # Add files to the project
    db_file = os.path.join(vcshellDBlocation, vcshellDbName)
    filelist_file = os.path.join(originalWorkingDirectory, vcWorkArea, listOfFilenamesFile)

    # [DEPRECATED: Only isCuda() will matter in future.]
    if not useLegacyCudaWorkflow() and isCuda(): 
        # Create or update CUDA project using external script
        script_dir = os.path.join(os.environ["VECTORCAST_DIR"], "DATA", "cuda")
        script_name = os.path.join(script_dir, "add_multiple_issue_source.py")

        # Prepare arguments for CUDA project creation script
        script_args = []
        script_args.append(f"--project={project_name}")
        script_args.append(f"--db={db_file}")
        script_args.append(f"--filelist={filelist_file}")
        prep_dir = os.path.join(originalWorkingDirectory, vcWorkArea, vcPrepDirectory)
        script_args.append(f"--prep_dir={prep_dir}")
        prep_output = os.path.join(prep_dir, vcPrepMap)
        script_args.append(f"--prep_out={prep_output}")
        script_args.append("--prep_map")
        arg_string = " ".join(script_args)

        # Call script
        cmd = f'vpython {script_name} {arg_string}'

        # Ensure that script ran to completion
        stdOut, exitCode = runVCcommand(cmd)
        if exitCode != 0: 
            fatalError(f"ERROR: Cannot create/update CUDA coverage project:\n{stdOut}")

        # Gather list of prepared files
        if not os.path.isfile(prep_output):
            addToSummaryStatus(f"    warning: Cannot find prepared file list {prep_output}")
            listOfAddedFiles = listOfFiles
        else:
            with open(prep_output, "r", encoding="utf-8") as po:
                # Read in JSON mapping file: 
                prep_map = json.load(po)
                listOfAddedFiles = []
                for fv in prep_map.values():
                    listOfAddedFiles.extend(fv)

        if project_mode == 'new':
            # For a new project, set instrumentation in-place / out-of-place
            __cover_set_inst_location(project_name, inplace, inst_dir)

    elif base_dirs:
        # If base directories were specified, then add those to project and
        # populate files from base directories set.
        for base in base_dirs:
            runVCcommand('clicast -e {} cover base_dir add {} {}'.format(
                project_name,
                base.name,
                __escape_vcast_varpath(base.path),
            ))
            for allow_dir in base.allowed:
                runVCcommand('clicast -e {} cover base_dir allowlist {} {}'.format(
                    project_name,
                    base.name,
                    allow_dir,
                ))
            for deny_dir in base.denied:
                runVCcommand('clicast -e {} cover base_dir denylist {} {}'.format(
                    project_name,
                    base.name,
                    deny_dir,
                ))
        runVCcommand('clicast -e {} cover base_dir update'.format(project_name))
        # Assume all listed files have been added
        listOfAddedFiles = listOfFiles

    elif len(listOfFiles) > 0 and not useParallelInst:
        addToSummaryStatus ('   adding {} source files  ...'.format(len(listOfFiles)))
        # This clicover command will look like:
        # cliccover add_source_vcdb vcshell.db vcast-latest-filelist.txt
        runVCcommand(
            'clicover add_source_vcdb {} {} {}'.format(
                project_name, db_file, filelist_file),
            True)
        listOfAddedFiles = listOfFiles


def __cover_set_inst_location(project_name, inplace, inst_dir):
    """
    Set up in-place / out-of-place instrumentation for a project
    """
    if inplace:
        runVCcommand('clicast -e {} cover options in_place Y'.format(
            project_name), True)
    else:
        # Create the instrumentation directory if we are not instrumenting in place.
        if inst_dir:
            if not os.path.isdir(inst_dir):
                os.mkdir(inst_dir)
            runVCcommand(
                'clicast -e {} cover options '
                'set_instrumentation_directory {}'.format(project_name,
                                                          inst_dir),
                True)

        runVCcommand(
            'clicast -e {} cover options in_place n'.format(
                project_name))


def __cover_from_vcinst(project_name, inplace, inst_dir):
    """
    Vcutil instrument in old Vectorcast does not create cover project.
    It creates only the directory with instrumented files. New version
    of Vcutil instrument creates cover project also.
    globalParallelInstCoverProject will be NULL if user is using old
    VectorCAST. So only for old version of Vcutil we build cover project
    for AC backwards compatibility.
    """
    if useParallelInst:
        if not globalParallelInstCoverProject:
            runVCcommand('clicast cover environment build {} {}'.format(
                         project_name,
                         inst_dir))
        # else: New VectorCAST, so parallel inst will create project for us
    else:
        addToSummaryStatus('   creating the coverage project ...')
        runVCcommand('clicast cover env create {}'.format(project_name),
                     True)
        #set vcshell for cover project
        runVCcommand(
            'clicast -lc -e "{}" Cover Options ADD_VCShell "{}"'.format(
                project_name,
                os.path.join(vcshellDBlocation, vcshellDbName))
            + (' "{}"'.format(vcshellCommandVerb) if vcshellCommandVerb else ''))

        # Set in-place / out-of-place instrumentation
        __cover_set_inst_location(project_name, inplace, inst_dir)

'''
This function will take the full path to the cover Environment vcp
file and return a tuple of the directory and the environment name.
e.g. "/foo/bar/workarea/environment.vcp" will return
( "/foo/bar/workarea", environment )
'''
def coverDirectoryAndName ( coverEnvironmentFullPath ):
    directory = os.path.dirname ( coverEnvironmentFullPath )
    environment = os.path.basename ( coverEnvironmentFullPath )
    return directory, environment

'''
This function will instrument and/or perform Lint analysis on the
specified cover environment
'''
def instrumentCoverageProject ( coverageType,
                                runLint,
                                localListOfMainFiles, 
                                coverEnvironmentFullPath ):
        
    if coverageType != 'none':
        instrumentFiles ( coverageType, localListOfMainFiles, coverEnvironmentFullPath )

    # If the caller requested lint analysis
    if maximumFilesToSystemTest>0 and runLint:
        runLintAnalysis ( coverEnvironmentFullPath )
        

    
def runLintAnalysis (coverEnvironmentFullPath):
    '''
    This will do the Lint analysis
    We need to run the following command on the VC/Cover project
    $VECTORCAST_DIR/clicast -e <env> cover tools lint_analyze
    '''

    workingDir, coverageProjectName  = coverDirectoryAndName (
                                         coverEnvironmentFullPath )
       
    sectionBreak('')
    addToSummaryStatus ('Starting Lint Analysis ...')
    startMS = time.time()*1000.0
    
    try:      
        os.chdir ( workingDir )
        stdOut, exitCode = runVCcommand ('clicast -e ' + coverageProjectName + ' cover tools lint_analyze')
        
        endMS = time.time()*1000.0
        addToSummaryStatus ('   complete (' + getTimeString(endMS-startMS) + ')')
        
    except Exception as err:
        if globalAbortOnError:
            raise err
        # If we get a flex or command error, we continue
        elif str(err)=='FLEXlm error':
            addToSummaryStatus ('   error running lint analysis, continuing ...')
            globalCoverageProjectExists = False
        else:
            raise
    
   
    
def instrumentFiles (coverageType, listOfMainFiles, coverEnvironmentFullPath):
    '''
    This function will instrument all of the files in the cover project
    We do this in two parts, for the new files that just got added during
    this round, we need to do an explicit instrument call.  And then we
    need to do a incremental re-instrument to bring the whole project up to date
    '''
    
    sectionBreak('')
    startMS = time.time()*1000.0
    
    try:
        
        workingDir, coverageProjectName  = coverDirectoryAndName (
                                               coverEnvironmentFullPath )

        addToSummaryStatus ('Starting Instrumentation for ' + coverageProjectName + ' ...')

        os.chdir (workingDir)
        
        # The instrumented files need functions that are defined in the
        # VectorCAST coverage library file: c_cover_io.c.  The easiest way
        # to get this code into an application is to #include the file 
        # c_cover_io.c into each of the main files of an application.
        # We now use a clicast command to do this.  
        # Previously we used a py function: appendCoverIOfileToMainFiles
        for file in listOfMainFiles:
            stdOut, exitCode = runVCcommand ('clicast -e' + coverageProjectName + ' cover append_cover_io true -u' + file)
        
               
        # Call the instrumentor for any new files
        listOfFilesString = ''
        for file_ in listOfAddedFiles:
            listOfFilesString += '"{}" '.format(file_)
        
        # We don't want to overwhelm the command line if we have 10k files for example
        if len (listOfFilesString) > 1000:
           stdOut, exitCode = runVCcommand ('clicast -e' + coverageProjectName + ' cover instrument ' + coverageType)
        else:
            # Run instrumentation on the new files ...
            stdOut, exitCode = runVCcommand ('clicover instrument_' + coverageType.replace ('+', '_') + ' ' + coverageProjectName + ' ' + listOfFilesString)
            # Run incremental re-instrument to pick up any source changes
            stdOut, exitCode = runVCcommand ('clicast -e' + coverageProjectName + ' cover source incremental_reinstrument')
            
            
        endMS = time.time()*1000.0
        addToSummaryStatus ('   complete (' + getTimeString(endMS-startMS) + ')')
        
    except Exception as err:
        if globalAbortOnError:
            raise err
        # If we get a flex error, we continue
        elif str(err)=='FLEXlm error':
            addToSummaryStatus ('   error instrumenting files, continuing ...')
            globalCoverageProjectExists = False
        else:
            raise   


def envCoverArgString (coverageType):
    '''
    This function will return the correct flag for coverage to the EnvCreate.py call
    '''
    if coverageType=='none':
        return ''
    else:
        return ' --coverage=' + coverageType
        

def splitIncludeList (includeList):
    '''
    includeList is a list of tuples with the paths and type
    This function will break this list into three based on types
    '''
    includes = []
    libs = []
    types = []
    for item in includeList:
        if item[1] == 'LIB':
            libs.append (item[0])
        elif item [1] == 'TYPE':
            types.append (item[0])
        elif item [1] == 'SEARCH':
            includes.append (item[0])

    return includes, types, libs
   
        
def pathArgs (includeList, excludeList):
    '''
    This function will take the two lists and create the args to be passed
    to EnvCreate.py.  The includeList contains tuples with the path as the
    first element, and LIB TYPE or SEARCH as the second.
    '''
    argString = ' '
    includes, types, libs = splitIncludeList(includeList)

    if len (includes) > 0:
        argString += '--includepath='
        for dir in includes:
            argString += dir + ','
        # get rid of the "extra" ,
        argString = argString[:-1] + ' '
        
    if len (types) > 0:      
        argString += '--type_handled_list='
        for dir in types:
            argString += dir + ','
        # get rid of the "extra" ,
        argString = argString[:-1] + ' '        
        
    if len (libs) > 0:      
        argString += '--library_list='
        for dir in libs:
            argString += dir + ','
        # get rid of the "extra" ,
        argString = argString[:-1] + ' '   
        
    if len (excludeList) > 0:
        argString += '--excludepath='
        for I in excludeList:
            argString += I + ','
        # get rid of the "extra" ,
        argString = argString[:-1] + ' '
        
    return argString
            
typesToHandle={} 
typesToHandle['LIB'] = '(L)'
typesToHandle['TYPE'] = '(T)'
typesToHandle['SEARCH'] = '(S)'
def setTypeCommandNeeded (path):
    '''
    This function will determine if we need to invoke vcdb
    to change the path type in vcshell.db.  
    The 'path' parameter is a tuple that looks like: (/home/path, path-type)
        where type can be: TYPE, LIB, SEARCH, NONE
    The listOfPaths is a tuple that looks like: (/home/path, path-type)
        where type can be: (T), (L), or (S)
    If the path is already in the database and the type matches
    no work is needed.
    '''
    global listOfPaths
    
    # for all the paths that are in the database
    for libPath in listOfPaths:
        # if the path we are processing is in the database
        if libPath[0]==normalizePath(path[0]):
            # If the new type is one we care about
            if path[1] in typesToHandle:
                if typesToHandle[path[1]] == libPath[1]:
                    return False
                else:
                    return True
            else:
                return False
                
    # path not in the DB
    return False

def vcshellVpythonVcdbArgs (vcdbFlagString):
    '''Returns formated vcdb arguments for a vcshell vpython script.'''
    vcdbOptArgs = []
    if len (vcdbFlagString) > 0:
        defineFlag = readCFGoption ('C_DEFINE_FLAG')
        if defineFlag:
            vcdbOptArgs.append('--flags="{}=1,{}"'.format(defineFlag, vcdbFlagString))
    if vcshellCommandVerb:
        vcdbOptArgs.append('--cmd-verb={}'.format(vcshellCommandVerb))
    return ' '.join(['--vcdbOpt="{}"'.format(s) for s in vcdbOptArgs])

def inListOfPaths (path):
    '''
    We need this function because listOfPaths is a tuples
    '''
    global listOfPaths
    
    for listItem in listOfPaths:
        if path == listItem[0]:
            return True
            
    return False

 
            
def buildEnvScripts(coverageType, envFileEditor, vcdbFlagString,
                    envFilesUseVcdb):
    '''
    This function will use the IDC EnvCreate.py script to build environment
    scripts for all files.
    '''

    # This has all files not just the ones added to the cover project
    global listOfAllFiles
    # the listOfPaths is a tuple that looks like: (/home/path, path-type)
    global listOfPaths
    global maximumFilesToUnitTest
    global globalBlackBoxEnv
    
    
    sectionBreak('')
    addToSummaryStatus ('Building Environment Scripts ...')
    startMS = time.time()*1000.0
    
    try:
        if len (listOfAllFiles) > 0:
        
            os.chdir (os.path.join (originalWorkingDirectory, vcWorkArea, vcScriptsDirectory ))
            
            # Get the compiler configuration file ...
            getCFGfile ()
            
                    

            # Prune the list of all files to remove any .env files that already exist
            prunedList = []
            count = 0
            for fileName in listOfAllFiles:
                # fileName is the full path, so strip path,
                # strip extension, and force upper case
                filePart = os.path.basename(fileName).split('.')[0].upper()
                if not os.path.isfile (filePart + '.env'):
                    prunedList.append (fileName)
                    count = count + 1
                    if count == maximumFilesToUnitTest:
                        break                   
                    
            if len (prunedList) > 0:
                
                # create a temp file that has the pruned list
                tempFile = tempfile.NamedTemporaryFile (delete=False)
                for fileName in prunedList:
                    tempFile.write (bytes(fileName + '\n', 'utf-8'))
                tempFileName = tempFile.name
                tempFile.close()
        
                addToSummaryStatus ('   building ' + str(len(prunedList)) + ' environment scripts ...') 
                
                # Call the EnvCreate.py script to build the env files.
                commandArgs =  ' ' + vcshellDBarg(force=True,
                                                  cfgFile=True)
                commandArgs += ' ' + envCoverArgString(coverageType)
                commandArgs += pathArgs (includeList, excludeList)
                commandArgs += ' --filelist=' + os.path.join (originalWorkingDirectory, vcWorkArea, tempFileName)
                commandArgs += ' ' + vcshellVpythonVcdbArgs(vcdbFlagString)
                if globalBlackBoxEnv:
                    commandArgs += ' --blackbox'
                # This will constuct the .env files with the path to the vcshell, rather than the search paths and unit options
                if envFilesUseVcdb:
                    commandArgs += ' --add_db_name'
                    
                fullCommand =  'vpython '
                fullCommand += pathToEnvCreateScript + commandArgs
                stdOut, exitCode = runVCcommand (fullCommand)
                
                # delete the temp-file
                os.remove (tempFileName)
                
                # Now for each environment script, call the user-supplied editor function
                addToSummaryStatus ('   calling the user-supplied environment script editor ...')
                for filePath in listOfAllFiles:
                    fileName = os.path.basename(filePath)
                    envFileName = fileName.split('.')[0].upper() + '.env'
                    envFileEditor (envFileName)             
    
        endMS = time.time()*1000.0
        addToSummaryStatus ('   complete (' + getTimeString(endMS-startMS) + ')')
    
    except Exception as err:
        if globalAbortOnError:
            raise err
        # If we get a flex error, we continue
        elif str(err)=='FLEXlm error':
            addToSummaryStatus ('   error creating environment scripts, continuing ...')
        else:
            raise




def runManageCommands(project, commands):
    '''
    This function  takes a project name and a list of commands, builds a temp file
    containing the commands, and then invokes manage 1 time.
    '''
    manageScriptName='script.msh'

    with open(manageScriptName, "w", encoding="utf-8") as f:
        f.write("\n".join(commands))
        
    # We do not make any of the manage commands fatal ... the project create is done
    # by using runVCcommand directly
    stdOut, exitCode = runVCcommand('manage -p %s --script %s' % (project, manageScriptName))  
    os.remove (manageScriptName)
    
    return stdOut 


def platformLevelString ():
    '''
    This will return the string that should be used for the Platform level
       Source/Windows, Source/Linux, or Source/Solaris
    '''
    global clicastVersion
    if not clicastVersion:
        clicastVersion, exitCode = runVCcommand('clicast --version')
    if 'Version 6.' in clicastVersion:
        if platform.system()=='Windows':
            return '--level Source/Windows'
        else:
            return '--level Source/Linux'
    else:
        return ''
        

def platformLevelStringWithSlash ():
    if platformLevelString():
        return platformLevelString() + '/'
    else:
        return '--level '


def getListOfCompilerNodes ():
    '''
    This function will interrogate an existing manage project and return the list
    of compiler nodes that are already defined.
    '''
    command = ['--list-compilers']
    stdOut = runManageCommands (manageProjectName, command)
    return [i for i in stdOut.splitlines() if i and not i.startswith('Running')]


def computeCompilerNodeName ():
    '''
    This function will compute the compiler node name backwards from the CFG file
    If there is not a CFG file, we assume we are building for monitored environments
    and we just create a generic node
    '''
    global compilerNodeName  
    global currentLanguage
    
    if os.path.isfile (C_CONFIG_FILE):
        compiler_name_option = 'C_COMPILER_HIERARCHY_STRING'
        bad_char_regex = re.compile("[\\s()\"':<>|?*/\\\\#]")
        compilerNodeName = re.sub(bad_char_regex, '_', readCFGoption(compiler_name_option))
        if not compilerNodeName and globalAbortOnError:
            raise Exception(
                'Could not determine compiler node name. '
                'Please verify the %s file exists and the %s option is set.' % (C_CONFIG_FILE, compiler_name_option))

        currentLanguage = 'c'
        
    elif os.path.isfile (ADA_CONFIG_FILE):
        compilerNodeName = readAdaCFGoption ('COMPILATION_SYSTEM').replace (' ', '_')  
        currentLanguage = 'ada'

    else:
        compilerNodeName = defaultCompilerNodeName
        currentLanguage = 'none'



        
def unitTestTestSuiteName ():
    '''
    We might eventually create separate nodes per compiler
    for now, just using one
    ''' 
    if currentLanguage=='ada':
        return 'UnitTesting-Ada'
    else:
        return 'UnitTesting'
        
def unitTestDefaultGroupName():
    '''
    Returns the default unit test group name.
    '''
    return 'UT-Group'

def unitTestGroupName ():
    '''
    the nextUTgroupName will contain the unique group
    name based on the contents of the existing project
    ''' 
    if currentLanguage=='ada':
        return '{0}{1}{2}'.format(unitTestDefaultGroupName(), '-Ada-', compilerNodeName)
    else:
        return '{0}{1}{2}'.format(unitTestDefaultGroupName(), '-', compilerNodeName)

def buildCompilerNode ():
    '''
    This function will add a new compiler node to the manage tree
    If we find a CCAST_.CFG file we create a node for the compiler
    from this config, same thing for ADACAST_.CFG.  If we do not 
    find a CFG file, we create a "generic" node
    '''

    global compilerNodeName
    manageCommands = []
    computeCompilerNodeName ()
    currentCompilerNodeList = getListOfCompilerNodes()
    
    if compilerNodeName not in currentCompilerNodeList:
    
        if currentLanguage=='c':
            manageCommands.append('--cfg-to-compiler=CCAST_.CFG')
            # Manage Creates a testsuite node called "TestSuite" by default
            manageCommands.append('--testsuite=TestSuite --delete')

            # [DEPRECATED: May be removed in future versions]
            if useLegacyCudaWorkflow():
                # add gencode options for CUDA
                addCudaGencodeOptions ( manageCommands )
            
        elif currentLanguage=='ada':
            manageCommands.append('--cfg-to-compiler=ADACAST_.CFG')
            manageCommands.append('--testsuite=TestSuite --delete')

        else:
            manageCommands.append(platformLevelStringWithSlash() + compilerNodeName + ' --create')
            
        # Create the TestSuite and Group Nodes
        manageCommands.append(platformLevelStringWithSlash() + compilerNodeName + '/' + unitTestTestSuiteName() + ' --create')
        manageCommands.append('--group ' + unitTestGroupName() + ' --create')
        manageCommands.append(platformLevelStringWithSlash() + compilerNodeName + '/' + unitTestTestSuiteName() + ' --add ' + unitTestGroupName())
        
    return manageCommands
   

def getDefaultSystemTestingGroupName():
    '''
    This function returns the default system testing manage project group name
    '''
    return 'ST-Group'


def getDefaultSystemTestingTestSuiteName():
    '''
    This function return the default system testing manage project testsuite name
    '''
    return 'SystemTesting'

def processCoverageProjectPaths(projectPaths, function):
    for projectPath in projectPaths:
        if globalCoverageProjectExists and len(projectPath) > 0:
            function(projectPath)

def environmentPathToName(path):
    return os.path.splitext(os.path.basename(path))[0]

def commandsToBuildProjectTree ( projectPaths,
                                 coverageType,
                                 tcTimeOut,
                                 systeTestCompilerNodeName='SystemTestingCompilerNode',
                                 envFilesUseVcdb=True):
    '''
    This function will create the basic structure of the manage project
    groupAndProject is a list of tuples, with the first element in the tuple being
    the group name, and the second element being the full path to the .vcp file
    '''

    manageCommands = []
    if platformLevelString():
        manageCommands.append(platformLevelString() + ' --create')

    lanaguage='none'
    if envFilesUseVcdb:
      manageCommands.append(platformLevelString() + ' --config="VCDB_FILENAME=%s"' % (os.path.join (vcshellDBlocation, vcshellDbName)))
    if vcshellCommandVerb:
        # Commas in the command verb must be escaped to not confuse the command
        # interpreter into thinking we are specifying a new config option.
        escaped = vcshellCommandVerb.replace(',', '\\,')
        manageCommands.append(platformLevelString()
                              + ' --config="VCDB_CMD_VERB={0}"'.format(escaped))
    manageCommands.append(platformLevelString() + ' --coverage-type="%s"' % (coverageType))
    manageCommands.append(platformLevelStringWithSlash()+ systeTestCompilerNodeName + ' --create')
    
    manageCommands.append('{0}{1}/{2} --create'.format(
        platformLevelStringWithSlash(),
        systeTestCompilerNodeName,
        getDefaultSystemTestingTestSuiteName()))
    manageCommands.append('--group %s --create' % getDefaultSystemTestingGroupName())
    manageCommands.append(
        '{0}{1}/{2} --add {3}'.format(
            platformLevelStringWithSlash(),
            systeTestCompilerNodeName,
            getDefaultSystemTestingTestSuiteName(),
            getDefaultSystemTestingGroupName()))

    def __appendCommandsToAddCoverageEnvironment(projectPath):
        addToSummaryStatus ('   adding the coverage environment ' + projectPath)
        manageCommands.append('--import ' + os.path.join ('..', vcCoverDirectory, projectPath))
        manageCommands.append('--group {0} --add {1}'.format(
            getDefaultSystemTestingGroupName(),
            environmentPathToName(projectPath)))

    if globalParallelInstCoverProject:
        addToSummaryStatus('   adding the coverage environment {}'.format(
            globalParallelInstCoverProject))
        manageCommands.append('--import {}.vcp'.format(
            globalParallelInstCoverProject))
        manageCommands.append('--group {0} --add {1}'.format(
            getDefaultSystemTestingGroupName(),
            environmentPathToName(globalParallelInstCoverProject + '.vcp')))
    else:
        processCoverageProjectPaths(projectPaths,
                                    __appendCommandsToAddCoverageEnvironment)
    
    # Make sure that we got a number for this option
    if type (tcTimeOut)==int:
        # Only set it explicitly if it is NOT 0
        if tcTimeOut!=0:
            manageCommands.append(' --config=TEST_CASE_TIMEOUT='+str(tcTimeOut))

    return manageCommands
    
    
    
@contextlib.contextmanager
def make_tempDirectory():
    '''
    Create a temp directory for use when building the script files
    '''
    tempDirectory = tempfile.mkdtemp()
    yield tempDirectory
    shutil.rmtree(tempDirectory)

        
class scriptFiles:
    '''
    This class Is used to create to keeep track of the script files for one file
    '''
    def __init__(self, tempDirectory, envFile):
        self.baseFilename = os.path.splitext (os.path.basename (envFile))[0]
        self.envFilename = os.path.join(tempDirectory, self.baseFilename + '.env')
        self.originalScriptFile = envFile

    def generate_files(self):
        if not os.path.isfile(self.originalScriptFile):
            return
        
        shutil.copyfile(self.originalScriptFile, self.envFilename)
        

def filterEnviroList(enviroList):
    '''
    Remove any environments form the environment list that are already in the Manage project

    We check if the vcWorkArea exists and has a list of files already in the project.  
    If it does, it will remove those files from the list that was passed in.
    Initially, we were checking the full path to the vce ... but that was wrong
    because manage does not allow two enivornments with the same name!  
    So now, the firest thing we do is to strip the directory prefix from enviroList
    '''
        
    if os.path.isdir (os.path.join (originalWorkingDirectory, vcWorkArea)):
        existingEnviroments = os.path.join (originalWorkingDirectory, vcWorkArea, listOfEnvironmentsInProject)
        if os.path.isfile (existingEnviroments):
            addToSummaryStatus ('   checking the existing environments file ... ')
            oldFile = open (existingEnviroments, 'r', encoding='utf-8')
            lines = oldFile.readlines()
            # Build a list of the enviro names currently in the project
            bareEnviroNames = []
            for line in lines:
                bareEnviroNames.append (os.path.basename (line.strip()))
            # If any of the new enviros have that same name, remove them
            listCopy = enviroList[:]
            for enviro in listCopy:
                strippedName = os.path.basename(enviro)
                if strippedName in bareEnviroNames:
                    addToSummaryStatus ('   environment name: ' + strippedName + ' already exists in this project ...')
                    enviroList.remove (enviro)

                    
                    
def saveEnvironmentsInProject (enviroList):
    '''
    Append the new enviro list to the list of enviros in the project
    '''
    fullEnvironmentList = os.path.join (originalWorkingDirectory, vcWorkArea, listOfEnvironmentsInProject);
    oldFile = open (fullEnvironmentList, 'a', encoding='utf-8')
    for file in enviroList:
        oldFile.write (file + '\n')
    oldFile.close() 
    
        
def createFileClassList (tempDirectory):
    '''
    This function will create the .env file
    for each of the files that we want to add to the manage project
    We use the class above to manage the actual work
    The files get generated in a temporary directory
    '''

    global listOfAllFiles
    global maximumUnitTestsToBuild
    
    # First we find the list of all .env files that exist in 
    pathToEnvFiles = os.path.join (originalWorkingDirectory, vcWorkArea, vcScriptsDirectory)
    envFileList = glob.glob (os.path.join (pathToEnvFiles, '*.env'))
    filterEnviroList (envFileList)
    saveEnvironmentsInProject (envFileList)
        
    out = []
    for enviroCount, envFile in enumerate (envFileList):
        if enviroCount==maximumUnitTestsToBuild:
            break
        else:
            out.append(scriptFiles(tempDirectory, os.path.join (pathToEnvFiles, envFile)))

    for i in out:
        i.generate_files()

    return out

def commandsToAddOneEnvironment (fileClass):
     '''
     This function will return the commands needed to add one file to the manage project
     '''
     levelArg = platformLevelStringWithSlash() + compilerNodeName + '/' + unitTestTestSuiteName() + '/' + fileClass.baseFilename
     out = []      
     out.append ('--import ' + fileClass.envFilename)
     out.append ('--group ' + unitTestGroupName() + ' --add ' + fileClass.baseFilename)
     out.append ('--migrate ' + levelArg)
     return out
    
def commandsToAddAllEnvironment ():
    '''
    This function will return the command needed to add all .env files to the
    manage project
    '''
    
    levelArg = platformLevelStringWithSlash() + compilerNodeName + '/' + unitTestTestSuiteName()

    out = ""
    envScriptDir = os.path.join(originalWorkingDirectory,
                                vcWorkArea, vcScriptsDirectory)
    out += '--import-all ' + envScriptDir
    out += ' --group ' + unitTestGroupName()
    out += ' --migrate ' + levelArg
    return [out]
    
    
def commandsToBuildOneEnvironment (fileClass):
    '''
    This function will return the commands needed to build one environment in the manage project
    '''
    levelArg = platformLevelStringWithSlash() + compilerNodeName + '/' + unitTestTestSuiteName() + '/' + fileClass.baseFilename
    
    out = []   
    out.append(levelArg + ' --build')
    if addBasisPathTest:
        out.append(levelArg + ' --clicast-args tools auto_test temp.tst')
        out.append(levelArg + ' --clicast-args test script run temp.tst')
    out.append(levelArg + ' --apply-changes --force')
    return out


def commandsToExecuteOneEnvironment (fileClass):
    '''
    Not currently used.
    This function will return the commands needed to execute one environment in the manage project
    We don't use this yet, because execute could hang on a test etc.
    '''
    levelArg = platformLevelStringWithSlash() + compilerNodeName + '/' + unitTestTestSuiteName() + '/' + fileClass.baseFilename
    
    out = []
    out.append(levelArg + ' --execute')
    return out


    
def commandsToAddAndBuildEnvironments (fileClassList):
    '''
    This function will return a list of all of the commands needed to add
    all of the environmet scripts to the manage project
    '''    
    addCommands = []
    buildCommands = []
    if (maximumFilesToUnitTest) > 0 and (not vcEnterpriseMode):
        addCommands += commandsToAddAllEnvironment ()
    if maximumUnitTestsToBuild>0:
        for enviroCount, fileClass in enumerate(fileClassList):
            if vcEnterpriseMode:
                addCommands += commandsToAddOneEnvironment (fileClass)
            # To make this quicker, we only build maximumUnitTestsToBuild environment
            if enviroCount < maximumUnitTestsToBuild:
                 buildCommands += commandsToBuildOneEnvironment (fileClass)

    return addCommands, buildCommands
    
 
 
def addEnvFilesToManageProject ():
    '''
    We will loop over all of the .env files and add those environments
    to the Manage project
    '''   
        
    sectionBreak('')
    addToSummaryStatus ('Adding Unit Test Scripts to Manage Project ...')
    startMS = time.time()*1000.0
    
    with make_tempDirectory () as tempDirectory:
        fileClassList = createFileClassList(tempDirectory)
        
        # Get the commands needed to do the work
        addCommands, buildCommands = commandsToAddAndBuildEnvironments (fileClassList)        
        
        # I do this in two pieces so that we can have times for each piece.
        # Run the 'add' commands
        if len (addCommands) > 0:
            stdOut = runManageCommands(manageProjectName, addCommands )
            endMS = time.time()*1000.0
            addToSummaryStatus ('   ' + str (len (addCommands) // 3) + ' environment script(s) added (' + getTimeString(endMS-startMS) + ')')
        
        # Run the 'build' commands
        if len (buildCommands) > 0:
            startMS = time.time()*1000.0
            stdOut = runManageCommands(manageProjectName, buildCommands )
            endMS = time.time()*1000.0
            addToSummaryStatus ('   ' + str (len (buildCommands) // 3) + ' environment node(s) built (' + getTimeString(endMS-startMS) + ')')


            
def convertOneLine (originalLine, flagText, newValue, escapeBackSlash=True):
    '''
    Common code to simply replace the "end" of the line with the flagText with the new value
        escapeBackSlash - determines whether to escape the backslash or not
                        - if string contains special char like '\"' we should not escape
    '''
    if flagText in originalLine:
        endIndex = originalLine.find (flagText) + len (flagText)
        if escapeBackSlash:
            line = originalLine[0:endIndex] + ' = ' + newValue.replace('\\','\\\\') + '\n'
        else:
            line = originalLine[0:endIndex] + ' = ' + newValue + '\n'
        return line

        
commonCommentLine     = '        # **Auto-inserted by VectorCAST from vcshell data \n'
def commentForExecutable():
    '''
    We comment the code with the names of the apps if there are multiple apps
    '''
    returnString = commonCommentLine
    if len (applicationList) > 1:
        returnString += '        #   project has multiple applications: '
        for app in applicationList:
            returnString += os.path.basename(app) + ' '
            
        returnString += '\n'
    return returnString
 
def isRunTestCaseLine(original):
    '''
    This function checks if the original is a run test case line
    '''
    return './' in original and 'nameOfTestExecutable' in original

def convertRunTestCaseLineToAbs(original):
    '''
    This function removes the execute string from original
    '''
    return original.replace("'./' + ", '')

locationWhereWeRunMakeString = '        self.locationWhereWeRunMake'
topLevelMakeCommandString    = '        self.topLevelMakeCommand'
whereWeRunTestsString        = '        self.locationWhereWeRunTests'
nameOfExecutableString       = '        self.nameOfTestExecutable'
listOfTestcasesString        = '        self.masterListOfTestCases'
def convertSystemTestLine (originalLine):
    '''
    This function replaces specific lines in the system_tests.py file based on the 
    values that we retrieved from the vcshell.db during initialization
    '''
    # skip the system_test.py update
    global globalUpdateSystemTestPy

    if globalUpdateSystemTestPy is False:
        return originalLine
    exe = str()
    if len(applicationList) > 0:
        exe = applicationList[0]

    if locationWhereWeRunMakeString in originalLine:
        return commonCommentLine + convertOneLine (originalLine, locationWhereWeRunMakeString, 'r"' + topLevelMakeLocation + '"')
    
    elif topLevelMakeCommandString in originalLine:
        return commonCommentLine + convertOneLine (originalLine, topLevelMakeCommandString, 'r"' + topLevelMakeCommand + '"', False)
        
    # TBD: We could have multiple applications in the vcdb, for now I am just choosing the first one
    elif len(applicationList) > 0 and  whereWeRunTestsString in originalLine:
        # location is the first part of the path ...
        location = os.path.dirname(applicationList[0])
        return commentForExecutable() + convertOneLine (originalLine, whereWeRunTestsString, 'r"' + location + '"')

    elif isRunTestCaseLine(originalLine) and os.path.isabs(exe):
        return convertRunTestCaseLineToAbs(originalLine)

    # TBD: We could have multiple applications in the vcdb, for now I am just choosing the first one
    elif exe and nameOfExecutableString in originalLine:
        return commentForExecutable() + convertOneLine (originalLine, nameOfExecutableString, 'r"' + exe + '"')
        
    # TBD: We could have multiple applications in the vcdb, for now I am just choosing the first one
    elif listOfTestcasesString in originalLine:
        return ( '        # TBD: Testcase(s) to execute\n' +
                 convertOneLine (originalLine, listOfTestcasesString, "[TestCase('Test1')]" ) )
        
    else:
        return originalLine

class File:

    def __init__(self, directory, name):
        self.directory = directory
        self.name = name

    def get_path(self):
        return os.path.join(self.directory, self.name)

class PythonFile:

    def __init__(self, directory, module_name):
        self.directory = directory
        self.module_name = module_name

    def get_file(self):
        return File(self.directory, self.module_name + '.py')

    def get_compiled_file(self):
        out = self.get_file()
        out.name += 'c'

        return out

class SystemTestScript:

    def __init__(self, python_repository, environment_name):
        self.python_repository = python_repository
        self.environment_name = environment_name

    def get_python_file(self):
        return PythonFile(
            self.python_repository.get_path(),
            self.environment_name + '_system_tests')

class PythonRepository:

    def __init__(self, project_name):
        self.project_name = project_name

    def get_path(self):
        return os.path.join(self.project_name, 'python')

    def get_system_test_script(self, environment_name):
        return SystemTestScript(self, environment_name)

class Project:

    def __init__(self, name):
        self.name = name

    def get_python_repository(self):
        return PythonRepository(self.name)

class EnvironmentNode:
    def __init__(self, node):
        self.node = node

    def get_name(self):
        return self.node.attrib["name"]

    def get_system_test_modules(self):
        return [i for i in self.node.iter('system-test-module')]

class ProjectVcmEditor:

    def __init__(self, path):
        self.path = path
        self.tree = ElementTree()

    def get_environments(self):
        return [EnvironmentNode(i) for i in self.tree.findall("environment")]

    def parse(self):
        self.tree.parse(self.path)

    def write(self):
        self.tree.write(self.path)


def autoConfigureSystemTestScript(projectPath):
    # We only do this special processing if we have "good data" for the topLevelMakeCommand
    if not len(topLevelMakeCommand) > 0:
        return

    systemTestScript = \
        Project(os.path.join(os.getcwd(), manageProjectName)) \
        .get_python_repository() \
        .get_system_test_script(environmentPathToName(projectPath))
    addToSummaryStatus('   updating the %s script ...' % systemTestScript.get_python_file().get_file().name)
    oldFile = open (systemTestScript.get_python_file().get_file().get_path(), 'r', encoding='utf-8')
    # create temp file to hold the updates
    newFile = tempfile.NamedTemporaryFile (delete=False)
    for line in oldFile:
        newFile.write(bytes(convertSystemTestLine (line), 'utf-8'))

    oldFile.close()
    newFile.close()
    shutil.move(newFile.name, systemTestScript.get_python_file().get_file().get_path())

def autoConfigureSystemTestScripts(projectPaths):
    '''
    This function will open the system_tests.py files for the just imported
    system testing environments and fill in some of the varaibles that we
    captured during the build process
    '''

    processCoverageProjectPaths(projectPaths, autoConfigureSystemTestScript)
    
      
def buildEnterpriseProject (projectMode, coverageType,
                            tcTimeOut, envFilesUseVcdb=True):
    '''
    This function will create a manage project, add the already existing Cover Project
    and then also add all of the UT environment scripts
    '''
    global maximumUnitTestsToBuild

    sectionBreak('')  
    addToSummaryStatus ('Building VectorCAST Project ...')
    startMS = time.time()*1000.0
    addToSummaryStatus ('   location: ' + os.getcwd())


    # Get the compiler configuration file we do this in all cases, because
    # we could be using a new CFG file for an existing manage project.
    # Think about one that had Ada, and now we are adding C
    getCFGfile ()
    
    if projectMode == 'new':

        # Create the empty manage project    
        stdOut, exitCode = runVCcommand(
            'manage -p {} --create'.format(manageProjectName), True)
        
        addToSummaryStatus('   building project structure nodes')
        
        # To make this fast, we write all of the manage commands to build the 
        # basic project structure, into a command file and then call manage.exe 
        # one time with this file.
        projectPaths = []
        # add coverage project if found
        if globalParallelInstCoverProject:
            projectPaths.append(globalParallelInstCoverProject + '.vcp')
        elif len(coverageProjectName) > 0 and maximumFilesToSystemTest > 0:
            projectPaths.append (os.path.join ('..',
                                               vcCoverDirectory,
                                               coverageProjectName + '.vcp'))
        commands = commandsToBuildProjectTree( projectPaths, coverageType,
                                               tcTimeOut,
                                               envFilesUseVcdb=envFilesUseVcdb)
        stdOut = runManageCommands(manageProjectName, commands)
        
        # Auto-configure the system_test.py file
        autoConfigureSystemTestScripts(projectPaths)

    # Determine the name of the compiler node, and if we need to build a new one ... 
    nodeCommands =  buildCompilerNode ()
    stdOut = runManageCommands(manageProjectName, nodeCommands)
        
    # Now spin though all of the Env files and add those nodes to the manage project
    addEnvFilesToManageProject ()
    
    endMS = time.time()*1000.0
    addToSummaryStatus ('   complete (' + getTimeString(endMS-startMS) + ')')


manageProjectNotFound='not-found'
def findManageProject():
    '''
    This helper function will change the working directory to where
    the manage project is, and then return the manage project name.
    '''
    manageProjectName = manageProjectNotFound
    manageDirectory = os.path.join (originalWorkingDirectory, vcWorkArea, vcManageDirectory)
    if os.path.isdir(manageDirectory):
        os.chdir (manageDirectory)
        
        # Figure out the name of the manage project
        for file in os.listdir('.'):
            if file.endswith ('_project.vcm'):
                # We just grab the first one because there should only be one!
                manageProjectName = file
                break
    if manageProjectName==manageProjectNotFound:
        print('Manage Project Does Not Exist')
    return manageProjectName
    
    

def findCoverProject():
    '''
    This helper function will change the working directory to where
    the cover project is, and then return the cover project name.
    '''
    os.chdir (os.path.join (originalWorkingDirectory, vcWorkArea, vcCoverDirectory ))
    
    # Figure out the name of the manage project
    coverProjectName = ''
    for file in os.listdir('.'):
        if file.endswith ('_coverage.vcp'):
            # We just grab the first one because there should only be one!
            coverProjectName = file
            break
            
    return coverProjectName
    

def startManageGUI():
    '''
    This function will simply start VC for the manage project
    '''
    manageProjectName = findManageProject()
    if manageProjectName!=manageProjectNotFound:
        print ('Opening VC Project ...')
        commandToRun = os.path.join (vcInstallDir,'vcastqt') + ' -e ' + manageProjectName
        print('   ' + commandToRun)
        subprocess.call (commandToRun, shell=True)
        # Change back to original dir
        os.chdir (originalWorkingDirectory)

def enableCoverage():
    '''
    Enable coverage for the Coverage Project
    '''

    manageProjectName = findManageProject()
    if manageProjectName!=manageProjectNotFound:
        coverProjectName = manageProjectName.split ('_')[0] + '_coverage'
        stdOut, exitCode = runVCcommand ('manage -p' + manageProjectName + ' -e ' + coverProjectName + ' --enable-instrument-in-place')

        # We have to do a reinstrument action to pick up the changes, because the enable simply
        # copies the new foo.c file onto the foo.c.vcast.bak, and relies on the incremental_reinstrument to
        # compare the files and decide what needs to be re-instrumented.
        coverProjectName = findCoverProject()
        stdOut, exitCode = runVCcommand ('clicast -e ' + coverProjectName + ' cover source incremental_reinstrument')
        # Change back to original dir
        os.chdir (originalWorkingDirectory)
    

def disableCoverage():
    '''
    Disable coverage for the Coverage Project
    '''
    manageProjectName = findManageProject()
    if manageProjectName!=manageProjectNotFound:
        coverProjectName = manageProjectName.split ('_')[0] + '_coverage'
        stdOut, exitCode = runVCcommand ('manage -p' + manageProjectName + ' -e' + coverProjectName + ' --disable-instrument-in-place')
        # Change back to original dir
        os.chdir (originalWorkingDirectory)

                   
       
def findAllEnvironments (rootDirectory):
    '''
    This function will search for all .vce files starting at rootDirectory
    and return them in a list
    '''
    returnList = []
    
    addToSummaryStatus ('Finding List of Existing Environments ...')
    
    if not os.path.isdir (rootDirectory):
        print('Invalid directory path: ' + rootDirectory)
    else:
        for root, dirs, files in os.walk(rootDirectory):
            for name in dirs:
                candidateVCE = os.path.abspath (os.path.join(root, name+'.vce'))
                candiateVCP = os.path.abspath (os.path.join(root, name+'.vcp'))
                if os.path.isfile (candiateVCP):
                    returnList.append (candiateVCP)
                elif '.BAK' not in candidateVCE and os.path.isfile (candidateVCE):
                    returnList.append (candidateVCE)     

        addToSummaryStatus ('   found ' + str(len (returnList)) + ' total environments ...')
        
        # Filter the list by removing any environments that we previously added
        filterEnviroList (returnList)
        if len (returnList) ==0:
            addToSummaryStatus ('   no unique environments to be added to the project ...')
        else:
            addToSummaryStatus ('   found ' + str(len (returnList)) + ' environment(s) not currently in the project')
    
    return returnList
    
    
    
def addEnviromentsToManage (enviroList):
    '''
    This function will take a list of already built environments 
    and Cover Project and add them to the Manage project
    '''
    manageCommands = []
    
    sectionBreak('')
    addToSummaryStatus ('Adding Unit Test Environments to Manage Project ...')
    startMS = time.time()*1000.0   
   
    for enviro in enviroList:
        addToSummaryStatus ('   Adding environment: ' + os.path.basename (enviro))
        manageCommands.append ('--import ' + enviro)
        if '.vce' in enviro:
            # Get the commands needed to do the work
            manageCommands.append ('--group ' + unitTestGroupName() + ' --add ' + os.path.splitext (os.path.basename (enviro))[0])
        elif '.vcp' in enviro:
            manageCommands.append ('--group {0} --add {1}'.format(
                getDefaultSystemTestingGroupName(),
                os.path.splitext (os.path.basename (enviro))[0]))
                    
    if len (manageCommands) > 0:
        stdOut = runManageCommands(manageProjectName, manageCommands )
        endMS = time.time()*1000.0
        addToSummaryStatus ('   ' + str (len (enviroList)) + ' environment(s) added (' + getTimeString(endMS-startMS) + ')')
           
    
def vcmFromEnvironments (projectName, rootDirectory, statusfile, verbose):
    '''
    This function support an alternate way of building a Manage project
    Rather than using a vcshell.db it creates a Manage project for existing
    VectorCAST Unit Test Environments
    '''
    global summaryStatusFileHandle
    global maximumUnitTestsToBuild
    global maximumFilesToUnitTest
    global verboseOutput
    global manageProjectName
    global coverageProjectName
    
    verboseOutput = (verbose=='True')
    manageProjectName   = projectName + '_project'
    
    coverageProjectName=''
    maximumUnitTestsToBuild = 0
    maximumFilesToUnitTest = 0
   
    sectionBreak ('')
    summaryStatusFileHandle = open (statusfile, 'w', buffering=1, encoding='utf-8')
    addToSummaryStatus (toolName)
    startMS = time.time()*1000.0  
    rootDirectory = os.path.abspath(rootDirectory)
 
    # Build the work-area directory structure
    # or just change our default directory to be the work-area and return "update"
    projectMode=buildWorkarea()   
       
    # Find all of the .vce and .vcp files downstream of the rootDirectory
    enviroList = findAllEnvironments(rootDirectory)
    
    if len (enviroList) > 0:
      
        # Build the manage project structure
        os.chdir (os.path.join (originalWorkingDirectory, vcWorkArea, vcManageDirectory ))
        buildEnterpriseProject (projectMode, 'none', 0)
        
        # Add the environments ...
        addEnviromentsToManage (enviroList)
        
        # Save the enviro list for next time
        saveEnvironmentsInProject(enviroList)

        endMS = time.time()*1000.0
        addToSummaryStatus ('Total Time: ' + getTimeString(endMS-startMS))
        
    else:
        addToSummaryStatus ('   refreshing the project ...')

        # We want to call the --refresh command below even if we did not add any new enviros
        # This allows the user to "push" new coverage data for an existing environment.
        os.chdir (os.path.join (originalWorkingDirectory, vcWorkArea, vcManageDirectory ))
        # We need to do this to force manage to build the coverage data cache so that Analytics 
        # has the data it needs even if the Manage project is never opened
        manageCommands = []
        
        # TBD: Do we want to do this only for the local enviro?
        manageCommands.append ('--refresh --force')  
        stdOut = runManageCommands(manageProjectName, manageCommands )
           
       
    # Close the summary file
    summaryStatusFileHandle.close()



allowedEditTypes = ['replace', 'insert']
def commonEnvFileEditor(pathToEnvFile, editType, flag='', oldValue='', newValue='', newCommand=''):
    '''
    Since so much of the code (temp file looping etc) is common
    all of the envirionment editors use this common function
    '''
    tempFile = tempfile.NamedTemporaryFile (delete=False)
    envFile = open (pathToEnvFile, 'r', encoding='utf-8')
    for line in envFile:
        if editType=='replace':
            if flag in line and oldValue in line:
                tempFile.write (bytes(flag + ': '  + newValue + '\n', 'utf-8'))
            else:
                tempFile.write (bytes(line, 'utf-8'))
        elif editType=='insert':
            if 'ENVIRO.END' in line:
                tempFile.write (bytes(newCommand, 'utf-8'))
                tempFile.write (bytes(line, 'utf-8'))
            else:
                tempFile.write (bytes(line, 'utf-8'))
            
    tempFileName = tempFile.name
    tempFile.close()
    envFile.close()
    shutil.copyfile (tempFileName, pathToEnvFile)
    os.remove (tempFileName)
    
    
    
def editEnvCommand (pathToEnvFile, flag, oldValue, newValue):
    '''
    This function will allow the user to edit the default default .env file
    It will make this conversion 
        ENVIRO.<flag>: oldValue  -> ENVIRO.<flag>: newValue
    Example
        ENVIRO.STUB: ALL_BY_PROTOTYPE  -> ENVIRO.STUB: NONE
    '''
    commonEnvFileEditor (pathToEnvFile=pathToEnvFile, editType='replace', flag=flag, oldValue=oldValue, newValue=newValue)


    
def insertEnvCommand (pathToEnvFile, newCommand):
    '''
    This function will allow the user to add a new command or block to the default .env file 
    We insert this new command, right before the ENVIRO.END
    '''
    commonEnvFileEditor (pathToEnvFile=pathToEnvFile, editType='insert', newCommand=newCommand)
    
    
def buildListOfMainFilesFromDB(vcshellArg):
    '''
    This function will retrieve the list of files whre we should insert c_cover_io ...
    '''
    sectionBreak('')
    addToSummaryStatus ('Computing insert locations for c_cover_io.c ...')
    returnList = []
        
    stdOut, exitCode = __toVCcommandStatus(command='vcdb ' + vcshellArg + ' getapps') 
    if 'Apps Not found' in stdOut:
        applicationList = []
    else:
        applicationList = stdOut.rstrip('\n').split('\n')
    
    if len (applicationList)>0:
        
        # Build a list of sets.  One file set for each application
        appFileLists = []
        for app in applicationList: 
            stdOut, exitCode = __toVCcommandStatus('vcdb ' + vcshellArg + ' --app=' + app + ' getappfiles') 
            listOfAppFiles = stdOut.rstrip('\n').split('\n')
            
            # but only consider files that are in the cover project
            setOfAppFiles = set (listOfAppFiles) & set (listOfFiles)

            fileSet = set()
            for file in setOfAppFiles:
                fileName = os.path.basename (file)
                # [DEPRECATED: Will be always added in future versions]
                if not useLegacyCudaWorkflow() or file not in cudaHostOnlyFiles:
                    fileSet.add (fileName) 
            appFileLists.append (fileSet)
           
        # if we have exactly one application, just return the first filename in the list ...
        if len (appFileLists)==1 and len (appFileLists[0])>0:
           # sort to maintain same return list between sessions
           returnList.append (sorted(appFileLists[0]).pop())

        elif len (appFileLists) > 1: # we have multiple applications, at least 2 ...
            
            # A candidate for where to put the c_cover_io is a file that exists in ALL applications
            # Let's see if there are one or more common files and if so return one of these ...
            commonFileList =  (appFileLists[0]).intersection(*appFileLists)
            if len (commonFileList) > 0:
                # sort to maintain same return list between sessions
                returnList.append (sorted(commonFileList).pop())

            else:  
                # there are no common files, so let's find the unique files in each application.
                numberOfApplications = len (appFileLists)
                appUniqueFileLists = []
                for outerLoopIndex in range (0, numberOfApplications):
                    uniqueFileList = appFileLists[outerLoopIndex]
                    for innerLoopIndex in range (0, numberOfApplications):
                        if outerLoopIndex!=innerLoopIndex:
                            # We converted the list of files to a set above ...
                            uniqueFileList =  ( uniqueFileList - appFileLists [innerLoopIndex] )
                    # sort to maintain same return list between sessions
                    appUniqueFileLists.append(sorted(uniqueFileList))
               
                # So now we have a list of unique files for each appliacation, grab the first
                # on from each appliation and return that file.  If the set is empty then we have
                # the odd case where we an application does not have any unique files, so indicate an error
                for index, value in enumerate (applicationList):
                    if len (appUniqueFileLists[index]) == 0:
                        addToSummaryStatus ('    could not find insert location for app: ' + value)
                    else:
                        returnList.append (appUniqueFileLists[index].pop())
        
    if len (returnList) > 0:
        addToSummaryStatus ('   file list: ' + ', '.join (returnList))
    elif len(listOfFiles) > 0:
        addToSummaryStatus ('   no candidates found - using first file in list')
        returnList.append ( listOfFiles[0] )
    else:
        addToSummaryStatus ('   no candidates found')

    return returnList


# Case     
validCoverageTypes = [
    'none',
    'statement',
    'branch',
    'mcdc',
    'function',
    'function+function_call',
    'statement+branch',
    'statement+mcdc',
    'basis_paths',
    'probe_point',
    'coupling'
    ]

def automationController(projectName, vcshellLocation, listOfMainFiles, runLint,
                         maxToSystemTest, maxToUnitTest, filterFunction,
                         maxToBuild, compilerCFG, coverageType, inplace,
                         vcdbFlagString, tcTimeOut, includePathOverRide,
                         envFileEditor, statusfile, verbose, filesOfInterest,
                         envFilesUseVcdb, basisPathTest=True, parallelInst=True,
                         abortOnError=globalAbortOnError,
                         updateSystemTest=globalUpdateSystemTestPy,
                         blackboxenv=False, coverBaseDir=None):
    '''
    This function is passed the configuration data from the vcdb2vcm.py file and 
    create a VectorCAST project which contains a VectorCAST/Cover Environment
    and optionally VectorCAST/C++ Unit Test Environments
    
    All of the created stuff is store in vcast-workarea
    See the sub-functions called from here for details.
    
    Notes:
        inplace has been removed as an option as of AC15, leaving param for backwards compatibility
    '''

    global manageProjectName
    global coverageProjectName
    global maximumFilesToSystemTest
    global maximumFilesToUnitTest
    global maximumUnitTestsToBuild
    global summaryStatusFileHandle
    global verboseOutput
    global vcshellDBlocation
    global addBasisPathTest
    global useParallelInst
    global vcWorkArea
    global vcshellDbName
    global globalAbortOnError
    global globalUpdateSystemTestPy
    global globalParallelInstCoverProject
    global globalBlackBoxEnv
    
    addBasisPathTest = basisPathTest
    useParallelInst = parallelInst
    globalAbortOnError = abortOnError
    globalUpdateSystemTestPy = updateSystemTest
    globalBlackBoxEnv = blackboxenv
    if os.path.isfile (os.path.join (vcshellLocation, vcshellDbName)):
        vcshellDBlocation = vcshellLocation
    else: 
        vcshellDBlocation = os.getcwd()

        
    # We use buffering=1 which means line buffering, so that 
    # the file gets updated in real time.
    summaryStatusFileHandle = open (statusfile, 'w', buffering=1, encoding='utf-8')
    addToSummaryStatus (toolName)
    startMS = time.time()*1000.0   

    verboseOutput = verbose
    
    sectionBreak ('')
    addToSummaryStatus ('Validating configuration choices ...')
    # Validate some of the input parameters
    if coverageType not in validCoverageTypes:
        print('    Invalid VCAST_COVERAGE_TYPE requested: "' + coverageType + '", using coverage type none')
        coverageType = 'none'

    if useParallelInst == True:
        # Vcdb GetDestinationdir returns zero if vcutil instruent was run previously
        # destDirRetCode stores the return code of getdestinationdir
        globalParallelInstCoverProject, destDirRetCode = __toVCcommandStatus(
            'vcdb getdestinationdir --app=instrument {}'.format(
                vcshellDBarg(force=True)))
        if destDirRetCode == 0:
            useParallelInst = True
            maxToSystemTest = sys.maxsize
            globalParallelInstCoverProject = globalParallelInstCoverProject.strip("\n")
            #If cover project created by vcutil instrument  does not exist 
            #try to build the cover project using normal work flow
            if (not os.path.isfile(globalParallelInstCoverProject + '.vcp')
                    or not os.path.isdir(globalParallelInstCoverProject)):
                globalParallelInstCoverProject = ''
                useParallelInst = False
        else:
            globalParallelInstCoverProject = ''
            useParallelInst = False
    # Parallel Instrumentation
    if useParallelInst:
        print('   Using Cover project created from parallel instrumentation')
    elif maxToSystemTest < 0:
        print('    Invalid MAXIMUM_FILES_TO_SYSTEM requested, using 0')
        maxToSystemTest = 0
    projectName = projectName.replace(' ', '_')
    
    coverageProjectName = projectName + '_coverage'
    manageProjectName   = projectName + '_project'
    
    maximumFilesToSystemTest = int (maxToSystemTest)
    maximumFilesToUnitTest = int (maxToUnitTest)
    maximumUnitTestsToBuild = int (maxToBuild)
          
    # Initialize the project settings, projectMode will be 'update' or 'new'
    projectMode = initialize(compilerCFG, filterFunction, vcdbFlagString,
                             filesOfInterest, includePathOverRide)
    
    if maximumFilesToSystemTest > 0:
        if useLegacyCudaWorkflow() and isLegacyCuda():
            # [DEPRECATED: May be removed in future versions]
            # Do alternative coverage project creation for legacy workflow.
            buildCudaCoverageProjects (projectMode,
                                       vcCoverDirectory)
        else:
            # We always build an empty coverage project even if the number of 
            # files to system test is 0, because this allows us to add files to it later.
            # If parallel inst is enabled the instrumentation dir will be set.
            buildCoverageProject (projectMode,
                                  coverageProjectName,
                                  inplace,
                                  vcCoverDirectory,
                                  baseDirs=coverBaseDir)
    
    if (maximumFilesToSystemTest > 0 and globalCoverageProjectExists
            and useParallelInst ==  False):
        if len(listOfMainFiles)==1 and listOfMainFiles[0]==parameterNotSetString:
            localListOfMainFiles = buildListOfMainFilesFromDB(vcshellDBarg(force=True) + vcshellVerbArg())
        else:
            localListOfMainFiles = listOfMainFiles

        if useLegacyCudaWorkflow() and isLegacyCuda():
            # [DEPRECATED: May be removed in future versions]
            # Do alternative instrumentation for split CUDA projects
            instrumentCudaCoverageProjects ( coverageType,
                                             runLint,
                                             localListOfMainFiles, 
                                             os.path.join ( originalWorkingDirectory,
                                                            vcWorkArea ) )
        else:
            # Instrument coverage project
            instrumentCoverageProject ( coverageType,
                                        runLint,
                                        localListOfMainFiles, 
                                        os.path.join ( originalWorkingDirectory,
                                                       vcWorkArea,
                                                       vcCoverDirectory,
                                                       coverageProjectName ) )
    # Use the IDC EnvCreate to build .env scripts for each file.
    if maximumFilesToUnitTest > 0:
        buildEnvScripts(coverageType, envFileEditor, vcdbFlagString,
                        envFilesUseVcdb)
    
    # Build the manage project
    os.chdir (os.path.join (originalWorkingDirectory, vcWorkArea, vcManageDirectory ))

    if useLegacyCudaWorkflow() and isLegacyCuda() and projectMode == 'new':
        # [DEPRECATED: May be removed in future versions]
        # Use alternative CUDA projects to create enterprise project.
        buildCudaEnterpriseProject (coverageType,
                                    tcTimeOut,
                                    os.path.join (originalWorkingDirectory, vcWorkArea ),
                                    envFilesUseVcdb)
        buildCudaAggregateFiles(os.path.join (originalWorkingDirectory,
                                              vcWorkArea,
                                              vcCoverDirectory))
    else:
        # Build Manage project
        buildEnterpriseProject (projectMode, coverageType,
                                tcTimeOut, envFilesUseVcdb)
    
    # Add the list of files to the cummulative list of files ...
    newFileList = os.path.join (originalWorkingDirectory, vcWorkArea, listOfFilenamesFile);
    fullFileList = os.path.join (originalWorkingDirectory, vcWorkArea, listOfFilesInProject);
    newFile = open (newFileList, 'r', encoding='utf-8')
    oldFile = open (fullFileList, 'a', encoding='utf-8')
    for line in newFile:
        oldFile.write (line)
    newFile.close()
    oldFile.close()

    endMS = time.time()*1000.0
    addToSummaryStatus ('Total Time: ' + getTimeString(endMS-startMS))

    addToSummaryStatus (toolName + ' Complete')
    summaryStatusFileHandle.close()

    # Display the status to stdout
    os.chdir (originalWorkingDirectory)
    statusMessages=''
    with open(statusfile, 'r', encoding='utf-8') as summaryStatusFileHandle:
        statusMessages=summaryStatusFileHandle.read()
    sectionBreak (statusMessages)
   
    # TBD: Copy the vcast_lint.xml from the cover project to the manage project (FB 51133)
    if runLint:
        fromFile = os.path.join (originalWorkingDirectory, vcWorkArea, vcCoverDirectory, coverageProjectName, 'vcast_lint.xml')
        toPath = os.path.join (originalWorkingDirectory, vcWorkArea, vcManageDirectory, manageProjectName)
        if os.path.isfile (fromFile):
            shutil.copy (fromFile, toPath)

def updateSystemTestPy (systemTestFileName, vcshellLocation):
    global verboseOutput

    verboseOutput = True
    stdOut, exitCode = runVCcommand ('clicast -lc option vcast_vcdb_flag_string ')
    setupApplicationBuildGlobals('--db ' + vcshellLocation)

    if len (topLevelMakeCommand) > 0:
        oldFile = open (systemTestFileName, 'r', encoding='utf-8')
        newFile = tempfile.NamedTemporaryFile (delete=False)

        for line in oldFile:
            newFile.write(bytes(convertSystemTestLine (line), 'utf-8'))
        oldFile.close()
        newFile.close()
        shutil.move(newFile.name, systemTestFileName)

def appendCoverIOFilterFn(originalList):
    return originalList[:]

def appendCoverIO (vcshellFile, coverageProjectName, cwd=None):
    global summaryStatusFileHandle
    global verboseOutput

    verboseOutput = True
    summaryStatusFileHandle = open ('append_cover_io.log', 'w', buffering=1, encoding='utf-8')
    vcshellArg = '--db=' + vcshellFile;
    if vcshellCommandVerb:
        vcshellArg += ' --cmd-verb=' + vcshellCommandVerb
    setupGlobalFileListsFromDatabase(appendCoverIOFilterFn, [parameterNotSetString], vcshellArg)
    localListOfMainFiles = buildListOfMainFilesFromDB(vcshellArg)
    for file in localListOfMainFiles:
        stdOut, exitCode = runVCcommand ('clicast -e' + coverageProjectName + ' cover append_cover_io true -u' + file, cwd=cwd)

    
def enterpriseEnvironmentBuild (workareaBaseDirectory, projectName, scriptFile):
    '''
    This function will build a manage project in the local directory
    using the passed in projectName as the name of the manage project,
    the local CCAST_ (or ADACAST).CFG file for the compiler settings
    and the passed in scriptFile as the .env file to add to the manage project
    
    We are not trying to handle the add an environment to an existing manage
    project case, like we do with the rest of the Automation Controller stuff.
    The assumption here is that we are always doing a build new action.
    '''
    
    global cfgFileLocation 
    global summaryStatusFileHandle
    global manageProjectName
    global maximumUnitTestsToBuild
    global maximumFilesToUnitTest
    global vcWorkArea
    global vcEnterpriseMode

    vcEnterpriseMode = True
    vcWorkArea = workareaBaseDirectory
    maximumFilesToUnitTest = 0
    
    print('VectorCAST Enterprise Utility') 
       
    # we are building an enterprise VC/C++ or VC/Ada
    if scriptFile=='':
        print('Script file must be provided using the --script argument')
    
    elif not os.path.isfile(scriptFile):
        print('The script file: "' + scriptFile + '" does not exist')
        
    elif projectName=='':
        print('Project name must be provided using the --project argument')
               
    elif os.path.exists (projectName + '.vcm'):
        print('Invalid project name: "' + projectName + '", ' + projectName + '.vcm already exists')
        
    elif os.path.exists (projectName):
        print('Invalid project name: "' + projectName + '", a directory with this name already exists')

    
    elif scriptFile.endswith ('.env') or scriptFile.endswith ('.vcp'):
   
        # Change directory to the place where we will build the manage project
        os.chdir (workareaBaseDirectory)
        
        statusFile = 'vcast-enterprise-utility.txt'
        summaryStatusFileHandle = open (statusFile, 'w', buffering=1, encoding='utf-8')

        # Setup the common global variables
        cfgFileLocation = os.getcwd()
        manageProjectName = projectName
        # we are not building a coverage project
        coverageProjectName = ''
       
        # Build the structure of the manage project, which contains the 
        # Compiler nodes, system and unit test suites etc.
        buildEnterpriseProject (projectMode='new', coverageType='none', tcTimeOut=0)
        
        if scriptFile.endswith ('.env'):
            # Add the environment ...
            with make_tempDirectory () as tempDirectory:

                fileStructure = scriptFiles (tempDirectory, os.path.join (os.getcwd(), scriptFile))
                fileStructure.generate_files()

                # This global variable is used to compute the build commands below
                maximumUnitTestsToBuild = 1       
                
                # This function takes a list, so we create a one item list in the call
                addToSummaryStatus ('   adding environment to project')
                addCommands, buildCommands = commandsToAddAndBuildEnvironments ([fileStructure])
                stdOut = runManageCommands(manageProjectName, addCommands)
                addToSummaryStatus ('   building environment')
                stdOut = runManageCommands(manageProjectName, buildCommands)
                
        # scriptFile.endswith ('.vcp')
        else:
            addToSummaryStatus ('   adding environment to project')
            manageCommands = []
            manageCommands.append ('--import ' + scriptFile)
            scriptFile = os.path.basename (scriptFile)
            manageCommands.append ('--group {0} --add {1}'.format(
                getDefaultSystemTestingGroupName(),
                scriptFile.split('.')[0]))
            stdOut = runManageCommands(manageProjectName, manageCommands)
   
                
        summaryStatusFileHandle.close()
                       
    else:        
        print('Script file: "' + scriptFile + '" is invalid')
        print('Only environment scripts (.env files), and coverage project files (.vcp) are supported')



#-------------------------------------------------------------------------
# Legacy CUDA Workflow 
# [DEPRECATED: May be removed in future versions]
#-------------------------------------------------------------------------
CUDA_HOST = 'HOST'

# CUDA artifacts
cudaArchitectures = []
cudaHostOnlyFiles = []


def isLegacyCuda():
    return len(cudaArchitectures) > 0

def get_legacy_cuda_filename(original_filename):
    return original_filename + '.vcast.cuda'

def is_arch(arch):
   return arch.isdigit()

def cudaArchMacro ( architecture, definition=True ):
    if is_arch(architecture):
        if definition:
            return "__CUDA_ARCH__=" + architecture + "0"
        else:
            return "__CUDA_ARCH__==" + architecture + "0"
    else:
        return ""

def get_cuda_arch_prefix():
    return 'ARCH_'

def cudaArchName ( architecture ):
    if is_arch(architecture):
        return get_cuda_arch_prefix() + architecture
    else:
        return CUDA_HOST

'''
These are files that have a .cpp extension, but are not forced to
be treated as a device file via the "-x cu" compiler option
'''
def initializeCudaHostOnlyFiles ( listOfAllFiles ):
    global cudaHostOnlyFiles
    cudaHostOnlyFiles = []
    # only set this up if we're dealing with CUDA
    if isLegacyCuda():
        for a_file in listOfAllFiles:
            if os.path.splitext(a_file)[1] != '.cu':
                # get compiler command for this file
                command, exitCode = __toVCcommandStatus(command='vcdb ' +
                                                  vcshellDBarg(force=True) +
                                                  vcshellVerbArg() +
                                                  ' getcommand --file=' +
                                                  a_file)
                # if the flag is not there, add it to our list
                if "-x cu" not in command:
                    cudaHostOnlyFiles.append(a_file)

def buildCudaCoverageProjects (projectMode, workingDir):
    global cudaHostOnlyFiles

    addToSummaryStatus ('Building CUDA Coverage Environments ...')
    os.chdir ( workingDir )
    currentDirectory = os.getcwd()
    for arch in cudaArchitectures:
        arch_name = cudaArchName ( arch )
        arch_macro = cudaArchMacro ( arch )
        os.mkdir ( arch_name )
        buildCoverageProject (projectMode,
                              arch_name,
                              False,
                              os.path.join(currentDirectory, arch_name))

        # No longer needed; VCAST_LEGACY_CUDA must be set in CCAST_.CFG
        # in order to trigger this logic in the first place. 
        # # Set legacy CUDA mode flag; for now AutomationController 
        # # only supports the legacy CUDA workflow (which was the only
        # # workflow supported in VectorCAST 2020sp3 and below)
        # runVCcommand ('clicast -lc options_append C_DEFINE_LIST VCAST_LEGACY_CUDA')

        # remove any files that are host-only
        if 'HOST' not in arch_name:
            for a_file in cudaHostOnlyFiles:
                runVCcommand(
                    'clicast -e {} -u {} cover source remove'.format(
                        arch_name, a_file),
                    True)

        # set macro flag for CUDA architectures
        if len(arch_macro) > 0:
            runVCcommand ('clicast -lc options_append C_DEFINE_LIST ' + arch_macro)

        os.chdir ( currentDirectory )
 

'''
This function will instrument and/or perform Lint analysis on all the
cover environments in a CUDA-based Manage project
'''
def instrumentCudaCoverageProjects ( coverageType,
                                     runLint,
                                     localListOfMainFiles,
                                     workingDir ):
    os.chdir ( workingDir )
    addToSummaryStatus ('Instrumenting CUDA Coverage Environments ...')
    for arch in cudaArchitectures:
        arch_name = cudaArchName ( arch )
        coverageDirectory = os.path.join(workingDir, vcCoverDirectory)
        coverDirectory = os.path.join(coverageDirectory, arch_name)
        instrumentCoverageProject ( coverageType,
                                    runLint,
                                    localListOfMainFiles,
                                    os.path.join ( coverDirectory, arch_name + '.vcp' ) )
        os.chdir ( workingDir )

'''
This function will parse the line read from 'device_coverage_objects.h'
and generate the search key and actual size from line
Each line we process from will be in the format:
   __device__ __align__(4) char vcast_unit_stmt_bytes_1_device[1] = { 0 };
'''
def getCudaKeyAndSize ( line ):
    pieces = line.strip().split(' ')
    # 3rd element contains the key and size
    key_and_size = pieces[3].split('_')
    # size will be embedded in the last element of key_and_size
    key = '_'.join(key_and_size[:-1])
    start_size = line.find('[')
    end_size = line.find(']')
    size = line[start_size+1:end_size]
    return key, int(size)

def create_backup_file(path):
    shutil.copyfile(path, path + '.bak')

def write_lines(path, lines):
    with open(path, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))

class InitializeCudaHostCoverageObjectsCommand:

    def __init__(self, host_directory, arch_sizes, host_sizes):
        self.host_directory = host_directory
        self.arch_sizes = arch_sizes
        self.host_sizes = host_sizes

    def execute(self):
        addToSummaryStatus('   updating size information')
        objects = self.__get_all_coverage_objects()
        self.__create_init_file(objects)
        self.__update_device_file(objects)

    def __get_all_coverage_objects(self):
        out = {}
        for arch_size in self.arch_sizes:
            arch, name = arch_size.split(' ')
            if arch == CUDA_HOST:
                size = self.host_sizes[name]
            else:
                size = self.arch_sizes[arch_size]

            out[name] = max(size, out.get(name,0))

        return out

    def __create_init_file(self, objects):
        lines = []
        lines.append('')
        lines.append('/* store size of object for different architectures */')
        lines.append('')
        [lines.append(self.__to_static_declaration(name)) for name in sorted(objects.keys())]
        lines.append('')
        lines.append('/* set size of object for instrumented architectures */')
        lines.append('')
        lines.extend(self.__to_inits())
        lines.append('')
        lines.append('/* copy device object locally and write data */')
        lines.append('')
        [lines.extend(self.__to_collect_coverage(name)) for name in sorted(objects.keys())]
        lines.append('')

        write_lines(self.__get_init_file(), lines)

    def __update_device_file(self, objects):
        create_backup_file(self.__get_device_file())

        lines = []
        [lines.append(self.__to_device_declaration(objects, name)) for name in sorted(objects.keys())]
        lines.append('')

        write_lines(self.__get_device_file(), lines)

    def __to_static_declaration(self, name):
        return '   static int sizes_%s[255] = { 0 };' % name

    def __to_inits(self):
        out = []
        for arch_size in sorted(self.arch_sizes):
            arch, name = arch_size.split(' ')
            if arch != CUDA_HOST:
                out.append('   sizes_%s[%s] = %s;' % (name, int(arch), self.arch_sizes[arch_size]))

        return out

    def __to_collect_coverage(self, name):
        out = []
        out.append('   COLLECT_DEVICE_COVERAGE ( %s,' % name)
        out.append('                             sizes_%s[family]);' % name)

        return out

    def __to_device_declaration(self, objects, name):
        return '__device__ __align__(4) char %s_device[%s] = { 0 };' % (name, objects[name])

    def __get_device_file(self):
        return os.path.join(self.host_directory, 'device_coverage_objects.h')

    def __get_init_file(self):
        return os.path.join(self.host_directory, 'device_coverage_collection.h')

'''
Because devices may have different coverage objects than the
host, we need to update the host objects after building
the device environments to make sure we copy all objects
'''
def initializeCudaHostCoverageObjects(host_directory, arch_sizes, host_sizes):
    InitializeCudaHostCoverageObjectsCommand(
        host_directory,
        arch_sizes,
        host_sizes).execute()

class CudaCoverageObjectCollector:

    def __init__(self):
        self.max_sizes = {}  # (key is '<object name>')
        self.host_sizes = {} # (key is '<object name>)'
        self.arch_sizes = {} # (key is '<arch> <object name>')

    def collect(self, lines, arch):
        [self.__process_line(line, arch) for line in lines]

    def __process_line(self, line, arch):
        if not self.__is_device_template_line(line):
            return

        key, size = getCudaKeyAndSize(line)
        if arch == CUDA_HOST:
            self.host_sizes[key] = size
        elif key not in self.host_sizes:
            self.host_sizes[key] = 0

        self.arch_sizes[arch + ' ' + key] = size
        self.max_sizes[key] = max(size, self.max_sizes.get(key, 0))

    def __is_device_template_line(self, line):
        return line.startswith('__device__')

class UpdateCudaHostCoverageObjectsCommand:

    def __init__(self, working_directory):
        self.working_directory = working_directory
        self.collector = CudaCoverageObjectCollector()

    @property
    def max_sizes(self):
        return self.collector.max_sizes

    @property
    def host_sizes(self):
        return self.collector.host_sizes

    @property
    def arch_sizes(self):
        return self.collector.arch_sizes

    def execute(self):
        addToSummaryStatus('Verifying CUDA Coverage Environments ...')
        self.__collect_arch_sizes()
        self.__resize_vcast_c_options()
        self.__initialize_coverage_objects()

    def __collect_arch_sizes(self):
        [self.__collect_arch_size(arch) for arch in self.__get_archs()]

    def __resize_vcast_c_options(self):
        addToSummaryStatus('   updating options file for host')
        vcast_c_options = os.path.join(
            self.__get_environment_directory(CUDA_HOST),
            'vcast_c_options.h')
        create_backup_file(vcast_c_options)
        with open(vcast_c_options, 'r', encoding='utf-8') as f:
            contents = f.read()

        for key in self.max_sizes:
            contents = contents.replace(
                self.__to_coverage_object(key, self.host_sizes[key]),
                self.__to_coverage_object(key, self.max_sizes[key]))

        with open(vcast_c_options, 'w', encoding='utf-8') as f:
            f.write(contents)

    def __initialize_coverage_objects(self):
        initializeCudaHostCoverageObjects(
            self.__get_environment_directory(CUDA_HOST),
            self.arch_sizes,
            self.host_sizes)

    def __get_archs(self):
        out = []
        for directory in os.listdir(self.__get_cover_directory()):
            arch = self.__to_arch(directory)
            if arch:
                out.append(arch)

        return out

    def __to_arch(self, environment_name):
        if environment_name == CUDA_HOST:
            return environment_name

        parts = environment_name.split(get_cuda_arch_prefix(), 1)
        if parts[0] == '' and len(parts) == 2 and is_arch(parts[1]):
            return parts[1]
        else:
            return str()

    def __collect_arch_size(self, arch):
        size_file = os.path.join(
            self.__get_environment_directory(cudaArchName(arch)),
            'device_coverage_objects.h')
        if os.path.isfile(size_file):
            self.__read_size_file(size_file, arch)
        else:
            addToSummaryStatus('   failed to find size file for %s, continuing ...' % cudaArchName(arch))

    def __read_size_file(self, path, arch):
        addToSummaryStatus('   scanning options file for %s' % cudaArchName(arch))
        with open(path, 'r', encoding='utf-8') as f:
            lines = f.readlines()

        self.collector.collect(lines, arch)

    def __to_coverage_object(self, name, size):
        return '%s[%s]' % (name, size)

    def __get_cover_directory(self):
        return os.path.join(
            self.working_directory,
            vcCoverDirectory)

    def __get_environment_directory(self, environment_name):
        return os.path.join(
            self.__get_cover_directory(),
            environment_name,
            environment_name)
'''
Instrumentation will create a header file 'device_coverage_objects.h'
that contains the coverage objects we need for the CUDA devices.
The original coverage objects need to be as big as the largest
device object, so we will search through each file for the largest size, and
update the coverage objects in vcast_c_options.h to be able to handle data
from all devices.
We will create a dictionary (sizes) whose key is the typemark/name for
the object, and whose value is the largest size we can find
'''
def updateCudaHostCoverageObjects(working_directory):
    UpdateCudaHostCoverageObjectsCommand(working_directory).execute()

def update_cuda_host_coverage_objects(environment_working_directory):
    root_directory = os.path.dirname(os.path.dirname(environment_working_directory))
    UpdateCudaHostCoverageObjectsCommand(root_directory).execute()


def addCudaGencodeOptions ( manageCommands ):
    if len(cudaArchitectures) > 0:
        # need to find original C_COMPILE_CMD
        cwd = os.getcwd()
        os.chdir(cfgFileLocation)
        compileCmd, exitCode = runVCcommand('clicast -lc get_option C_COMPILE_CMD')
        linkCmd, exitCode = runVCcommand('clicast -lc get_option C_LINK_CMD')
        os.chdir(cwd)

        # build gencode options
        cudaOptions = ''
        for arch in cudaArchitectures:
            if 'HOST' not in arch:
                cudaOptions = ( cudaOptions + ' -gencode' +
                                ' arch=compute_' + arch +
                                '\,code=sm_' + arch )
        # set compile/link commands to original command plus gencode options
        addToSummaryStatus ("   adding 'gencode' options for CUDA Unit Test Node")
        manageCommands.append('--compiler=' + compilerNodeName +
                              ' --config=C_COMPILE_CMD="' +
                              compileCmd.strip('\n') + ' ' + cudaOptions + '"')
        manageCommands.append('--compiler ' + compilerNodeName +
                              ' --config=C_LINK_CMD="' +
                              linkCmd.strip('\n') + ' ' + cudaOptions + '"')
            
'''
if compilerTemplate contains the word CUDA or
if it is a CFG file that contains CUDA, then this
is a CUDA template
'''
def isCudaTemplate ( compilerTemplate ):
    retVal = False
    if 'CUDA' in compilerTemplate:
        retVal = True
    elif os.path.isfile ( compilerTemplate ):
        theFile = open ( compilerTemplate, 'r', encoding='utf-8')
        for line in theFile:
           if 'C_COMPILER_FAMILY_NAME' in line:
              retVal = 'CUDA' in line
              break
        theFile.close()
    return retVal

def findCudaArchitecture ( token ):
    '''
    In simple cases, the token will look like:
       arch=compute_30
    In more complicated cases, the token might have more information
    in it (the makefile could have this text in a quoted string):
       \"arch=compute_30,\\\"code=sm_30\\\"\"\
    So this function will look for the "compute_XX" part, and return the XX.
    '''
    search_str = "=compute_"
    arch_begin = token.find(search_str)
    # if we find an equals sign
    if arch_begin >= 0:
       # move beginning to start of actual architecture code
       arch_begin = arch_begin + len(search_str)
       # find the end of the code (later in the string
       arch_end = token.find(",", arch_begin)
       # if we don't find a comma, it might terminate with a "\"
       if arch_end < 0:
          arch_end = token.find('\\')
       # if we don't find a comma, fake it to be the end of the string
       if arch_end < 0:
          arch_end = len(token)+1
       # extract the architecture
       return token[arch_begin:arch_end] 
    return ""

def initializeCudaArtifacts ( compilerTemplate ):
    '''
    
    This function will dump all of the command from the DB, and parse
    the nvcc command to extract the list of active architectures.
    
    An example compile command looks like:
    nvcc -gencode arch=compute_30,code=sm_30 -gencode arch=compute_35 ...
    
    So we want to get all of the 'arch=' arguments ...
    
    We don't want to look at every command, because there could be 
    a lot and they are probably all the same, on the other hand
    until this is in the field, I wanted and easy way to process all
    of the lines.  To process, all change VCAST_CUDA_MAX_COMMANDS
    environment variable to a more reasonable number (0 = all)
    
    '''
    global cudaArchitectures
    cudaArchitectures = []
    commandsProcessed = 0

    # we're return a null list if this is not a CUDA compiler
    if isCudaTemplate ( compilerTemplate ):
        addToSummaryStatus ( "Determining CUDA Architectures" )
        # seed the architectures with 'Host'
        cudaArchitectures.append ( CUDA_HOST )
        # get a list of commands
        lines, exitCode = __toVCcommandStatus('vcdb ' + vcshellDBarg(force=True) + ' dumpcommands' )

        maxCommandsToProcess = 1
        if "VCAST_CUDA_MAX_COMMANDS" in os.environ:
            maxCommandsStr = os.environ["VCAST_CUDA_MAX_COMMANDS"]
            try:
                maxCommandsToProcess = int(maxCommandsStr)
            except:
                maxCommandsToProcess = 1
        addToSummaryStatus ( "Processing " + str(maxCommandsToProcess) + " command(s)" )

        nvcc_command_found = False

        # look for 'nvcc' in output
        commands = lines.split('\n')
        for command in commands:
            # if we find the nvcc command, build our list of architectures
            if command.find('nvcc') >= 0:
                parsed = False
                nvcc_command_found = True
                # split tokens so we can search for each 'arch=' option
                tokens = command.split(' ')
                for token in tokens:
                    if ( ('arch=compute_' in token) or
                         ('--gpu-architecture=compute_' in token) ):
                        addToSummaryStatus ( 'MSF1: ' + token )
                        arch = findCudaArchitecture(token)
                        addToSummaryStatus ( 'MSF2: ' + arch )
                        if len(arch) > 0:
                            # add to the list if it's not already there
                            if arch not in cudaArchitectures:
                                parsed = True
                                cudaArchitectures.append(arch)
                # if we found architecture data, increment our count
                # if our count matches our maximum, then stop parsing
                if parsed:
                    commandsProcessed += 1
                    if commandsProcessed == maxCommandsToProcess:
                       break

        # if we found nvcc commands but never found an architecture,
        # then we will use the default architecture of '30'
        if nvcc_command_found and len(cudaArchitectures) == 0:
            addToSummaryStatus("No architectures specified - default to arch_30")
            cudaArchitectures.append('30')

        cudaArchitectures.sort()

class SetCudaSystemTestModulesCommand:

    def __init__(self, project_name, host_name, cuda_environments):
        self.project = Project(project_name)
        self.editor = ProjectVcmEditor(project_name + '.vcm')
        self.host_name = host_name
        self.cuda_environments = cuda_environments

    def execute(self):
        self.editor.parse()
        self.__process_environments()
        self.editor.write()

    def __process_environments(self):
        for environment in self.editor.get_environments():
            self.__process_environment(environment)

    def __process_environment(self, environment):
        if environment.get_name() not in self.__get_arch_environments():
            return

        self.__set_module(environment)
        self.__remove_script(environment)

    def __get_arch_environments(self):
        return list(set(self.cuda_environments).difference(set([self.host_name])))

    def __set_module(self, environment):
        for module in environment.get_system_test_modules():
            module.text = \
                self.project \
                .get_python_repository() \
                .get_system_test_script(self.host_name) \
                .get_python_file() \
                .module_name

    def __remove_script(self, environment):
        self.__remove_file(
            self.project \
            .get_python_repository() \
            .get_system_test_script(environment.get_name()) \
            .get_python_file() \
            .get_file() \
            .get_path())
        self.__remove_file(
            self.project \
            .get_python_repository() \
            .get_system_test_script(environment.get_name()) \
            .get_python_file() \
            .get_compiled_file() \
            .get_path())

    def __remove_file(self, path):
        if os.path.isfile(path):
            os.remove(path)

def buildCudaEnterpriseProject ( coverageType, tcTimeOut,
                                 workArea, envFilesUseVcdb=True ):
    '''
    This function will create a manage project for a CUDA environment.
    This is different than typical projects because we have multiple
    cover environments, one per CUDA architecture
    '''

    sectionBreak('')  
    addToSummaryStatus ('Building VectorCAST Project for CUDA ...')
    startMS = time.time()*1000.0
    addToSummaryStatus ('   location: ' + os.getcwd())

    # Get the compiler configuration file we do this in all cases, because
    # we could be using a new CFG file for an existing manage project.
    # Think about one that had Ada, and now we are adding C
    getCFGfile ()
    
    # Create the empty manage project    
    stdOut, exitCode = runVCcommand(
        'manage -p {} --create'.format(manageProjectName), True)
        
    addToSummaryStatus('   building project structure nodes')
        
    # build a list of all of the coverage projects we just created
    projectNames = [cudaArchName(arch) for arch in cudaArchitectures]
    projectPaths = [os.path.join(workArea, vcCoverDirectory, arch_name, arch_name + '.vcp') for arch_name in projectNames]

    # To make this fast, we write all of the manage commands to build the 
    # basic project structure, into a command file and then call manage.exe 
    # one time with this file.
    commands = commandsToBuildProjectTree( projectPaths, coverageType,
                                           tcTimeOut, 'CudaSystemTest',
                                           envFilesUseVcdb )

    # Have the CUDA HOST environment use the CUDA system test template
    commands.append('--testsuite %s -e %s --set-system-test-template=%s' % (
        getDefaultSystemTestingTestSuiteName(),
        CUDA_HOST,
        'cuda'))

    stdOut = runManageCommands(manageProjectName, commands)

    # This edits the project vcm to make all of the CUDA environments point to
    # the same system test script
    SetCudaSystemTestModulesCommand(
        manageProjectName,
        CUDA_HOST,
        projectNames).execute()

    # Auto-configure the system_test.py file
    autoConfigureSystemTestScript(CUDA_HOST)

    # update host environment coverage objects with sizes
    # based on all architectures
    updateCudaHostCoverageObjects(workArea)
        
    # Determine the name of the compiler node, and if we need to build a new one ...
    nodeCommands =  buildCompilerNode ()
    stdOut = runManageCommands(manageProjectName, nodeCommands)

    # Now spin though all of the Env files and add those nodes to the manage project
    if maximumUnitTestsToBuild>0:
        addEnvFilesToManageProject ()

    endMS = time.time()*1000.0
    addToSummaryStatus ('   complete (' + getTimeString(endMS-startMS) + ')')


def findInstrumentedFilename(coverWorkarea, directory, filename):
    '''
    This subprogram will look in the appropriate directory for the
    instrumented version of the source file.
    If the source filename is "foobar.cu", then the instrumented
    file will be in the format "foobar.*.cu" (where * is a number
    that we don't care about).
    If the file is found, this will return a #include string.
    If the file is not found, this will return a #error string.
    '''
    instrumented, extension = os.path.splitext(filename)
    fileList = glob.glob (os.path.join (coverWorkarea,
                                        directory,
                                        instrumented + '.*' + extension))
    if len(fileList) == 0:
        return '#error "no file ' + filename + '"'
    else:
        if len(fileList) > 1:
           addToSummaryStatus("Found multiple versions of " + filename + " in " + directory)
           addToSummaryStatus("   Using " + fileList[0])
        return '#include "' + fileList[0] + '"'

def get_default_instrumentation_directory():
    return 'vc-inst'

class InstrumentedCudaSourceFile:

   def __init__(self, cover_workarea, path):
      self.cover_workarea = cover_workarea
      self.path = path
      self.lines = []
      self.if_define = '#if'

   def create(self):
      self.__if_any_cuda_archs_define()
      self.__new_line()
      self.__define_cuda_archs()
      self.__end_if_define()
      self.__new_line()
      self.__else_define()
      self.__define_cuda_host()
      self.__new_line()
      self.__end_if_define()
      self.__new_line()

      self.__write()

   def __if_any_cuda_archs_define(self):
      self.__append('#ifdef __CUDA_ARCH__')

   def __define_cuda_archs(self):
      [self.__define_cuda_arch(arch) for arch in cudaArchitectures]

   def __define_cuda_arch(self, arch):
      if not is_arch(arch):
         return

      self.__if_specific_cuda_arch_define(arch)
      self.__include_instrumented_source_file(self.__get_instrumentation_directory(cudaArchName(arch)))
      self.__new_line()
      self.if_define = '#elif'

   def __if_specific_cuda_arch_define(self, arch):
      self.__append(self.if_define + ' ' + cudaArchMacro(arch, False))

   def __include_instrumented_source_file(self, directory):
      self.__append(self.__get_instrumented_source_file(directory))

   def __end_if_define(self):
      self.__append('#endif')

   def __else_define(self):
      self.__append('#else')

   def __define_cuda_host(self):
      self.__include_instrumented_source_file(self.__get_instrumentation_directory(CUDA_HOST))

   def __new_line(self):
      self.__append('')

   def __append(self, line):
      self.lines.append(line)

   def __write(self):
       write_lines(get_legacy_cuda_filename(self.path), self.lines)

   def __get_filename(self):
      return os.path.basename(self.path)

   def __get_instrumented_source_file(self, directory):
      return findInstrumentedFilename(
         self.cover_workarea,
         directory,
         self.__get_filename())

   def __get_instrumentation_directory(self, environment_name):
      return os.path.join(
          environment_name,
          environment_name,
          get_default_instrumentation_directory())

def buildCudaAggregateFiles(coverWorkarea):
    '''
    This function will cycle through all of the source files to create
    an "instrumented" version that will pull in the file that is
    instrumented for the appropriate architecture
    '''
    addToSummaryStatus("Building CUDA aggregation source files")
    [InstrumentedCudaSourceFile(coverWorkarea, source_file).create() for source_file in listOfAllFiles]

