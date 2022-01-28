# Check if the current directory is a git repo

- not sure because there is .gitattributes and .gitignore file
- `git status`
- if the output is like :
  "fatal: Not a git repository (or any of the parent directories): .git"
  Then, the directory is not a git repository.

# .env why need to use `export` in front of the variables?

- https://unix.stackexchange.com/questions/368944/what-is-the-difference-between-env-setenv-export-and-when-to-use
  > "export VARIABLE_NAME='some value' is the way to set an environment variable in any POSIX-compliant shell (sh, dash, bash, ksh, etc.; also zsh). If the variable already has a value, you can use export VARIABLE_NAME to make it an environment variable without changing its value"

# import openzeppelin contract with @syntax with brownie-config.yaml

# parameters passing into the constructor:

- VRFCoordinator
- LinkToken
- keyhash - to check if the number generated is truly random
  Don't really know what they are now

# enum statement does not require a `;` at the end of line
