require "nvchad.autocmds"

-- Show Roslyn's parameter and inferred-type hints automatically in C# files.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("CsharpInlayHints", { clear = true }),
  callback = function(args)
    if vim.bo[args.buf].filetype ~= "cs" then
      return
    end

    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
    end
  end,
})
