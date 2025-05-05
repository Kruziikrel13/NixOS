local function bindOnAttach(bufnr)
  local api = require('nvim-tree.api')
  api.config.mappings.default_on_attach(bufnr)

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  vim.keymap.set('n', '>', api.tree.change_root_to_node, opts('change root to node'))
  vim.keymap.set('n', '<', api.tree.change_root_to_parent, opts('change root to parent'))
  vim.keymap.set('n', '<BS>', api.tree.toggle_hidden_filter, opts('toggle hidden'))
  vim.keymap.set('n', 'g<BS>', api.tree.toggle_gitignore_filter, opts('toggle gitignore'))
  vim.keymap.set('n', 'c', api.node.navigate.parent_close, opts('close parent'))
  vim.keymap.set('n', 'C', api.tree.collapse_all, opts('close parent'))
end

return {
  {
    'nvim-tree/nvim-tree.lua',
    opts = {
      on_attach = bindOnAttach,
      hijack_cursor = true,
      disable_netrw = true,
      prefer_startup_root = true,
      sync_root_with_cwd = true,
      modified = {
        enable = true,
      },
      renderer = {
        group_empty = true,
      },
      diagnostics = {
        enable = true
      },
      filters = {
        dotfiles = true
      }
    },
    lazy = false,
    keys = {
      { 't', '<CMD>NvimTreeToggle<cr>', desc = 'Explorer' }
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'antosha417/nvim-lsp-file-operations',
    config = true,
    dependencies = { 'nvim-tree/nvim-tree.lua', 'nvim-lua/plenary.nvim' }
  }
}
