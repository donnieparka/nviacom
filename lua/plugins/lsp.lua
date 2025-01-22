return {
  { -- setup blink
    'saghen/blink.cmp',
    version = '*',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    opts = {
      keymap = {
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'hide' },
        ['<C-a>'] = { 'select_and_accept' },
        ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        ['C-l'] = { 'snippet_forward', 'fallback' },
        ['C-h'] = { 'snippet_backward', 'fallback' },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },
      snippets = {
        expand = function(snippet) require('luasnip').lsp_expand(snippet) end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction) require('luasnip').jump(direction) end,
      },
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      signature = { enabled = true }
    },
  },

  { -- setup LSPconfig
    "neovim/nvim-lspconfig",
    dependencies = {
      { 'j-hui/fidget.nvim', opts = {} },
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
          "/usr/bin/elixir-ls"
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
