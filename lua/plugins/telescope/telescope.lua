return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons',              enabled = vim.g.have_nerd_font },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          fzf = {}
        }
      }
      require('telescope').load_extension('fzf')
      require('telescope').load_extension('ui-select')
      require('plugins.telescope.config.multigrep')
      local mapTelescope = require("mappings.mapTelescope")
      mapTelescope()
    end
  }
}
