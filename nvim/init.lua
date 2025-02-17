require("editor")

require("lazyinstall")

require("lazy").setup({
  checker = { enabled = true },
  {import = "plugins"},
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'ruby', 'php', 'astro' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
      },
      indent = { enable = true, disable = { 'ruby' } },
    },
  },
  'tpope/vim-fugitive',
})


vim.api.nvim_set_keymap("n", "<Leader><Space>", [[:%s/\s\+$//e<CR>:nohl<CR>]], {noremap = true})

vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
