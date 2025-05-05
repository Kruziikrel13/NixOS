return {
  {
    'folke/trouble.nvim',
    opts = {},
    cmd = 'Trouble',
    keys = {
      { '<leader>ld', function ()
        require('trouble').open({
          mode = 'diagnostics',
          focus = true
        })
      end, desc = 'Workspace Diagnostics' },
      { '<leader>lQ', function()
        require('trouble').open({
          mode = 'quickfix',
          focus = true
        })
      end, desc = "Workspace Quickfix List"}
    }
  },
}
