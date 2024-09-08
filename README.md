# napas-neovim

This is my neovim config

## Install Neovim

### macOS / OS X

#### Pre-built archives

The [Releases](https://github.com/neovim/neovim/releases) page provides pre-built binaries for macOS 10.15+.

For x86_64:

    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-x86_64.tar.gz
    tar xzf nvim-macos-x86_64.tar.gz
    ./nvim-macos-x86_64/bin/nvim

For arm64:

    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-macos-arm64.tar.gz
    tar xzf nvim-macos-arm64.tar.gz
    ./nvim-macos-arm64/bin/nvim

### [Homebrew](https://brew.sh) on macOS or Linux

    brew install neovim

### Linux

#### Pre-built archives

The [Releases](https://github.com/neovim/neovim/releases) page provides pre-built binaries for Linux systems.

```sh
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz
```

After this step add this to `~/.bashrc`:

    export PATH="$PATH:/opt/nvim-linux64/bin"

#### Debian

Neovim is in [Debian](https://packages.debian.org/search?keywords=neovim).

    sudo apt-get install neovim

## Setup

[gopls](https://github.com/golang/tools/tree/master/gopls)

```
go install golang.org/x/tools/gopls@latest
```

### Install NerdFont

```bash
brew tap homebrew/cask-fonts
brew install font-meslo-lg-nerd-font
```

## HotKey

### Core

| Command           | Description                                            |
| ----------------- | ------------------------------------------------------ |
| `:qa`             | Quit for all                                           |
| `:w`              | Save file                                              |
| `<SPACE BAR>`     | Which key                                              |
| `jk`              | Shortcut for exit for insert mode (can also use <ESC>) |
| `<SPACE BAR> +`   | Increment the number                                   |
| `<SPACE BAR> -`   | Decrement the number                                   |
| `<SPACE BAR> ws`  | Save session                                           |
| `<SPACE BAR> wr`  | Restore the session                                    |
| `<SPACWE BAR> nh` | Clear highlight search                                 |
| `CTRL + ]`        | Go to function that cursor is cover                    |
| `CTRL + o`        | Return to previous file (use after command CTRL + ])   |
| `<SPACE BAR> ee`  | close and open file explorer                           |
| `<SPACE BAR> /`   | comment and uncomment                                  |

### LSP

| Command          | Description                    |
| ---------------- | ------------------------------ |
| `gd`             | go to description              |
| `gi`             | go to implementation           |
| `gR`             | show LSP reference             |
| `<SPACE BAr> ca` | code action (list of action)   |
| `shift k`        | show documentation of function |

### Nvim-tree

| Command          | Description                                 |
| ---------------- | ------------------------------------------- |
| `CTRL-w h`       | Go to left window                           |
| `CTRL-w l`       | Go to right window                          |
| `a`              | Add a new file when cursor in file explorer |
| `d`              | Delete file when in cursor in file explorer |
| `r`              | Rename file name                            |
| `<SPACE BAR> ee` | Open File Explorer                          |
| `<SPACE BAR> ef` | Open File Explorer with current file        |

### TeleScope

| Command          | Description                |
| ---------------- | -------------------------- |
| `<SPACE BAR> ff` | Find file                  |
| `<SPACE BAR> fs` | Find string in the project |
| `<SPACE BAR> ft` | Find todo                  |

### Bufferline

| Command         | Description                   |
| --------------- | ----------------------------- |
| `<TAB>`         | Change to the next Buffer     |
| `<TAB> <CTRL>`  | Change to the previous Buffer |
| `<SPACE BAR> q` | Close current Buffer          |

### Open/Close Terminal

| Command             | Description                                 |
| ------------------- | ------------------------------------------- |
| `<Ctrl> t`          | Open/Close Terminal (float)                 |
| `exit or <Ctrl> t ` | Type exit in terminal to close the terminal |

### Git

| Command          | Description                  |
| ---------------- | ---------------------------- |
| `<SPACE BAR> lg` | Open Lazygit                 |
| `<SPACE BAR> ge` | Enable git blame             |
| `<SPACE BAR> gd` | Disable git blame            |
| `<SPACE BAR> go` | Open code on default browser |
