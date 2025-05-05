--[[
  File: configuration.lua
  Description: Global Configuration for Neovim Configuration
]]
local conf = {}

conf.namespace = 'sentinel'

conf.root_patterns = { '.git', 'index.html', 'compile_commands.json' } -- patterns to search for root dir using

-- Leader Keys
conf.mapleader = ' '
conf.maplocalleader = ' '
conf.init_file_loading = false -- load .nvim.lua init files (note: we already auto load .lazy.lua files)

-- Diagnostics Configuration
conf.diagnostics = {}
conf.diagnostics.actions = 'tiny-action' ---@type "clear-action" | "tiny-action"

vim.diagnostic.config { virtual_lines = true }

-- Theme Configuration
conf.theme = {}
conf.theme.preset = "github" ---@type "flow" | "github" | "serene"
conf.theme.transparency = false -- enables transparency if theme supports it
conf.theme.mode = 'light'

conf.experimental = {}
conf.experimental.blink = true -- use blink for completions instead of cmp
conf.experimental.trouble = false -- use trouble for quickfixes

conf.lsp = {}
conf.lsp.hover = 'lspsaga.nvim' ---@type "hover.nvim" | 'lspsaga.nvim'

return conf
