# My NeoVim Configuration

![](./screen.png)

This is my first Lua based NeoVim (>=0.6) configuration. My goal was to achieve the same functionality as [my old vimrc](https://github.com/Allaman/dotfiles/blob/master/vimrc) and move onwards to a full Lua based configuration and Lua based plugins especially the promising builtin [LSP](https://neovim.io/doc/user/lsp.html) and [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter).

💻 This configuration is working on my [Manjaro](https://manjaro.org/) Linux as well as on my macOS!

Have a look at my [rice](https://github.com/Allaman/rice) how my Linux machine is configured and at my [mac-setup](https://github.com/Allaman/mac-setup) how my MacBook is configured. The Tmux configuration you can see in the image is [here](https://github.com/Allaman/dotfiles/blob/master/tmux.conf) (as well as my other dotfiles).

## Motivation

There is a number of great NeoVim configurations online (see [Inspiration](#inspiration)) that give you a pleasant experience right out of the box. However, I am a long time (Neo)Vim user with a specific workflow and needs. Additionally, I do not have any Lua background and was not willing to spent too much time into that. Therefore, it was quite hard for me to customize and strip down the existing configs to my needs especially because the code is quite sophisticated.

So I decided to move to a fresh Lua based NeoVim on my own trying to accomplish the following principles:

## Principles

1. At least feature parity with my mentioned old vimrc (my lua config is superior almost since day one (or two 😉)).
2. Migrate to Lua based alternative plugins.
3. Keep the config as simple as possible knowing that this would possibly impact the code quality.
4. Modular and meaningful directory structure and file naming.
5. Just make it work and not make it beautiful 😃. Of course, NeoVim itself must look beautiful but my Focus is not on beautiful code or on utilizing all Lua features.

## Features

### General ⚙️

- Package management and plugin configuration via [Packer](https://github.com/wbthomason/packer.nvim)
- Mnemonic keyboard mappings inspired by [Spacemacs](https://www.spacemacs.org/) via [which-key.nvim](https://github.com/folke/which-key.nvim); no more than three keystrokes for each keybinding
- Minimal yet fully featured status line via [Lualine](https://github.com/nvim-lualine/lualine.nvim)
- Terminal integration via [nvim-toggleterm.lua](https://github.com/akinsho/nvim-toggleterm.lua)
- Fancy notifications via [nvim-notify](https://github.com/rcarriga/nvim-notify)
- Fast startup 🚀

### Navigation 🧭

- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) for all your search needs
- Project management with [Project.nvim](https://github.com/ahmedkhalf/project.nvim)
- File tree navigation/manipulation via [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua)
- Easy Tmux navigation with your home row via [Navigator.vim](https://github.com/numToStr/Navigator.nvim)
- Buffer management via [Bufferline.nvim](https://github.com/akinsho/bufferline.nvim)
- [LF](https://github.com/gokcehan/lf) integration via [lf.vim](https://github.com/ptzz/lf.vim) for a full featured file manager in Neovim

### Coding 🖥️

- Auto completion powered by [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
- Built-in LSP configured via [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter) and [Tresitter-textobjects](https://github.com/nvim-treesitter/nvim-treesitter-textobjects) for your syntax needs
- Asynchronous auto formatting via [Formatter.nvim](https://github.com/mhartington/formatter.nvim)
- Excellent Go support via LSP and [go.nvim](https://github.com/ray-x/go.nvim) including sensible keybindings
- Git integration via [Neogit](https://github.com/TimUntersberger/neogit), [gitsigns](https://github.com/lewis6991/gitsigns.nvim), [git-blame](https://github.com/f-person/git-blame.nvim), and [gitui](https://github.com/extrawurst/gitui)
- Schema integration via LSPs for Kubernetes, package.json, github workflows, gitlab-ci.yml, kustomization.yaml, and more
- YAML navigation via [yaml.nvim](https://github.com/cuducos/yaml.nvim); useful for your hundreds of lines of Kubernetes manifests 😉

## Structure

Each plugin to be installed is defined in `plugins.lua` and each plugin has its own configuration file (if necessary) in `lua/config` which is loaded by packer.

```
.
├── after
│   └── ftplugin      # file specific settings
├── init.lua          # main entry point
├── lua
│   ├── autocmd.lua   # vim autocommands
│   ├── config/       # each plugin configuration is in its own file
│   ├── mappings.lua  # Vim keymaps defintions -> config/which.lua for more
│   ├── options.lua   # non plugin related (vim) options
│   └── plugins.lua   # define plugins to be managed via Packer
├── plugin            # packer_compiled
├── snippets          # snippets for vsnip
└── spell             # my spell files linked from another repo
```

## Useful non leader bindings

| Mode | key              | binding                                              |
| ---- | ---------------- | ---------------------------------------------------- |
| n    | space            | Leader key                                           |
| v    | ga               | Easyalign                                            |
| n    | gcc              | Toggle line comment                                  |
| n/v  | gc               | Toggle line comment (works with movements like gcip) |
| n    | ⬆ ⬇ ⬅ ➡          | Resize panes                                         |
| i    | \<c-l\>          | Move out of closing bracket                          |
| n    | \<c-h\|j\|k\|l\> | change pane focus (including Tmux panes)             |
| n    | \<leader\>space  | switch to previously opened buffer                   |
| v    | sa               | Add surrounding                                      |
| n    | sd               | Delete surrounding                                   |
| n    | sr               | Replace surrounding                                  |

## Top level leader key bindings

See `./lua/config/which.lua` for details.

| key | cluster                                                |
| --- | ------------------------------------------------------ |
| b   | Buffer management                                      |
| c   | Language specific actions (only in Go, e.g. run tests) |
| f   | File management                                        |
| g   | Git actions                                            |
| h   | Harpoon integration                                    |
| l   | LSP integration                                        |
| m   | Misc stuff                                             |
| s   | Searching                                              |
| t   | Trouble integration                                    |
| w   | Window management                                      |
| x   | Languagetool integration                               |
| y   | YAML integration (only in YAML files)                  |
| z   | Spell bindings                                         |

## Remove plugins

Basically, you can remove unwanted plugins by just removing the appropriate line in `./lua/plugins.lua` and, if applicable, delete its configuration file in `./lua/config/`.

ℹ️ Keep in mind that some plugins are configured to work in conjunction with other plugins. For instance, autopairs is configured in `./lua/config/treesitter.lua`. For now there is no logic implemented that cross-checks such dependencies.

## Requirements

There are some tools that are required in order to use some features/plugins:

### Tools

- [ripgrep](https://github.com/BurntSushi/ripgrep)
- [fd](https://github.com/sharkdp/fd)

### Autoformatting

- [prettier](https://prettier.io/)
- [gofmt](https://pkg.go.dev/cmd/gofmt)
- [terraform fmt](https://www.terraform.io/docs/cli/commands/fmt.html)
- [luarocks](https://github.com/luarocks/luarocks) and `luarocks install --server=https://luarocks.org/dev luaformatter`
- [black](https://github.com/psf/black)

### Language Servers

For the builtin LSP (see [lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md) for more info about LSP configuration)

- `sudo npm i -g bash-language-server dockerfile-language-server-nodejs yaml-language-server typescript typescript-language-server vscode-langservers-extracted`
- `go get golang.org/x/tools/gopls` (optional `golangci-lint`, `gomodifytags`, `gorename`)
- [terraform-ls](https://github.com/hashicorp/terraform-ls)
- [texlab](https://github.com/latex-lsp/texlab) and [tectonic](https://github.com/tectonic-typesetting/tectonic)
- [lua-language-server](https://github.com/sumneko/lua-language-server)
- For advanced spell checks via [vim-grammarous](https://github.com/rhysd/vim-grammarous) Java 8+ is required

## Inspiration

- [LunarVim](https://github.com/LunarVim/LunarVim)
- [SpaceVim](https://spacevim.org/)
- [Doom-nvim](https://github.com/NTBBloodbath/doom-nvim)
- [spf13-vim](https://github.com/spf13/spf13-vim)
- [NvChad](https://nvchad.github.io/)
- [Janus](https://github.com/carlhuda/janus)
