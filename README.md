# My NeoVim Configuration

![](./screen.png)

This is my first Lua based NeoVim (>0.5) configuration. My goal was to achieve the same functionality as [my old vimrc](https://github.com/Allaman/dotfiles/blob/master/vimrc) and move onwards to a full Lua based configuration and Lua based plugins especially the promising builtin [LSP](https://neovim.io/doc/user/lsp.html) and [Treesitter](https://github.com/nvim-treesitter/nvim-treesitter).

As I am not familiar with Lua I tried to accomplish the migration with very basic and minimal use of its language features and make it just work and not make it beautiful 😃

## Structure

```sh
.
├── ftplugin/  # file specific settings
├── init.lua # lists all other Lua files to be sourced
├── lua
│   ├── autocmd.lua # vim autocommands
│   ├── globals.lua # vim.g options
│   ├── mappings.lua  # all not plugin related mappings
│   ├── options.lua # all not plugin specific settings
│   ├── plugins/ # each plugin configuration is in its own file
│   ├── plugins.lua # define plugins to be managed via Packer
│   ├── ui.lua # UI related config
│   └── user.lua  # TODO
```
