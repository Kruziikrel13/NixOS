return {
  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    opts = {
      spec = {
        { '<leader>x', group = 'Utilities' },
        { '<leader>f', group = 'Find' },
        { '<leader>g', group = 'Git' },
        { '<leader>l', group = 'Language Server' },
        { '<Tab>', group = 'Hover Utilities' },
        { '<leader>xl', '<cmd>Lazy<cr>', desc = 'Lazy' },
        { 'M', '<cmd>delm!<cr>', desc = 'Clear Marks' }
      }
    },
    keys = {
      { '<leader>?', function ()
        require('which-key').show({global = false})
      end, desc = 'Buffer Local Keymaps' },
      { '?', function ()
        require('which-key').show()
      end, desc = 'Keymaps' }
    }
  }
}
