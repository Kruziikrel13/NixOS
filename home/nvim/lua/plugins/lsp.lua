return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  },
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {},
    dependencies = { 'neovim/nvim-lspconfig' }
  },
  {
    'Bekaboo/dropbar.nvim',
    event = 'LspAttach',
    opts = {},
    dependencies = { 'nvim-telescope/telescope-fzf-native.nvim', optional = true }
  },
  {
    "Dan7h3x/signup.nvim",
    branch = "main",
    opts = {}
  },
  {
    'Wansmer/symbol-usage.nvim',
    event = 'LspAttach',
    opts = {}
  },
  -- {
  --   "rachartier/tiny-code-action.nvim",
  --   event = 'LspAttach',
  --   opts = {
  --     backend = "vim"
  --   },
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-telescope/telescope.nvim',
  --   },
  --   keys = {
  --     { '<Tab>a', function()
  --       ---@diagnostic disable-next-line: missing-parameter
  --       require('tiny-code-action').code_action()
  --     end, desc = "Code Action" }
  --   }
  -- },
  {
    "Fildo7525/pretty_hover",
    event = "LspAttach",
    opts = {},
    keys = {
      { '<Tab><Tab>', function()
        require('pretty_hover').hover()
      end, desc = "Hover Doc"}
    }
  },
  {
    'hedyhli/outline.nvim',
    opts = {},
    keys = {
      { '<leader>lo', function()
        require('outline').toggle()
      end, desc = 'Document Outline'}
    }
  },
  {
    'nvimdev/lspsaga.nvim',
    opts = {
      breadcrumbs = {
        enable = false
      },
      finder = {
        keys = {
          vsplit = "<C-v>",
          split = "<C-x>",
          toggle_or_open = "<CR>"
        }
      },
      rename = {
        keys = {
          quit = '<Esc>',
          select = 'e'
        }
      },
      lightbulb = {
        sign = false
      }
    },
    keys = {
      { '<Tab><Tab>', '<cmd>Lspsaga hover_doc<cr>',
        desc = 'Hover Doc' },
      { '<Tab>r', '<cmd>Lspsaga rename ++project<cr>',
        desc = 'Rename' },
      { '<Tab>d', '<cmd>Lspsaga peek_definition<cr>',
        desc = 'Peek' },
      { '<Tab>f', '<cmd>Lspsaga finder<cr>',
        desc = 'Find' }
    }
  },
}
