-- TODO: major refactoring is ongoing ...
-- see ./lua/config/defaults for all
-- possible values
return {
  dashboard = "none" | "alpha" | "dashboard-nvim",
  options = {
    relativenumber = true,
  },
  plugins = {
    alpha = {
      disable_dashboard_header = true,
    },
    spectre = {
      enable = false,
    },
  },
}
