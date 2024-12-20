print 'Hello, world!'

require 'lazy.config'
local mapBase = require 'mappings.mapBase'
mapBase()

vim.opt.shiftwidth = 2
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus' -- same clipboard as OS
end)

vim.opt.undofile = true       -- Save undo history
vim.opt.number = true
vim.opt.relativenumber = true --numbers and relativenumbers
vim.opt.ignorecase = true
vim.opt.smartcase = true      -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.showmode = false      -- Don't show the mode, since it's already in the status line
vim.opt.inccommand = 'split'
vim.opt.cursorline = true     -- Show which line your cursor is on
vim.opt.scrolloff = 10        -- Minimal number of screen lines to keep above and below the cursor.

vim.g.have_nerd_font = true   --nerd font

vim.opt.breakindent = true    -- Enable break indent
vim.opt.signcolumn = 'yes'    -- Keep signcolumn on by default
vim.opt.splitright = true     --split rules
vim.opt.splitbelow = true

-- Highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
