local options = {
  formatters_by_ft = {
    c = { "clang-format" },
    cpp = { "clang-format" },
    objc = { "clang-format" },
    cuda = { "clang-format" },

    -- Use Go's native formatter
    go = { "gofumpt" },

    -- Lua formatter
    lua = { "stylua" },
  },

  format_on_save = {
    timeout_ms = 500,

    -- Do NOT fall back to LSP formatting
    -- This avoids conflicts with clangd / gopls
    lsp_fallback = false,
  },
}

return options

