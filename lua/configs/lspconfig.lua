-- read :h vim.lsp.config for changing options of lsp servers 

-- load NvChad default LSP configs like keymaps capabilities
require("nvchad.configs.lspconfig").defaults()

-- the LSP servers we need to load（name must be same as in lspconfig）
local servers = {
  "html",
  "cssls",
  "clangd",
  "gopls",
}

-- enable lsp by vim.lsp 
vim.lsp.enable(servers)

-- clangd
vim.lsp.config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
  },
})

-- gopls config
vim.lsp.config("gopls", {
  settings = {
    gopls = {
      -- autocomplete import
      completeUnimported = true,
      usePlaceholders = true,

      --lint and analyses
      analyses = {
        unusedparams = true,
        nilness = true,
        unusedwrite = true,
        useany = true,
      },

      staticcheck = true, -- golangci-lint
      gofumpt = true, 
    },
  },
})
