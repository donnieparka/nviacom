return function() -- Oil.nvim
  local map = require("helpers.map")
  map('-', '<cmd>Oil<CR>', 'Oil')
end
