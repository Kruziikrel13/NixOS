vim.uv = vim.uv or vim.loop
vim.loader.enable()

vim.g.mapleader = require('configuration').mapleader
vim.g.maplocalleader = require('configuration').maplocalleader

require('init').plugin_setup()

vim.lsp.enable('lua_ls')
vim.lsp.enable('nixd')
