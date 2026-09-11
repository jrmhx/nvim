# AGENTS.md

## Scope

These instructions apply to the entire repository. This is a personal Neovim
configuration built on NvChad v2.5 and Neovim 0.11 or newer.

## Repository map

- `init.lua` bootstraps lazy.nvim and NvChad, then loads local configuration.
- `lua/plugins/init.lua` declares plugins, Mason tools, and Treesitter parsers.
- `lua/configs/lspconfig.lua` configures and enables language servers.
- `lua/configs/conform.lua` controls formatters and format-on-save behavior.
- `lua/configs/dap.lua` configures debugging adapters and mappings.
- `lua/autocmds.lua` contains local autocommands.
- `lua/mappings.lua` contains local key mappings.
- `lua/options.lua` contains editor options.
- `lua/chadrc.lua` contains NvChad UI settings.
- `README.md` is the English user documentation.
- `README_Zh.md` is the Chinese user documentation.

## Editing guidelines

- Keep changes small and consistent with the existing Lua style.
- Use two-space indentation in Lua files.
- Prefer NvChad and Neovim 0.11 APIs already used by this repository.
- Put plugin declarations in `lua/plugins/init.lua` and plugin-specific options
  in `lua/configs/` when the configuration is substantial.
- Do not hard-code user-specific project paths. Derive paths from the current
  buffer, working directory, or `vim.fn.stdpath()` as appropriate.
- Preserve format-on-save behavior for configured languages. C# formatting is
  performed by Roslyn so project `.editorconfig` rules remain authoritative.
- When adding a Mason-managed tool, update `ensure_installed` and document any
  external runtime or SDK requirement.
- Keep `README.md` and `README_Zh.md` aligned when user-facing behavior,
  installation steps, commands, or mappings change.
- Do not edit `lazy-lock.json` manually; let lazy.nvim update it.
- Preserve unrelated local or uncommitted changes.

## Validation

After changing Lua configuration, run the most relevant checks available:

```sh
stylua --check .
nvim --headless '+checkhealth' +qa
```

If the Neovim AppImage cannot use FUSE, use:

```sh
APPIMAGE_EXTRACT_AND_RUN=1 nvim --headless '+checkhealth' +qa
```

For a lightweight syntax check that avoids loading plugins:

```sh
APPIMAGE_EXTRACT_AND_RUN=1 nvim --headless -u NONE -i NONE \
  '+lua assert(loadfile("lua/configs/conform.lua"))' +qa
```

Also run `git diff --check` before handing off changes. For LSP or formatter
changes, describe an appropriate interactive check such as `:LspInfo`,
`:ConformInfo`, saving a representative file, or using `<leader>fm`.

## Documentation style

- Write commands so they can be copied directly.
- Use `<leader>` for leader-key notation and mention that the leader is Space
  where that context is not already established.
- Describe only capabilities actually enabled by this configuration.
- Call out tools that users must install themselves instead of implying that
  Mason installs them automatically.
