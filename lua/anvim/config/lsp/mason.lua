require("mason").setup({
  ui = {
    -- Whether to automatically check for new versions when opening the :Mason window.
    check_outdated_packages_on_open = true,

    -- The border to use for the UI window. Accepts same border values as |nvim_open_win()|.
    border = "none",

    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },

    keymaps = {
      -- Keymap to expand a package
      toggle_package_expand = "<CR>",
      -- Keymap to install the package under the current cursor position
      install_package = "i",
      -- Keymap to reinstall/update the package under the current cursor position
      update_package = "u",
      -- Keymap to check for new version for the package under the current cursor position
      check_package_version = "c",
      -- Keymap to update all installed packages
      update_all_packages = "U",
      -- Keymap to check which installed packages are outdated
      check_outdated_packages = "C",
      -- Keymap to uninstall a package
      uninstall_package = "X",
      -- Keymap to cancel a package installation
      cancel_installation = "<C-c>",
      -- Keymap to apply language filter
      apply_language_filter = "<C-f>",
    },
  },

  -- The directory in which to install packages.
  -- install_root_dir = path.concat({ vim.fn.stdpath("data"), "mason" }),
})

require("mason-lspconfig").setup({})

require("mason-tool-installer").setup({

  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  ensure_installed = {
    -- LSP
    "bash-language-server",
    "dockerfile-language-server",
    "json-lsp",
    "marksman",
    "typescript-language-server",
    "texlab",
    "lua-language-server",
    "pyright",
    "terraform-ls",
    "yaml-language-server",
    -- Formatter
    "black",
    "prettier",
    "stylua",
    -- Linter
    "eslint_d",
    "shellcheck",
    "tflint",
    "vale",
    "yamllint",
    -- DAP
    "debugpy",
  },

  -- if set to true this will check each tool for updates. If updates
  -- are available the tool will be updated. This setting does not
  -- affect :MasonToolsUpdate or :MasonToolsInstall.
  -- Default: false
  auto_update = false,

  -- automatically install / update on startup. If set to false nothing
  -- will happen on startup. You can use :MasonToolsInstall or
  -- :MasonToolsUpdate to install tools and check for updates.
  -- Default: true
  run_on_start = true,

  -- set a delay (in ms) before the installation starts. This is only
  -- effective if run_on_start is set to true.
  -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
  -- Default: 0
  start_delay = 3000, -- 3 second delay
})
