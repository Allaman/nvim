require("project_nvim").setup {
    patterns = {
        ".git", "package.json", ".terraform", "go.mod", "requirements.yml"
    },
    -- detection_methods = { "lsp", "pattern" },
    detection_methods = {"pattern"}
}
