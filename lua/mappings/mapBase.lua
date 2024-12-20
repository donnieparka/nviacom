return function()
  local map = require("helpers.map")
  map('<space><space>x', '<cmd>source %<CR>', 'source current file') -- source current file
  map('<space>x', ':.lua<CR>', '')                                   -- execute this line as lua code
  map('<space>x', ':lua<CR>', 'execute selected as lua')             -- execute visually selected lines as lua code
  map('<Esc>', '<cmd>nohlsearch<CR>')                                -- clear search highlighting
  map('<M-j>', '<cmd>cnext<CR>', 'next quickfix')                    -- jump to next match in quickfix
  map('<M-k>', '<cmd>cprev<CR>', 'previous quickfix')                -- jump to previous match in quickfix
  vim.keymap.set('n', '<space>mt', function()                        -- toggle mini term
      vim.cmd.vsplit()
      vim.cmd.term()
      vim.cmd.wincmd('J')
      vim.api.nvim_win_set_height(0, 5)
    end,
    { desc = '[T]erminal' }
  )
end
