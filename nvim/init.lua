require("editor")
require("term")

require("lazyinstall")

 ---@diagnostic disable-next-line: missing-fields
require("lazy").setup({
  checker = { enabled = true },
  {import = "plugins"},
  {
    'hrsh7th/nvim-cmp',
    opts = {},
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'ray-x/cmp-treesitter',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-cmdline',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        completion = { completeopt = 'menu,menuone,noinsert' },
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'calc' },
          { name = 'path' },
          { name = 'treesitter' },
        }),
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
        end
      })
    end,
  },
})

vim.api.nvim_set_keymap("n", "<Leader><Space>", [[:%s/\s\+$//e<CR>:nohl<CR>]], {noremap = true})

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end
vim.keymap.set('n', '<leader>qf', quickfix, {noremap = true, silent = true})
