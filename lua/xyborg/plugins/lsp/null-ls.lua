local setup, null_ls = pcall(require, "null-ls")
if not setup then
 return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics -- Corrected typo

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
 sources = {
    formatting.prettier,
    formatting.stylua,
    diagnostics.eslint_d -- Corrected typo
 },

 -- configure format on save
 on_attach = function (current_client, bufnr) -- Corrected typo
    if current_client.supports_method("textDocument/formatting") then
      -- Correctly set up the autocmd
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
 end,
})

