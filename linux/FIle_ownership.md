# File ownership

## Why is managing file ownership important?
File ownership is important since we do not want just anybody to access our files for security reasons. We would like to offer the minimal file access possible e.g. only provide access to what is necessary. 
## What is the command to view file ownership?
`ls` lists the files in the directory, `-a` additionally lists hidden files, and `-l` lists the permissions. 

Therefore, we can run `ls -al` to list the permissions (file ownership) of all the files.

Equivalently, we can run `ll`. 
## What permissions are set when a user creates a file or directory? Who does file or directory belong to?
By default, only read access is turned on for the owner and everything else is off. The file belongs to the user logged in that created the file 
## Why does the owner, by default, not receive X permissions when they create a file?
For convienience and security, only read access is set for the owner. This is because reading a file is a safe operation (it does not make critical changes to the system) and the owner, since they wrote the file, already knew the contents of the file. Write or executable access could be unsafe so it is not turned on by default, but it is easily changed if you need it. 

- `chmod permissions filename` - Changes the permissions of file to the given permissions:
    - You can give permissions in longform (with letters) or shortform (with octal)
        - Longform: `chmod rwxrwxrwx file`
        - Shortform: `chmod 777 file` (4=r,2=w,1=x, the groups are user, groups and other users)
## What command is used to change the owner of a file or directory?
`chown new_owner file` changes the owner of the file to the one provided. The command must be run as root or sudo. 
