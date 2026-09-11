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

    -- Roslyn honors the project's full C#/.NET .editorconfig rule set.
    cs = { lsp_format = "prefer" },
  },

  format_on_save = {
    timeout_ms = 2000,
  },
}

return options
