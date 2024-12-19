return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      'saghen/blink.cmp',
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require('blink.cmp').get_lsp_capabilities()
      lspconfig.lua_ls.setup { capabilities = capabilities }
      lspconfig.clangd.setup({})
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end
          ---@diagnostic disable-next-line
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          end
        end,
      })
    end,
  },
}
--        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
--        callback = function(args)
--
--          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
--          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
--          map('<space>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
--          map('<space>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--          map('<space>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--          map('<space>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--          map('<space>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })
