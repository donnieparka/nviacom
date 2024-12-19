return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
      require('telescope').setup {
        extensions = {
          fzf = {}
        }
      }
      require('telescope').load_extension('fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      require('plugins.telescope.config.multigrep')
      require("mappings.mapTelescope").mapTelescope()
    end
  }
}