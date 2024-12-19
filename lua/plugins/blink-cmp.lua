return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      'L3MON4D3/LuaSnip',
    },
    version = 'v0.*',
    opts = {
      keymap = {
        preset = 'default',
        --   ['<C-p>'] = { 'select_prev', 'fallback' },
        --   ['<C-n>'] = { 'select_next', 'fallback' },
        --   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
        --   ['<C-e>'] = { 'hide' },
        --   ['<C-a>'] = { 'select_and_accept' },
        --   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
        --   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
        --   ['C-l'] = { 'snippet_forward', 'fallback' },
        --   ['C-h'] = { 'snippet_backward', 'fallback' },
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
        default = { 'lsp', 'path', 'luasnip', 'buffer' },
      },
      signature = { enabled = true }
    },
  },
}
