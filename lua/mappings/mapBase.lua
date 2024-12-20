return function()
  local map = require("helpers.map")
  map('<space><space>x', '<cmd>source %<CR>', 'source current file') -- source current file
  map('<space>x', ':.lua<CR>', '')                                   -- execute this line as lua code
  map('<space>x', ':lua<CR>', 'execute selected as lua', {}, 'v')    -- execute visually selected lines as lua code
  map('<Esc>', '<cmd>nohlsearch<CR>')                                -- clear search highlighting
  map('<M-j>', '<cmd>cnext<CR>', 'next quickfix')                    -- jump to next match in quickfix
  map('<M-k>', '<cmd>cprev<CR>', 'previous quickfix')                -- jump to previous match in quickfix
  map("<esc><esc>", "<c-\\><c-n>", nil, nil, "t")                    -- exit terminal
  map('<space>mt',                                                   -- toggle mini term
    function()
      vim.cmd.vsplit()
      vim.cmd.term()
      vim.cmd.wincmd('J')
      vim.api.nvim_win_set_height(0, 5)
    end,
    '[T]erminal'
  )
  map('<C-Left>', '<C-w><C-h>', 'Move focus to the left window') -- Keybinds to make split navigation easier.
  map('<C-Right>', '<C-w><C-l>', 'Move focus to the right window')
  map('<C-Down>', '<C-w><C-j>', 'Move focus to the lower window')
  map('<C-Up>', '<C-w><C-k>', 'Move focus to the upper window')
end
