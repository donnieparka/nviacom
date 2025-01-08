return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'j-hui/fidget.nvim',                opts = {} },
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
      local capabilities = require('blink.cmp').get_lsp_capabilities() -- enable blink and get capabilities

      lspconfig.lua_ls.setup { capabilities = capabilities }
      lspconfig.clangd.setup { capabilities = capabilities }
      lspconfig.elixirls.setup {
        cmd = {
          "/home/iaco/.local/share/nvim/mason/packages/elixir-ls/language_server.sh"
        },
        capabilities = capabilities
      }
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id) -- get client
          if not client then
            return
          end
          local mapLsp = require('mappings.mapLsp')
          mapLsp()

          if client.supports_method("textDocument/formatting") then -- format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
              end,
            })
          elseif vim.bo.filetype == 'elixir' then
            vim.api.nvim_create_autocmd("BufWritePre", {
              callback = function()
                vim.cmd([[lcd %:p:h]])
                vim.cmd([[silent !mix format %]])
              end,
            })
          end
          if client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false }) -- create highlight augroup

            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' },                                        -- highlight on cursor hold
              {
                buffer = args.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.document_highlight,
              })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' },
              { -- clear highlight on move
                buffer = args.buf,
                group = highlight_augroup,
                callback = vim.lsp.buf.clear_references,
              })

            vim.api.nvim_create_autocmd('LspDetach', -- clear highlight on detach
              {
                group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
                callback = function(args2)
                  vim.lsp.buf.clear_references()
                  vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = args2.buf }
                end,
              })
          end
        end,
      })
    end,
  },
}
