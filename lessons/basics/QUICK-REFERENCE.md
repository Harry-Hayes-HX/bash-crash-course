# Bash Quick Reference

One-page cheat sheet for help desk use. Use with the [lessons](lessons/) for context.

---

## Navigation

| Command | Description |
|---------|-------------|
| `pwd` | Print working directory (where am I?) |
| `ls` | List files and folders here |
| `ls -l` | List with details (permissions, size, date) |
| `cd folder` | Change into `folder` |
| `cd ..` | Go up one directory |
| `cd` or `cd ~` | Go to home directory |

---

## Viewing and creating

| Command | Description |
|---------|-------------|
| `cat file` | Show entire file |
| `head -n 5 file` | First 5 lines |
| `tail -n 5 file` | Last 5 lines |
| `mkdir name` | Create directory |
| `touch file` | Create empty file (or update its time) |

---

## Copy, move, delete

| Command | Description |
|---------|-------------|
| `cp src dest` | Copy file |
| `mv src dest` | Move (or rename) file |
| `rm file` | Delete file (no undo) |
| `rm -r folder` | Delete folder and contents |

---

## Finding and filtering

| Command | Description |
|---------|-------------|
| `find dir -name "*.log"` | Find files by name under `dir` |
| `find dir -type f` | Only files |
| `grep "text" file` | Lines containing `text` |
| `grep -i "text" file` | Same, ignore case |
| `grep -n "text" file` | Show line numbers |
| `cmd1 | cmd2` | Pipe: output of cmd1 → input of cmd2 |

---

## Permissions and users

| Command | Description |
|---------|-------------|
| `ls -l` | Long list (see r/w/x for owner, group, others) |
| `whoami` | Current username |
| `id` | User and group ids |
| `chmod u+x file` | Add execute for owner |
| `chmod 644 file` | Common file: rw for owner, r for others |
| `chmod 755 dir` | Common dir: rwx owner, rx others |

---

## Variables and scripts

| Command / syntax | Description |
|------------------|-------------|
| `VAR=value` | Set variable (no spaces around `=`) |
| `$VAR` | Use variable |
| `$(command)` | Use output of command as value |
| `echo "text"` | Print text |
| `echo "x" >> file` | Append line to file |
| `bash script.sh` | Run script with Bash |

---

## Help

| Command | Description |
|---------|-------------|
| `man command` | Manual page for command (q to quit) |
| `command --help` | Short help (when available) |

---

*When you get "Permission denied," check `whoami` and `ls -l` on the file or folder.*
