import subprocess, glob 
files = glob.glob('./PSL/' + '*.svg', recursive=True)
for file in files:
    args = ['inkscape', '--actions=export-type:emf;export-do', file]
    p = subprocess.Popen(args)

