# AGENTS.md

## Cursor Cloud specific instructions

This repo is a personal **dotfiles / dev-environment** bundle, not a deployable app. There is no
`package.json`, `Makefile`, CI pipeline, or automated test suite. Setup is driven by the
[`Justfile`](Justfile) (task runner: `just`). The meaningful thing to validate is the **Neovim
configuration** under [`nvim/`](nvim/).

### Services / modules

| Module | Location | How to run / validate | In cloud scope? |
|--------|----------|------------------------|-----------------|
| Neovim config | `nvim/` | `nvim` (config is symlinked to `~/.config/nvim`); plugins managed by lazy.nvim | Yes (primary) |
| Shell aliases | `aliases/` | sourced from `~/.bashrc` via `just aliases` | Yes |
| ripgrep config | `ripgrep/` | symlinked to `~/.config/ripgrep` via `just ripgrep` | Yes |
| llama-swap / llama.cpp / opencode | `llm/`, `services/` | local LLM stack (`just llm`) | No — see below |

### Neovim (primary product)

- Config is symlinked with `just nvim` (`~/.config/nvim -> /workspace/nvim`). lazy.nvim
  auto-installs plugins on first launch; to do it non-interactively use
  `nvim --headless "+Lazy! sync" +qa`.
- Treesitter is on the `main` branch, so parser installs are **async**. In headless mode you must
  wait for them (e.g. `require('nvim-treesitter').install({...}):await(...)` + `vim.wait`), otherwise
  nvim exits before the parser compiles. Parsers land in `~/.local/share/nvim/site/parser/`.
- `rest.nvim` has a `luarocks` build that is fragile. It needs, in this order: Lua 5.1 dev headers,
  a system-wide luarocks config exposing `LUA_INCDIR` (`~/.config/luarocks/config-5.1.lua`), the
  `luarocks-build-treesitter-parser` backend installed into the **system** tree (`sudo luarocks
  install ...`, not a `--tree` local tree, or luarocks can't `require` the backend), and the
  `tree-sitter` CLI on `PATH`. These are installed during environment setup; if a `rest.nvim` build
  ever fails, this chain is the thing to check.

### Justfile gotchas

- `just` (the default recipe) checks for a binary literally named `tailspin`, but the tool installs
  its binary as `tspin`. A `tailspin -> tspin` symlink in `/usr/local/bin` satisfies the check.
- Do **not** run `just git`: it copies `git/.gitconfig` over `~/.gitconfig` and would clobber the
  commit identity configured for this VM.
- `just aliases` appends a `source .../aliases/bash.sh` line to `~/.bashrc` every time it runs —
  guard against double-appending before re-running.

### Out of scope in the cloud VM (LLM stack)

`just llm`, `just pull-models`, `just llama-swap`, and `opencode` require llama.cpp
(`llama-server`/`llama-cli`), multi-GB GGUF model downloads, a GPU for practical inference, and (for
some MCP servers) `MINIMAX_API_KEY`. These are not runnable in the headless cloud VM and are
intentionally not set up. The config files can still be symlinked (`just opencode`) for editing.
