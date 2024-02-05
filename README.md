# devconfig

Installs programs and configures files to set up a fresh Linux environment.

## Usage

Install programs:
```bash
./install.sh
```
This will also install and configure neovim (excluding Mason packages) and copy config files from subfolders.

Consider re-configuring oh-my-zsh with:
```bash
p10k configure
```

## TODO:
 - Confirm PARENT_PATH variable is correct in new scripts/ folders. 
 - Test updated install scripts.
 - Break out extras from basics in install scripts.
 - Download and configure use of nerdfonts.
 - Install vscode from dep or snap.
