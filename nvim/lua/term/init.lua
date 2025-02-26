vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end
})

vim.keymap.set('n', '<leader>t', function()
  vim.cmd.new()
  vim.cmd.term()
end)
