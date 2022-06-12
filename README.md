# My Neovim Configuration

![](./screen.png)

💻 This configuration is working on my [Manjaro](https://manjaro.org/) Linux as well as on my macOS and requires Neovim dev build (0.8)!

Have a look at my [rice](https://github.com/Allaman/rice) how my Linux machine is configured and at my [mac-setup](https://github.com/Allaman/mac-setup) how my MBP is configured. My [dotfiles](https://github.com/Allaman/dotfiles) are also on Github.

## Motivation

There is a number of great Neovim configurations online (see [Inspiration](#inspiration)) that give you a pleasant experience right out of the box. However, I am a long time (Neo)Vim user with a specific workflow and needs. Additionally, I do not have any Lua background and was not willing to spent too much time into that. Therefore, it was quite hard for me to customize and strip down the existing configs to my needs especially because the code is quite sophisticated.

I decided to move to my own fresh Lua based Neovim from my good old vimrc trying to accomplish the following principles.

## Principles

1. Migrate to Lua based alternative plugins respectively use only Lua based plugins (if possible).
1. Keep the config as simple as possible knowing that this would possibly impact the code quality.
1. Modular and meaningful directory structure and file naming.
1. Just make it work and not make it beautiful 😃. Of course, Neovim itself must look beautiful but my focus is not on beautiful code or on utilizing all Lua features.

## Try out

If you have [Docker](https://www.docker.com/) on your system you can try out this config via the provided `Dockerfile`

💡 All dependencies of my config are installed except texlab, tectonic, and vim-grammarous which makes it at **1.9GB** a rather large image

### Build the image

There are some issues with building a multi architecture Docker image via Github Action. Until I sorted that out, you can build the Docker image locally on your own

```sh
docker build -t nvim .
```

### Just start nvim

```sh
docker run --name nvim --rm -it nvim
```

### Mount a local directory (to ~/mount) and start nvim

```sh
docker run --name nvim --rm -it -v ${HOME}/tmp:/home/nvim/mount nvim
```

### Start container in bash instead of nvim

```sh
docker run --name nvim --rm -it --entrypoint=/bin/bash nvim
```

## Features

### General ⚙️

- Package management and plugin configuration via [Packer](https://github.com/wbthomason/packer.nvim)
- Mnemonic keyboard mappings inspired by [Spacemacs](https://www.spacemacs.org/) via [which-key.nvim](https://github.com/folke/which-key.nvim); no more than three keystrokes for each keybinding
- Fully featured status line via [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- Terminal integration via [nvim-toggleterm.lua](https://github.com/akinsho/nvim-toggleterm.lua)
- Fancy notifications via [nvim-notify](https://github.com/rcarriga/nvim-notify)
- Fast startup 🚀

### Navigation 🧭

- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for all your search needs
- Project management with [Project.nvim](https://github.com/ahmedkhalf/project.nvim)
- File tree navigation/manipulation via [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua)
- Easy Tmux navigation with your home row via [Navigator.nvim](https://github.com/numToStr/Navigator.nvim)
- Buffer management via [Bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- [LF](https://github.com/gokcehan/lf) integration via [lf.vim](https://github.com/ptzz/lf.vim) for a full featured file manager in Neovim
- Convenient jumping through windows with [nvim-window](https://gitlab.com/yorickpeterse/nvim-window)

### Coding 🖥️

- Auto completion powered by [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- Built-in LSP configured via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) and [Tresitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) for your syntax needs
- Auto formatting via [null-ls.nvim](https://github.com/jose-elias-alvarez/null-ls.nvim)
- Excellent Go support via LSP and [go.nvim](https://github.com/ray-x/go.nvim) including sensible keybindings
- Git integration via [Neogit](https://github.com/TimUntersberger/neogit), [gitsigns](https://github.com/lewis6991/gitsigns.nvim), [git-blame](https://github.com/f-person/git-blame.nvim), and [gitui](https://github.com/extrawurst/gitui)
- Schema integration via LSPs for Kubernetes, package.json, github workflows, gitlab-ci.yml, kustomization.yaml, and more
- Always know where you are in your code via [nvim-navic](https://github.com/SmiteshP/nvim-navic)
- Outlining symbols with [symbols-outline.nvim](https://github.com/simrat39/symbols-outline.nvim)
- Snippets provided by [Luasnip](https://github.com/L3MON4D3/LuaSnip) and [friendly snippets](https://github.com/rafamadriz/friendly-snippets) with autocompletion

## Structure

Each plugin to be installed is defined in `plugins.lua` and each plugin has its own configuration file (if necessary) in `lua/config/` which is loaded by packer.

```sh
.
├── after
│   └── ftplugin      # file specific settings
├── init.lua          # main entry point
├── lua
│   ├── config/       # each plugin configuration is in its own file
│   ├── autocmd.lua   # autocommands
│   ├── functions.lua # lua functions to extend functionality
│   ├── mappings.lua  # Vim keymaps definitions -> config/which.lua for more
│   ├── options.lua   # non plugin related (vim) options
│   ├── plugins.lua   # define plugins to be managed via Packer
│   └── user-conf.lua # parameters to configure some settings
├── plugin            # packer_compiled
├── snippets          # snippets directory (luasnip style)
└── spell             # my spell files linked from another repo
```

## Bindings

| Mode | key                    | binding                                                |
| ---- | ---------------------- | ------------------------------------------------------ |
| n    | space                  | Leader key                                             |
| n    | ⬆ ⬇ ⬅ ➡                | Resize panes                                           |
| n    | \<c-h \| j \| k \| l\> | Change pane focus (including Tmux panes)               |
| n    | \<leader\>Tab          | Switch to previously opened buffer                     |
| n    | \<Tab\>                | Switch to next buffer (via bufferline)                 |
| n    | \<S-Tab\>              | Switch to previous buffer (via bufferline)             |
| n    | st                     | Visual selection with Treesitter hint textobject       |
| v    | sa                     | Add surrounding                                        |
| n    | sd                     | Delete surrounding                                     |
| n    | sr                     | Replace surrounding                                    |
| v    | ga                     | Easyalign                                              |
| n    | gcc                    | Toggle line comment                                    |
| n/v  | gc                     | Toggle line comment (works with movements like `gcip`) |
| n    | ss                     | Search 2 char forward (lightspeed)                     |
| n    | S                      | Search 2 char backward (lightspeed)                    |
| i/s  | \<c-j\>                | Luasnip expand/forward                                 |
| i/s  | \<c-k\>                | Luasnip backward                                       |
| i    | \<c-h\>                | Luasnip select choice                                  |
| n    | \<c-n\>                | Toggleterm (opens/hides a full terminal in Neovim)     |
| i    | \<c-l\>                | Move out of closing bracket                            |
| n    | \<CR\>                 | Start incremental selection                            |
| v    | \<Tab\>                | Increment selection                                    |
| v    | \<S-Tab\>              | Decrement selection                                    |

## Which-key leader key clusters

Mappings are clustered according to their topic/tool.

See `./lua/config/which.lua` for details.

| key | cluster                                                |
| --- | ------------------------------------------------------ |
| b   | Buffer management                                      |
| c   | Language specific actions (only in Go, e.g. run tests) |
| f   | File management                                        |
| g   | Git actions                                            |
| h   | Harpoon integration                                    |
| l   | LSP integration (only when a LSP is attached)          |
| m   | Misc stuff                                             |
| q   | Quickfix                                               |
| s   | Searching                                              |
| w   | Window management                                      |
| x   | Languagetool integration                               |
| z   | Spell bindings                                         |

## User configuration (experimental)

The intention of my Neovim configuration was never to be a fully customizable "distribution" like LunarVim, SpaceVim, etc but from time to time I like to change my color scheme and the idea of making this configurable came to my mind. Based upon this idea I implemented some further lightweight configuration options that might be useful.

All options can be found in `./lua/user-conf.lua`.

## Remove plugins

Basically, you can remove unwanted plugins by just removing the appropriate line in `./lua/plugins.lua` and, if applicable, delete its configuration file in `./lua/config/`.

ℹ️ Keep in mind that some plugins are configured to work in conjunction with other plugins. For instance, autopairs is configured in `./lua/config/treesitter.lua`. For now there is no logic implemented that cross-checks such dependencies.

## Add plugins

If you want to follow my method adding a plugin is simple:

In `lua/plugins.lua` add the plugin to Packer. You are free to use a name for the configuration file (should be a valid filename).

```lua
use {"<Address-of-the-plugin>", config = get_config("<name-of-the-plugin>")}
```

Create `lua/config/<name-of-the-plugin>.lua` where you put the plugins settings. If your plugin does not require additional configuration or loading you can omit the config part.

Open another instance of Neovim (I always try to keep one running instance of Neovim open in case I messed up my config) and run `PackerSync`.

## Requirements

There are some tools that are required in order to use some features/plugins:

### Tools

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)
- [fzf](https://github.com/junegunn/fzf)

### Autoformatting

- [prettier](https://prettier.io/)
- `go install mvdan.cc/gofumpt@latest`
- [terraform fmt](https://www.terraform.io/docs/cli/commands/fmt.html)
- [stylua](https://github.com/JohnnyMorganz/StyLua)
- [black](https://github.com/psf/black)

### Language Servers

For the builtin LSP (see [lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md) for more info about LSP configuration)

- `sudo npm i -g bash-language-server dockerfile-language-server-nodejs yaml-language-server typescript typescript-language-server vscode-langservers-extracted`
- `go install golang.org/x/tools/gopls@latest` (optional `golangci-lint`, `gomodifytags`, `gorename`)
- `go install golang.org/x/tools/cmd/goimports@latest`
- [pyright](https://github.com/microsoft/pyright) as Python LSP
- [terraform-ls](https://github.com/hashicorp/terraform-ls)
- [lua-language-server](https://github.com/sumneko/lua-language-server)
- [texlab](https://github.com/latex-lsp/texlab) and [tectonic](https://github.com/tectonic-typesetting/tectonic)
- For advanced spell checks via [vim-grammarous](https://github.com/rhysd/vim-grammarous) Java 8+ is required

## Inspiration

- [LunarVim](https://github.com/LunarVim/LunarVim)
- [SpaceVim](https://spacevim.org/)
- [Doom-nvim](https://github.com/NTBBloodbath/doom-nvim)
- [spf13-vim](https://github.com/spf13/spf13-vim)
- [NvChad](https://nvchad.github.io/)
- [Janus](https://github.com/carlhuda/janus)
