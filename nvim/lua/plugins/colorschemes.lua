return {
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    init = function()
      vim.cmd.colorscheme("tokyonight-night")
    end,
  },
  { "catppuccin/nvim", name = "catppuccin" },
  { "rose-pine/neovim", name = "rose-pine" },
  { "nyoom-engineering/oxocarbon.nvim", name = "oxocarbon" },
  { "joshdick/onedark.vim", name = "onedark" },
  { "cschlueter/vim-wombat", name = "wombat" },
}
