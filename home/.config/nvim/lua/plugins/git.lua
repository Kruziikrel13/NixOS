return {
  'lewis6991/gitsigns.nvim',
  opts = {
    current_line_blame = true
  },
  event = { 'BufEnter' },
  keys = {
    { '<leader>gs', '<cmd>Gitsigns<cr>', desc = 'Git Signs' }
  },
  config = true,
  dependencies = {
    {'nvimdev/lspsaga.nvim', optional = true, opts = {
      code_action = {
        extend_gitsigns = true
      }
    }}
  }
}
