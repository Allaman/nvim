# My NeoVim Configuration

![](./screen.png)

This is my first Lua based NeoVim (>0.5) configuration. My goal was to achieve the same functionality as [my old vimrc](https://github.com/Allaman/dotfiles/blob/master/vimrc) and move onwards to a full Lua based configuration and Lua based plugins especially the promising builtin [LSP](https://neovim.io/doc/user/lsp.html) and [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter).

## Motivation

There is a number of great NeoVim configurations online (see [Inspiration](#inspiration)) that give you a pleasant experience right out of the box. However, I am a long time (Neo)Vim user with a specific workflow and needs. Additionally, I do not have any Lua background and was not willing to spent to much time into that. Therefore, it was quite hard for me to customize and strip down the existing configs my needs especially because the code is quite sophisticated.

So I decided to move to a fresh Lua based NeoVim on my own trying to accomplish the following:

1. At least feature parity with my mentioned old vimrc
2. Migrate to Lua based alternative plugins
3. Keep the config as simple as possible knowing that this would possibly impact the code quality
4. Just make it work and not make it beautiful 😃

## Structure

```sh
.
├── ftplugin/         # file specific settings
├── init.lua          # Lua files to be sourced
├── lua
│   ├── autocmd.lua   # vim autocommands
│   ├── mappings.lua  # main keymaps defintions
│   ├── options.lua   # general settings
│   ├── plugins/      # each plugin configuration is in its own file
│   ├── plugins.lua   # define plugins to be managed via Packer
│   └── user.lua      # TODO
```

## Inspiration

- [LunarVim](https://github.com/LunarVim/LunarVim)
- [SpaceVim](https://spacevim.org/)
- [Doom-nvim](https://github.com/NTBBloodbath/doom-nvim)
- [spf13-vim](https://github.com/spf13/spf13-vim)
- [Janus](https://github.com/carlhuda/janus)
