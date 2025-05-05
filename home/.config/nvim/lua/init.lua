--[[
  File: init.lua
  Description: initializes neovim config and bootstraps lazy plugin manager
]]
local M = {}

local function clean_plugins()
  vim.g.editorconfig = false
  vim.g.loaded_man = false
  vim.g.loaded_matchit = 1
  vim.g.loaded_matchparen = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_remote_plugins = 1
  vim.g.loaded_shada_plugin = 1
  vim.g.loaded_spellfile_plugin = 1
  vim.g.loaded_gzip = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_tutor_mode_plugin = 1

  vim.g.loaded_python3_provider = 0
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_perl_provider = 0
  vim.g.loaded_node_provider = 0
end

function M.plugin_setup()
  ---@see https://lazy.folke.io/installation
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath })

    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { 'Failed to clone lazy.nvim:\n', 'ErrorMsg'},
        { out, 'WarningMsg' },
        { '\nPress any key to exit...' }
      }, true, {})
      vim.fn.getchar()
      os.exit(1)
    end
  end
  vim.opt.rtp:prepend(lazypath)

  clean_plugins()

  require('lazy').setup('plugins', {
    defaults = {
      lazy = false,
      version = false,
      submodules = false
    },
    checker = {
      enabled = true,
      notify = false
    },
    performance = {
      rtp = {
        disabled_plugins = {
          'gzip',
          'matchit',
          'matchparen',
          'netrwPlugin',
          'tarPlugin',
          'tohtml',
          'tutor',
          'zipPlugin',
        }
      }
    }
  })

  require('config.options')
  require('config.autocmds')
  require('config.keymappings')
end

return M
