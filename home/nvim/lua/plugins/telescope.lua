return {
  'nvim-telescope/telescope.nvim',
  opts = {},
  dependencies = {
    'nvim-lua/plenary.nvim',
    'BurntSushi/ripgrep',
    'sharkdp/fd',
    'nvim-tree/nvim-web-devicons'
  },
  keys = {
    { '<leader>fg', function ()
      require('telescope.builtin').live_grep()
    end, desc = 'Live Grep' },
    { '<leader>ff', function ()
      require('telescope.builtin').find_files()
    end, desc = 'Find Files' },
    {'<leader>fa', function ()
      require('telescope.builtin').marks()
    end, desc = 'Lsp References' }
  }
}
