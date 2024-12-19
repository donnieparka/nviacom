return {
  {
    "williamboman/mason-lspconfig.nvim",
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup{
        ensure_installed = {'lua_ls', 'clangd'}
      }
    end
  }
}
