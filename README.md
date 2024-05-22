# napas-neovim

This is my neovim config

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

### Nvim-tree

| Command          | Description                                 |
| ---------------- | ------------------------------------------- |
| `CTRL-w h`       | Go to left window                           |
| `CTRL-w l`       | Go to right window                          |
| `a`              | Add a new file when cursor in file explorer |
| `d`              | Delete file when in cursor in file explorer |
| `r`              | Rename file name                            |
| `<SPACE BAR> ee` | Open File Explorer                          |

### TeleScope

| Command          | Description                |
| ---------------- | -------------------------- |
| `<SPACE BAR> ff` | Find file                  |
| `<SPACE BAR> fs` | Find string in the project |
| `<SPACE BAR> ft` | Find todo                  |

### Bufferline

| Command         | Description          |
| --------------- | -------------------- |
| `<TAB>`         | Change Buffer        |
| `<SPACE BAR> q` | Close current Buffer |

### Open/Close Terminal

| Command          | Description                                 |
| ---------------- | ------------------------------------------- |
| `<SPACE BAR> ch` | Open Terminal (Split Horizontal)            |
| `<SPACE BAR> cf` | Open Terminal (Split Float)                 |
| `exit`           | Type exit in terminal to close the terminal |

### Git

| Command          | Description                  |
| ---------------- | ---------------------------- |
| `<SPACE BAR> lg` | Open Lazygit                 |
| `<SPACE BAR> ge` | Enable git blame             |
| `<SPACE BAR> gd` | Disable git blame            |
| `<SPACE BAR> go` | Open code on default browser |
