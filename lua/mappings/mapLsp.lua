return function()
  local map = require('helpers.map')
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')                  -- Jump to the declaration of the word under your cursor. (in C this would take you to the header)
  map('<space>rn', vim.lsp.buf.rename, '[R]e[n]ame')                          -- Rename the variable under your cursor.
  map('<space>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })  -- Execute a code action, usually your cursor needs to be on top of an error
  map('<space>q', vim.diagnostic.setloclist, 'open diagnostic in [Q]uickfix') -- show quickfix with diagnostics
end
