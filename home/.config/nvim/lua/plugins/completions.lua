return {
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      }
    }
  },
  {
    'saghen/blink.cmp',
    version = "1.*",
    opts = {
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      keymap = {
        ['<A-CR>'] = { 'select_and_accept' },
        [ '<A-k>' ] = { 'select_prev' },
        [ '<A-j>' ] = { 'select_next' },
      },
      sources = {
        default = { 'copilot', 'lazydev', 'lsp', 'path', 'snippets' },
        providers = {
          lazydev = {
            name = 'LazyDev',
            module = 'lazydev.integrations.blink',
            score_offset = 100
          },
        }
      }
    }
  }
}
