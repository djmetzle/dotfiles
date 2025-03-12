return {
  "folke/zen-mode.nvim",
  opts = {
    plugins = {
      tmux = { enabled = true },
      gitsigns = { enabled = true },
    },
  },
  config = function()
    vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", { desc = "Zen" })
  end,
}
