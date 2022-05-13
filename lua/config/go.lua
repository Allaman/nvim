require("go").setup({
	go = "go", -- go command, can be go[default] or go1.18beta1
	goimport = "gopls", -- goimport command, can be gopls[default] or goimport
	fillstruct = "gopls", -- can be nil (use fillstruct, slower) and gopls
	gofmt = "gofumpt", -- gofmt cmd,
	max_line_len = 120, -- max line length in goline format
	tag_transform = false, -- tag_transfer  check gomodifytags for details
	test_template = "", -- default to testify if not set; g:go_nvim_tests_template  check gotests for details
	test_template_dir = "", -- default to nil if not set; g:go_nvim_tests_template_dir  check gotests for details
	comment_placeholder = "", -- comment_placeholder your cool placeholder e.g. ﳑ       
	icons = { breakpoint = "🧘", currentpos = "🏃" },
	verbose = false, -- output loginf in messages
	lsp_cfg = true, -- true: use non-default gopls setup specified in go/lsp.lua
	-- false: do nothing
	-- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
	--   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
	lsp_gofumpt = false, -- true: set default gofmt in gopls format to gofumpt
	lsp_on_attach = true, -- nil: use on_attach function defined in go/lsp.lua,
	--      when lsp_cfg is true
	-- if lsp_on_attach is a function: use this function as on_attach function for gopls
	lsp_codelens = false, -- set to false to disable codelens, true by default
	lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
	lsp_diag_hdlr = true, -- hook lsp diag handler
	lsp_diag_virtual_text = { space = 0, prefix = "" }, -- virtual text setup
	lsp_diag_signs = true,
	lsp_diag_update_in_insert = false,
	lsp_document_formatting = false,
	-- set to true: use gopls to format
	-- false if you want to use other formatter tool(e.g. efm, nulls)
	gopls_cmd = nil, -- if you need to specify gopls path and cmd, e.g {"/home/user/lsp/gopls", "-logfile","/var/log/gopls.log" }
	gopls_remote_auto = true, -- add -remote=auto to gopls
	dap_debug = false, -- set to false to disable dap
	dap_debug_keymap = false, -- true: use keymap for debugger defined in go/dap.lua
	-- false: do not use keymap in go/dap.lua.  you must define your own.
	dap_debug_gui = true, -- set to true to enable dap gui, highly recommand
	dap_debug_vt = true, -- set to true to enable dap virtual text
	build_tags = "", -- set default build tags
	textobjects = true, -- enable default text jobects through treesittter-text-objects
	test_runner = "go", -- richgo, go test, richgo, dlv, ginkgo
	run_in_floaterm = false, -- set to true to run in float window.
	-- float term recommand if you use richgo/ginkgo with terminal color
})
