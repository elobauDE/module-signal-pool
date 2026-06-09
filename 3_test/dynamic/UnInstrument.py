#---------------------------------------------
#-- Copyright 2020 Vector Informatik, GmbH. --
#---------------------------------------------


import argparse
import os
import shutil


def setupArgs ():
    '''
    '''
    
    parser = argparse.ArgumentParser(description='VectorCAST-QuickStart Utility')
                           
    # Base directory for building and vc projects and scripts.
    parser.add_argument ('--root', dest='root', action='store', default='notset', help='Project Root')  
    return parser

    



def main():
    '''
    This function will walk the project base directory to revert any instrumented files
    '''

    parser = setupArgs ()
    
    # Read the arguments
    try:
        args = parser.parse_args()
    except SystemExit:
        raise
        
    if args.root=='notset':
       startDirectory = os.getcwd()
    else:
       startDirectory = args.root
    
    for root, directory, filenames in os.walk(startDirectory):

        # print path to all filenames.
        for filename in filenames:
            if ('vcast.bak' in filename) and (len (filename) > 11):
                originalFile = os.path.join(root, filename[:-10])
                bakFile = os.path.join(root, filename)
                print ('restoring original file: ' + originalFile)
                print ('from bak file:      ' + bakFile)
                shutil.copy (bakFile, originalFile)
                os.remove (bakFile)
            elif ('vcast.cuda' in filename):
                cudaFile = os.path.join(root, filename)
                print ('removing CUDA (legacy) file: ' + cudaFile)
                os.remove (cudaFile)
            
         
if __name__ == "__main__":
    # The default Windows encoding on Python 3.7 is cp1252, which is undesired.
    encoding = 'utf-8'
    import sys
    try:
        if sys.stdout.encoding.lower() != encoding:
            sys.stdout.reconfigure(encoding=encoding)
        if sys.stderr.encoding.lower() != encoding:
            sys.stderr.reconfigure(encoding=encoding)
    except AttributeError:
        pass
    main()
