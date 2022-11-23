# power-tools
Small tools for everyday convenience consisting of various scripts and programs primarily for Linux systems

## git-clean-simple
A script, written in plain shell, that makes 'git clean' more powerful by extending it by various functionalities like:
  - Iterating through each subfolder and executing a git clean, useful if you have a dedicated repository folder
  - Logging removed files in an output file
  - Recursively iterating through each sub-folder from a specified root and cleaning found repositories
  - Executing a dry run to test which files would have been deleted

### HOW TO USE:
- On default, the script uses the current directory as a starting point
- Specify `-l` to output a log
  - Or `-L [directory]` to output a log in specified directory
- Use `-q` for quiet operation
- Use `-r` to iterate recursively through all subfolders
- If you want to run it on another location: use the flag `-d [starting filepath]` to specify the starting directory
- Remember to make the file executable!
- Use the flag `-h` to get help info about any other flags and functionality

The script has been developed and tested on Ubuntu 22.04 LTS
