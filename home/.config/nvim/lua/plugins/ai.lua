vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuOpen",
  callback = function()
    vim.b.copilot_suggestion_hidden = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = "BlinkCmpMenuClose",
  callback = function()
    vim.b.copilot_suggestion_hidden = false
  end,
})

return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      server = {
        type = "binary",
        custom_server_filepath = "copilot-language-server"
      },
      suggestion = { enabled = false },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true
      }
    },
    dependencies = {
      'saghen/blink.cmp',
      optional = true,
      dependencies = { "fang2hou/blink-copilot" },
      opts = {
        sources = {
          providers = {
            copilot = {
              name = "copilot",
              module = "blink-copilot",
              score_offset = 10,
              async = true,
            },
          },
        },
      }
    }
  },
}
