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

    -- C# formatter. Roslyn still provides completion and automatic `using`
    -- imports; CSharpier keeps formatting deterministic across editors.
    cs = { "csharpier" },
  },

  format_on_save = {
    timeout_ms = 2000,

    -- Do not fall back to LSP formatting. Every auto-formatted language above
    -- has one explicit formatter, which avoids two formatters fighting.
    lsp_fallback = false,
  },
}

return options
