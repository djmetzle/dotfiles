require("editor")
require("term")

require("lazyinstall")

 ---@diagnostic disable-next-line: missing-fields
require("lazy").setup({
  import = "plugins",
  checker = { enabled = true },
})

vim.api.nvim_set_keymap("n", "<Leader><Space>", [[:%s/\s\+$//e<CR>:nohl<CR>]], {noremap = true})

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end
vim.keymap.set('n', '<leader>qf', quickfix, {noremap = true, silent = true})
