return {
  --- Treesitter Core
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      auto_install = true,
      ensure_installed = { 'c', 'lua', 'vim', 'vimdoc', 'query' },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = true
      },
      indent = { enable = true },
      incremental_selection = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').compilers = { 'gcc', 'clang' }
      require('nvim-treesitter.configs').setup(opts)
    end
  },
  {
    'windwp/nvim-ts-autotag',
    config = true,
    dependencies = { 'nvim-treesitter/nvim-treesitter' }
  }
}
