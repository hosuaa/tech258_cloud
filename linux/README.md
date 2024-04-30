# Linux Commands

After any command (e.g. `uname`), we can give the option `--help` to print how to use the command. E.g. `uname --help`

https://explainshell.com/ 
- Really good at explaining what commands do

## System information

- `uname` - Prints some system information. With no option, prints the kernel name
  - `-a` prints all system info
  - `-n` prints the private IP address
  - `-p` prints the architecture of the cpu running

- `whoami` - Prints the current user's name
- `pwd` - Prints the name of the current working directory

## Running commands
- Linux is case sensitive!
- Autocomplete typing a command or file by pressing tab.
    - If there is no autocomplete option, the terminal will flash.
    - If there are multiple, press tab to cycle between them alphabetically

- Run commands in the background with `&`
  - E.g. `sleep 5000 &` - starts a timer for 5000s in the background

- `history` - Prints all commands run on the system (up to 500)
    - Use up and down arrows to navigate between the comands
    - `-c` clears the history

`clear` - Clears the terminal.
    - Can also press `Ctrl-L`

- `sudo <command>` - Runs the command in sudo (super user mode). Same as running with admin privilages.

- `sudo su` - Logs into root, which has elevated privilages.
    - `exit` to logout

Many commands have a `-y` option. This autofills 'yes' into the terminal whenever it is prompted to the user

## Installing packages

- `sudo apt update` - Downloads all the available updates but does not install anything.
    - This does not change your instance's state and so is a safe operation.

-`sudo apt upgrade` - Installs all the downloaded updates.
    - This actually makes changes to your machine so is quite unsafe however on first launch it is fine to run

- `sudo apt install <package>` - Installs the specified package.

- `curl <url> --output filename.ext` - Downloads the data from the url and saves it to the given file

## Working with files

Remember linux treats files and folders as the same thing

You can refer to any file in your directory, or give the path to the file

- `ls <path>` - Prints all files in the path.
    - `-a` prints all files, including hidden ones
    - `-l` prints file permissions
    - `ll` is equivalent to `ls -al`

- `cd path` - navigates to given directory
    - `cd ..` goes to parent directory
    - `cd` goes to user directory (same as `cd ~`)
    - `cd /` goes to root directory ( / : the one before home) (root can also be a user like e.g. ubuntu)
    - `.` is current directory

- `file <file>` - Prints information about the file

- `touch <path/to/file>` - Creates a file in the given location
- `mkdir <path/to/folder>` - Creates a folder in the given location
    - No spaces allowed as the name since it would consider it to be another argument so it would make 2 files/folders, use _ instead, OR "name is", but then to access it must put "" every time, OR mkdir name\ is

- `mv originalfile newfile` - renames originalfile to newfile 
    -can also be used to move files to a different directory
    - When renaming a file to a different extension, it still has the same original extension under the hood

- `cp originalfile path/to/folder` - copies file to the given directory

- `rm filename` - deletes the given file
    - `-R` (recursive) to delete directories
    - `-f` forces the delete so do it no matter what
    - `rm -rf` is quite unsafe
        - If you give no file name, it will delete everything

- `cat filename` - Prints contents of filename to terminal
- `head -n num filename` - Prints the first num lines of filename (alternivately `head -num filename` e.g. head -2 filename, same with tail)
- `tail -n num filename` - Prints the last num lines of filename
- `grep -i string filename` - Only prints lines containing string (can omit -i)
- `nl filename` - Prints the file with numbered lines (same as `cat -n filename`)

- `source filename` -  Runs the file e.g. `source .bashrc` to reload your shell

- `nano` - Opens basic text editor
    - `ctrl-x` to exit, `ctrl-s` to save, type whatever
    - `nano filename` - Opens filename for editing (can create if doesnt exist if you save it)

- `chmod permissions filename` - Changes the permissions of file to the given permissions:
    - You can give permissions in longform (with letters) or shortform (with octal)
        - Longform: `chmod rwxrwxrwx file`
        - Shortform: `chmod 777 file` (4=r,2=w,1=x, the groups are user, groups and other users)

## System processes

- `systemctl status service` - Displays the status of the the given service
- `systemctl stop service` - Stops the given service (may need sudo as it asks for perms)
- `systemctl start service` - Starts the given service (e.g. nginx) (again sudo)
- `systemctl restart service` - Restarts the given service(again sudo)
     -useful when changing config (changes dont come into efect when running start, but DO with restart)
- `systemctl enable service` - Enables the service (again sudo)
    - automatically runs (nginx) when booting linux, rather than having to manuanlly start it

- `sleep x` - Counts down for x seconds. Will occupy your terminal unless you run it with &.
  
- `ps` - Prints the currently running user processes
  - `-p <PID>` prints the process with the given process id (PID).
    - `ps -p $$` prints the bash process
    - `ps aux` displays alot more information and system proceses (snapshot)
  - `top` - Prints the system processes. Similar to ps aux but  (live). Sort by shift+key (e.g. shift+M to sort by memory)
- `jobs` - Prints currently running jobs

- `kill -x pid` - Kills process with pid with kill signal x (default: 15)
  - 15 gracefully tries to kill the process by stopping child processes first then the parent ('Terminated')
  - 9 is brute force kill, harshest possible, could make zombie processes if you kill a parent process ('Killed')

## Shell editing

- `printenv` - Prints environemnt variables
- `MYNAME=josh` - (local) Variable assignment
    - print with `echo $MYNAME`
    - to make an environment variable, `export MYNAME=josh`
    - these variables do not last between sessions
    - to make it persistent, we can edit our bash shell by editing `.bashrc` and adding it to the bottom of it
      - user level (created when you log in) (when added to .bashrc)

- credentials should be stored in memory (NEVER ON DISK)
    - E.G. store credentials in an environment variable rather than put them in a file)






