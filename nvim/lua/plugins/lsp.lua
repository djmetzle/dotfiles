return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    },
    config = function()
      require("nvim-treesitter").setup()

      require("nvim-treesitter").install({
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
        "ruby",
        "php",
        "astro",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
        callback = function(args)
          local buf = args.buf
          local ft = vim.bo[buf].filetype
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then
            return
          end
          if not pcall(vim.treesitter.start, buf, lang) then
            return
          end
          if ft == "ruby" then
            vim.bo[buf].syntax = "on"
          else
            vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      local ts_select = require("nvim-treesitter-textobjects.select")
      local ts_move = require("nvim-treesitter-textobjects.move")
      local ts_swap = require("nvim-treesitter-textobjects.swap")

      vim.keymap.set({ "x", "o" }, "af", function()
        ts_select.select_textobject("@function.outer", "textobjects")
      end, { desc = "Select outer function" })
      vim.keymap.set({ "x", "o" }, "if", function()
        ts_select.select_textobject("@function.inner", "textobjects")
      end, { desc = "Select inner function" })
      vim.keymap.set({ "x", "o" }, "ac", function()
        ts_select.select_textobject("@class.outer", "textobjects")
      end, { desc = "Select outer class" })
      vim.keymap.set({ "x", "o" }, "ic", function()
        ts_select.select_textobject("@class.inner", "textobjects")
      end, { desc = "Select inner class" })

      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        ts_move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        ts_move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Prev function start" })

      vim.keymap.set("n", "<leader>sn", function()
        ts_swap.swap_next("@parameter.inner")
      end, { desc = "Swap next parameter" })
      vim.keymap.set("n", "<leader>sp", function()
        ts_swap.swap_previous("@parameter.inner")
      end, { desc = "Swap previous parameter" })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "hrsh7th/cmp-nvim-lsp", opts = {} },
      { "j-hui/fidget.nvim", opts = {} },
      {
        "ray-x/lsp_signature.nvim",
        opts = {},
        config = function(_, opts)
          require("lsp_signature").setup(opts)
        end,
      },
    },
    config = function()
      require("mason").setup({})

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("auto-lsp-attach", { clear = true }),
        callback = function(event)
          -- Autocompletion (Neovim 0.11 only)
          --local client = vim.lsp.get_client_by_id(event.data.client_id)
          --if client:supports_method("textDocument/completion") then
          --	vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
          --end

          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

          map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

          map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

          map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

          map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

          map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

          map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

          map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

          map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

          map("<leader>lk", vim.diagnostic.open_float, "Open Diags (floating)")
        end,
      })

      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = {
          source = "if_many",
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

      require("mason-lspconfig").setup({
        automatic_installation = false,
        ensure_installed = { "biome", "bashls", "lua_ls", "rust_analyzer" },
        handlers = {
          function(server_name)
            vim.lsp.enable(server_name)
          end,
        },
      })
    end,
  },
}
