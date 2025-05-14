local ok, cmp = pcall(require, "cmp")
if ok then
  cmp.setup.buffer({
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
    }),
  })
end
