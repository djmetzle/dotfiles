local open_todo = function()
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_open_win(buf, true, {
    style = "minimal",
    relative = "editor",
    border = "rounded",
    height = math.ceil(vim.o.lines * 0.8),
    width = math.ceil(vim.o.columns * 0.6),
    row = 2, --> Top of the window
    col = math.ceil(vim.o.columns * 0.2),
  })

  vim.cmd.edit("~/.TODO.md")

  vim.keymap.set("n", "q", vim.cmd.close, { buffer = buf })
end

vim.keymap.set("n", "<leader>T", open_todo, {})
