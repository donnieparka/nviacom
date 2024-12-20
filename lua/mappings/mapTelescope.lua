return function()
  local builtin = require 'telescope.builtin'
  local live_multigrep = require 'plugins.telescope.config.multigrep'
  local map = require('helpers.map')
  map('<space>hh', builtin.help_tags, '[H]elp! [H]eeeelp!') -- find help
  map('<space>sk', builtin.keymaps, '[K]eymaps')            -- find keymaps
  map('<space>sd', builtin.diagnostics, '[D]iagnostics')    -- find diagnostics
  map('<space>sh', builtin.find_files, '[H]ere')            -- find files
  map('<space>sg', live_multigrep, '[G]rep')                -- find string in current folder
  map('<space>sb', builtin.buffers, '[B]uffers')            -- find buffers
  map('<space>sw', builtin.grep_string, 'current [W]ord')   -- search word
  map('<space>ss', builtin.builtin, '[S]earch Telescope')   -- search Telescope builtin docs
  map('<space>sr', builtin.resume, '[R]esume')              -- resume last search
  map('<space>s.', builtin.oldfiles, 'recent files')        -- find recent files
  map('<space>/',                                           -- Fuzzily search in current buffer
    function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end,
    '[/] Fuzzily search in current buffer'
  )
  map('<space>sn', -- find files in config folder
    function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end,
    '[N]eovim'
  )
  map('<space>s/', -- find string in open files
    function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,
    '[S]earch [/] in Open Files'
  )

  -- LSP dependant
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition', event)                        -- Jump to the definition of the word under your cursor. To jump back, press <C-t>.
      map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences', event)                         -- Find references for the word under your cursor.
      map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation', event)                -- Useful when your language has ways of declaring types without an actual implementation.
      map('<space>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition', event)               -- Useful when you're not sure what type a variable is and you want to see
      map('<space>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols', event)           -- Fuzzy find all the symbols in your current document.
      map('<space>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols', event) -- Fuzzy find all the symbols in your current workspace.
    end,
  })
end
