<h1 align="center">My Nvim Configuration</h1>

<div align="center"><p>
    <a href="https://github.com/neovim/neovim">
      <img src="https://img.shields.io/badge/Neovim-0.10.0-blueviolet.svg?style=flat-square&logo=Neovim&color=90E59A&logoColor=white" alt="Neovim"/>
    </a>
    <a href="https://github.com/Allaman/nvim/pulse">
      <img src="https://img.shields.io/github/last-commit/Allaman/nvim" alt="Last commit"/>
    </a>
    <a href="https://github.com/Allaman/nvim/issues">
      <img src="https://img.shields.io/github/issues/Allaman/nvim.svg?style=flat-square&label=Issues&color=F05F40" alt="Github issues"/>
    </a>
    <a href="https://github.com/Allaman/nvim/actions/workflows/ci.yml">
      <img src="https://github.com/Allaman/nvim/actions/workflows/ci.yml/badge.svg" alt="CI Status"/>
    </a>
    <a href="https://github.com/Allaman/nvim/blob/main/LICENSE">
      <img src="https://img.shields.io/github/license/Allaman/nvim?style=flat-square&logo=MIT&label=License" alt="License"/>
    </a>
</p>

</div>

![Sewjp.png](https://s13.gifyu.com/images/Sewjp.png)

![Sewj4.png](https://s13.gifyu.com/images/Sewj4.png)

**README WIP**

**Terminal**: [ghostty](https://s7.gifyu.com/images/SXOsw.png)

**Font**: [Comic Code Ligatures](https://tosche.net/fonts/comic-code)

**Neovim Theme**: [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)

## Customization

⚠️ This is primarly my personal config

If you want to use my config there is the `./lua/vnext/extra/` folder that is loaded by lazy.nvim. The LazySpecs in this folder are merged with the "default" LazySpecs in the `./lua/vnext/plugins/` folder. Some examples you can do:

Disable a plugin:

```lua
return {
  {
    "Bekaboo/dropbar.nvim",
    enabled = false,
  },
}
```

Add new options to a plugin:

```lua
return {
  {
    "echasnovski/mini.surround",
    opts = {
      search_method = 'nearest',
    },
  }
}
```

Overwrite options of a plugin:

```lua
return {
  {
    "L3MON4D3/LuaSnip",
    opts = {
      -- define your own snippets folder
      snippets_path = { vim.fn.expand("~/mySnips") },
    },
  },
}
```

Change keys of a plugin:

```lua
return {
  {
    "MagicDuck/grug-far.nvim",
    keys = {
      -- stylua: ignore start
      { "<leader>R", hidden = true },
      { "<leader>RG", "<cmd>GrugFar<cr>", desc = "Open" },
      { "<leader>Rg", "<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<cr>", desc = "Open (Limit to current file)"},
      { "<leader>Rw", "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })<cr>", desc = "Search word under cursor", },
      { "<leader>Rs", mode = "v", "<cmd>lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand('%') } })<cr>", desc = "Search selection", },
      { "<leader>X", "", desc = "Search & Replace" },
      { "<leader>XG", "<cmd>GrugFar<cr>", desc = "Open" },
      { "<leader>Xg", "<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<cr>", desc = "Open (Limit to current file)"},
      { "<leader>Xw", "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })<cr>", desc = "Search word under cursor", },
      { "<leader>Xs", mode = "v", "<cmd>lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand('%') } })<cr>", desc = "Search selection", },
      -- stylua: ignore end
    },
  },
}
```

Check out my [blog post](https://rootknecht.net/blog/debloating-neovim-config/) to learn more about the reasons behind this big change. You can find the previous version in the [v1](https://github.com/Allaman/nvim/tree/v1) branch.
