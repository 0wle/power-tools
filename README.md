# power-tools
Small tools for everyday convenience consisting of various scripts and programs primarily for Linux systems

## git-clean-simple
A script, written in plain shell, that makes 'git clean' more powerful by extending it by various functionalities like:
  - iterating through each subfolder and executing a git clean, useful if you have a dedicated repository folder
  - logging removed files in an output file
  - recursively iterating through each sub-folder from a specified root and cleaning found repositories
  - executing a dry run to test which files would have been deleted

### HOW TO USE:
- on default, the script uses the current directory as a starting point
- if you want to run it on another location: use the flag `-d [starting filepath]` to specify the starting point
- remember to make the file executable!
- use the flag `-h` to get help info about any other flags and functionality

The script has been developed and tested on Ubuntu 22.04 LTS
