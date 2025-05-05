local SentinelLib = require('util.misc')
local lazygit
return {
  --- @see https://github.com/akinsho/toggleterm.nvim
  'akinsho/toggleterm.nvim',
  event = { 'BufReadPost', 'BufNewFile' },
  opts = {
    open_mapping = [[<C-\><C-\>]],
    start_in_insert = true,
    direction = 'float'
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)
    lazygit = require('toggleterm.terminal').Terminal:new({
      count = 12,
      hidden = true,
      direction = 'float',
      cmd = 'lazygit',
      name = 'LazyGit'
    })
  end,
  keys = {
    { '<leader>gg', function()
      if SentinelLib.is_not_empty(lazygit) then
        lazygit:toggle()
      end
    end, desc = "Lazygit" }
  }
}
