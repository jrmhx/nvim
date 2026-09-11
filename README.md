# Neovim / NvChad Development Environment

This repository contains an NvChad v2.5 configuration for C, C++, Go, Python,
HTML, CSS, Lua, and .NET/C# development. It provides language servers,
completion, formatting, syntax highlighting, and debugging where noted below.

The leader key is `Space`.

## Installation and first launch

### Requirements

- Neovim 0.11.4 or newer (the configuration has been checked with 0.11.5)
- Git, curl or wget, unzip, and tar
- A terminal font with Nerd Font glyphs for NvChad's icons
- The compiler, runtime, or SDK required by each language you use

On Linux, see the [official Neovim installation
documentation](https://neovim.io/doc/user/starting.html#install). If the
AppImage cannot use FUSE, extract it first or launch it with
`APPIMAGE_EXTRACT_AND_RUN=1 nvim`.

Back up your existing configuration, clone this repository, and start Neovim:

```sh
git clone <repository-url> ~/.config/nvim
nvim
```

On the first launch, Lazy installs the plugins and Mason installs the tools
declared by this configuration. Restart Neovim when installation finishes.

Useful health and installation commands:

```vim
:Lazy
:Mason
:MasonToolsUpdate
:TSInstallInfo
:checkhealth mason
:checkhealth vim.lsp
```

Open a project from its root so language servers, builds, tests, and debugger
paths use the correct working directory:

```sh
cd /path/to/project
nvim .
```

## C and C++

### Tooling

The first launch installs `clangd`, `clang-format`, and `codelldb`. Treesitter
parsers are installed for both C and C++. You still need a compiler such as
Clang or GCC and, for many projects, a build system such as CMake or Make.

- `clangd` supplies completion, navigation, diagnostics, and code actions.
- `clang-format` formats C, C++, Objective-C, and CUDA files on save.
- `codelldb` provides C and C++ debugging.

For the best `clangd` results, generate a `compile_commands.json` file. A common
CMake workflow is:

```sh
cmake -S . -B build -DCMAKE_BUILD_TYPE=Debug \
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build build
ln -s build/compile_commands.json compile_commands.json
```

If the project uses Make instead, build it with the project's documented
command. Open a source file and use `:LspInfo` to confirm that `clangd` is
attached.

### Run, test, and debug

Run an executable or the project's test driver from a terminal. For a typical
CMake project:

```sh
./build/my-program
ctest --test-dir build --output-on-failure
```

Build with debug symbols, place a breakpoint with `<leader>db`, and press `F5`
or `<leader>dr`. When prompted, select the executable produced by the build,
for example `build/my-program`.

## Go

### Tooling

The first launch installs `gopls`, `gofumpt`, and Delve. The Go Treesitter
parser is also installed.

- `gopls` supplies completion, automatic import suggestions, navigation,
  diagnostics, analyses, and Staticcheck integration.
- `gofumpt` formats Go files on save.
- Delve provides debugging through nvim-dap.

Start Neovim in the directory containing `go.mod`, then open a `.go` file and
check `:LspInfo` if necessary.

### Run, test, and debug

Use the standard Go toolchain for the normal development loop:

```sh
go mod download
go build ./...
go test ./...
go run .
```

To debug the current Go file, place a breakpoint with `<leader>db`, then press
`F5` or `<leader>dr`. The configured launch profile runs the current file with
Delve. For multi-package applications, starting Neovim in the main package
directory gives the most predictable result.

## Python

### Tooling

Python uses BasedPyright for type analysis and Ruff for diagnostics. These
servers are enabled by the configuration but are not in the automatic Mason
installation list, so install them once if they are absent:

```vim
:MasonInstall basedpyright ruff
```

Create and activate the project's virtual environment before starting Neovim
so the language servers can resolve the correct interpreter and dependencies:

```sh
python3 -m venv .venv
source .venv/bin/activate
python -m pip install -r requirements.txt
nvim .
```

BasedPyright runs in `basic` type-checking mode. Use `:LspInfo` to verify that
`basedpyright` and `ruff` are attached to a Python buffer.

This repository does not configure a Python formatter or debug adapter, so
saving a Python file does not reformat it and the DAP shortcuts do not start a
Python session.

### Run and test

Use the project's own commands; common examples are:

```sh
python -m my_package
python -m pytest
```

## C# and .NET

### Tooling

Install the .NET SDK and confirm it is available with `dotnet --info`. A project
root should contain a `.sln`, `.slnx`, or `.csproj` file.

The first launch installs:

- `roslyn-language-server` for Roslyn completion, navigation, diagnostics,
  code actions, automatic `using` imports, and inlay hints
- `csharpier` for deterministic formatting on save
- `netcoredbg` (the `coreclr` adapter in mason-nvim-dap) for .NET debugging
- The Treesitter `c_sharp` parser for syntax highlighting

Start Neovim from the solution or project root:

```sh
cd /path/to/solution
nvim .
```

After opening a `.cs` file, Roslyn locates and loads the solution or project.
Use `:LspInfo` to confirm that `roslyn_ls` is attached.

Completion appears while typing. Roslyn includes types from namespaces that
have not yet been imported; accepting one of those completion items with
`<CR>` also adds the corresponding `using`. Alternatively, put the cursor on
an unresolved symbol and use `gra` to select a Roslyn code action. Inlay hints
are enabled automatically when Roslyn attaches.

Saving a C# file runs CSharpier. Use `<leader>fm` (`Space f m`) to format the
current file or a visual selection manually.

### Build, run, and test

```sh
dotnet restore
dotnet build
dotnet test
dotnet run --project path/to/App.csproj
```

### Debug

Build a Debug assembly before starting a session:

```sh
dotnet build -c Debug
```

Place a breakpoint with `<leader>db`, then press `F5` or `<leader>dr`. The
debugger searches the current working directory for built DLLs and shows a
selection list when it finds more than one. Select the application's own DLL
under `bin/Debug/<target-framework>/`, not a dependency DLL. Keep the matching
`.pdb` file beside it.

The DAP UI opens when the session starts and closes when it exits.

## HTML and CSS

### Tooling

The configuration enables the HTML and CSS language servers. Their Mason
packages are not in the automatic installation list, so install them once if
needed:

```vim
:MasonInstall html-lsp css-lsp
```

Open Neovim at the web project's root and use `:LspInfo` in an `.html` or `.css`
buffer to verify that `html` or `cssls` is attached. These servers provide
completion, navigation, diagnostics, and code actions.

No HTML, CSS, JavaScript, or TypeScript formatter, JavaScript/TypeScript
language server, or browser debug adapter is configured here. Use the
project's own scripts for development and testing, for example:

```sh
npm install
npm run dev
npm test
```

The exact script names come from the project's `package.json`.

## Lua

### Tooling and workflow

The Lua Treesitter parser is installed automatically. `stylua` is configured as
the formatter but is not in the automatic Mason installation list, so install
it once if it is absent:

```vim
:MasonInstall stylua
```

Lua files are then formatted on save, or manually with `<leader>fm`.

This repository does not explicitly enable a Lua language server. For changes
to the Neovim configuration, format and validate them with:

```sh
stylua --check .
nvim --headless '+checkhealth' +qa
```

If the Neovim AppImage cannot use FUSE, prefix the second command with
`APPIMAGE_EXTRACT_AND_RUN=1`.

## Shared editor workflow

### LSP and completion

These mappings come from NvChad and Neovim 0.11 and apply whenever the attached
language server supports the requested operation.

| Key | Mode | Action |
| --- | --- | --- |
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `grn` | Normal | Rename symbol |
| `gra` | Normal/Visual | Show code actions |
| `grr` | Normal | Find references |
| `gri` | Normal | Go to implementation |
| `grt` | Normal | Go to type definition |
| `gO` | Normal | Show document symbols |
| `K` | Normal | Show hover documentation |
| `<C-s>` | Insert | Show signature help |
| `<leader>D` | Normal | Go to type definition (NvChad mapping) |
| `<leader>ra` | Normal | Open NvChad's rename UI |
| `<leader>wa` | Normal | Add a workspace folder |
| `<leader>wr` | Normal | Remove a workspace folder |
| `<leader>wl` | Normal | List workspace folders |
| `<leader>ds` | Normal | Send diagnostics to the location list |
| `<leader>fm` | Normal/Visual | Format the file or selection |

Completion menu keys:

| Key | Action |
| --- | --- |
| `<C-Space>` | Trigger completion manually |
| `<C-n>` / `<C-p>` | Select the next / previous item |
| `<CR>` | Accept the selected item |
| `<Tab>` / `<S-Tab>` | Select an item or move through snippet fields |
| `<C-d>` / `<C-f>` | Scroll completion documentation up / down |
| `<C-e>` | Close the completion menu |

Useful commands:

| Command | Action |
| --- | --- |
| `:LspInfo` | Show attached LSP clients and the log path |
| `:LspStart <server>` | Start a language server manually |
| `:LspRestart <server>` | Restart a language server |
| `:LspStop <server>` | Stop a language server |
| `:ConformInfo` | Show the active formatter, executable, and log |
| `:lua vim.lsp.inlay_hint.enable(true)` | Enable inlay hints in the current buffer |
| `:lua vim.lsp.inlay_hint.enable(false)` | Disable inlay hints in the current buffer |

### Debugging

The following mappings apply to the configured C, C++, Go, and C# adapters:

| Key | Mode | Action |
| --- | --- | --- |
| `F5` | Normal | Start or continue |
| `F10` | Normal | Step over |
| `F11` | Normal | Step into |
| `F12` | Normal | Step out |
| `<leader>dr` | Normal | Start or continue |
| `<leader>dc` | Normal | Continue |
| `<leader>dq` | Normal | Terminate |
| `<leader>db` | Normal | Toggle a breakpoint |
| `<leader>dB` | Normal | Set a conditional breakpoint |

Useful DAP commands include `:DapContinue`, `:DapToggleBreakpoint`,
`:DapTerminate`, `:DapRestartFrame`, `:DapSetLogLevel`, and `:DapShowLog`.

### General NvChad mappings

Press `<leader>ch` for the full NvChad cheatsheet or `<leader>wK` for all
WhichKey groups.

| Key | Action |
| --- | --- |
| `;` | Enter command-line mode, like `:` |
| `jk` | Leave Insert mode |
| `<C-s>` | Save in Normal mode |
| `<C-h/j/k/l>` | Move between windows |
| `<Tab>` / `<S-Tab>` | Select the next / previous buffer |
| `<leader>x` | Close the current buffer |
| `<C-n>` | Toggle the file tree |
| `<leader>e` | Focus the file tree |
| `<leader>ff` | Find files |
| `<leader>fa` | Find all files, including hidden and ignored files |
| `<leader>fw` | Search text across the project |
| `<leader>fb` | Find a buffer |
| `<leader>fh` | Search help |
| `<leader>/` | Toggle comments for the line or selection |
| `<leader>h` / `<leader>v` | Open a horizontal / vertical terminal |
| `<A-h>` / `<A-v>` / `<A-i>` | Toggle horizontal / vertical / floating terminals |
| `<leader>th` | Select a theme |
| `<leader>ch` | Open the NvChad cheatsheet |

## Troubleshooting

- If an LSP does not attach, start Neovim at the project root, run `:LspInfo`,
  and confirm its package is installed in `:Mason`.
- If formatting does not run on save, use `:ConformInfo` and confirm that the
  configured formatter is available.
- If C# completion does not add a `using`, trigger completion with `<C-Space>`
  or use `gra` on the unresolved symbol.
- If a debugger does not start, make sure the project was built with debug
  symbols and inspect `:DapShowLog`.
- If a breakpoint is unverified, rebuild the exact executable or DLL selected
  by the debugger and keep its debug-symbol file (`.pdb` for .NET) available.
- Use `:LspLog` for detailed language-server failures.

## Configuration map

- `lua/configs/lspconfig.lua`: Roslyn, clangd, gopls, BasedPyright, Ruff, HTML,
  and CSS language-server settings
- `lua/configs/conform.lua`: formatters and format-on-save behavior
- `lua/configs/dap.lua`: DAP mappings and C/C++ and Go launch profiles
- `lua/plugins/init.lua`: plugins, Mason tools, Treesitter parsers, and .NET DAP
- `lua/autocmds.lua`: automatic C# inlay hints
- `lua/mappings.lua`: custom key mappings
