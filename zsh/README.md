# Zsh + oh-my-zsh
This folder contains the following:
- `.zshrc` file with settings, aliases, functions, etc.
- `ghi.zsh-theme` that is used in .zshrc. The left prompt contains red ᗈ, current folder and red colon. The right prompt contains current Git branch when in a repository.
- `install.sh` script that installs the package dependencies, downloads oh-my-zsh and the previous two files.

# Installation
## Manual
1. Install zsh, git and source-highlight.
2. Download oh-my-zsh.
3. Download `ghi.zsh-theme` and put it in `~/.oh-my-zsh/custom/themes`.
4. Download `.zshrc` and replace the one in your home folder.

## Automatic
| :warning: This has only only been tested on Ubuntu 18 and there are probably some things I haven't thought about. Check the script before running it.|
| - |

Run:

```bash -c "$(wget -O- https://raw.githubusercontent.com/redant333/dotfiles/master/zsh-oh-my-zsh/install.sh)"```

or download `install.sh` and run it.

The following packages will be installed:
- zsh - for the obvious reasons
- git - needed for the right prompt
- wget - needed for the downloading of `.zshrc` and `ghi.zsh-theme`
- source-highlight - to give syntax highlighting abilities to less

The following repositories will be cloned:
- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)

The following files will be downloaded:
- `.zshrc`
- `ghi.zsh-theme`
