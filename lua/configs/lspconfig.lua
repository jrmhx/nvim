-- read :h vim.lsp.config for changing options of lsp servers

-- load NvChad default LSP configs like keymaps capabilities
require("nvchad.configs.lspconfig").defaults()

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

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "basic",
      },
    },
  },
})

-- C# / .NET (Roslyn)
-- Mason's dotnet-tool package exposes `roslyn-language-server`, whereas the
-- default lspconfig command targets the platform-specific Roslyn binary.
vim.lsp.config("roslyn_ls", {
  cmd = { "roslyn-language-server", "--stdio" },
  settings = {
    ["csharp|background_analysis"] = {
      dotnet_analyzer_diagnostics_scope = "fullSolution",
      dotnet_compiler_diagnostics_scope = "fullSolution",
    },
    ["csharp|completion"] = {
      dotnet_show_completion_items_from_unimported_namespaces = true,
      dotnet_show_name_completion_suggestions = true,
    },
    ["csharp|formatting"] = {
      dotnet_organize_imports_on_format = true,
    },
    ["csharp|inlay_hints"] = {
      csharp_enable_inlay_hints_for_implicit_object_creation = true,
      csharp_enable_inlay_hints_for_implicit_variable_types = true,
      csharp_enable_inlay_hints_for_lambda_parameter_types = true,
      csharp_enable_inlay_hints_for_types = true,
      dotnet_enable_inlay_hints_for_indexer_parameters = true,
      dotnet_enable_inlay_hints_for_literal_parameters = true,
      dotnet_enable_inlay_hints_for_object_creation_parameters = true,
      dotnet_enable_inlay_hints_for_other_parameters = true,
      dotnet_enable_inlay_hints_for_parameters = true,
      dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
      dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
      dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
    },
    ["csharp|symbol_search"] = {
      dotnet_search_reference_assemblies = true,
    },
  },
})

-- the LSP servers we need to load（name must be same as in lspconfig）
local servers = {
  "html",
  "cssls",
  "clangd",
  "gopls",
  "basedpyright",
  "ruff",
  "roslyn_ls",
}

-- enable lsp by vim.lsp
vim.lsp.enable(servers)
