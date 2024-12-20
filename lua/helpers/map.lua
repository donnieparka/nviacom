return function(keys, func, desc, event, mode) -- helper function to create mappings specific for LSP related items
  mode = mode or 'n'
  if not event then
    vim.keymap.set(mode, keys, func, { desc = desc })
  else
    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
  end
end
