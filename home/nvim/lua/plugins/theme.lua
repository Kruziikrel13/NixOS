local configuration = require('configuration')

return {
  'zaldih/themery.nvim',
  lazy = false,
  opts = {
    themes = {
      {
        name = "GitHub Dark",
        colorscheme = "github_dark_default",
        after = [[
            vim.opt.background = "dark"
          ]]
      },
      {
        name = "GitHub Light",
        colorscheme = "github_light_default",
        after = [[
            vim.opt.background = "light"
          ]]
      }
    }
  },
  keys = {
    { '<leader>xt', '<CMD>Themery<CR>', desc = "Set Theme" }
  },
  dependencies = {
    {
      'projekt0n/github-nvim-theme',
      opts = {
        options = {
          dim_inactive = true,
          transparent = configuration.theme.transparency
        }
      },
      config = function(_, opts)
        local github = require('github-theme')
        github.setup(opts)
        github.compile(false)
      end
    }
  }
}
