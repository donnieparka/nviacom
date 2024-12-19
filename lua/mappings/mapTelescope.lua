return {
  mapTelescope = function()
    local builtin = require 'telescope.builtin'
    local live_multigrep = require 'plugins.telescope.config.multigrep'
    vim.keymap.set('n', '<space>hh', builtin.help_tags, { desc = '[H]elp! [H]eeeelp!' }) -- find help
    vim.keymap.set('n', '<space>sf', builtin.find_files, { desc = '[F]iles' })           -- find files
    vim.keymap.set('n', '<space>sg', live_multigrep, { desc = '[G]rep' })                -- find string in current folder
    vim.keymap.set('n', '<space>sb', builtin.buffers, { desc = '[B]uffers' })            -- find buffers
    vim.keymap.set('n', '<space>   sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<space>sn',                                                     -- find files in config folder
      function()
        builtin.find_files({ cwd = vim.fn.stdpath('config') })
      end,
      { desc = '[N]eovim' })

    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode) -- helper function to create mappings specific for LSP related items
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')                        -- Jump to the definition of the word under your cursor. To jump back, press <C-t>.
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')                                            -- Jump to the declaration of the word under your cursor. (in C this would take you to the header)
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')                         -- Find references for the word under your cursor.
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')                -- Useful when your language has ways of declaring types without an actual implementation.
        map('<space>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')               -- Useful when you're not sure what type a variable is and you want to see
        map('<space>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')           -- Fuzzy find all the symbols in your current document.
        map('<space>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols') -- Fuzzy find all the symbols in your current workspace.
        map('<space>rn', vim.lsp.buf.rename, '[R]e[n]ame')                                                    -- Rename the variable under your cursor.
        map('<space>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })                            -- Execute a code action, usually your cursor needs to be on top of an error
      end,
    })
  end,
}
