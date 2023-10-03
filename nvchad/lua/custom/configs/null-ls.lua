local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormattin", {})

local b = null_ls.builtins

local opts = {
  sources = {
    -- webdev stuff
    b.diagnostics.deno_lint, -- choosed deno for ts/js files cuz its very fast!
    b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
    b.formatting.prettier.with {
      condition = function(utils)
        return utils.root_has_file "package.json"
      end,
      filetypes = { "html", "markdown", "css" },
    }, -- so prettier works only on these filetypes
    b.diagnostics.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file "package.json"
      end,
    },
    b.code_actions.eslint_d.with {
      condition = function(utils)
        return utils.root_has_file "package.json"
      end,
    },

    -- Lua
    b.formatting.stylua,

    -- cpp
    b.formatting.clang_format,

    -- Go
    b.formatting.goimports_reviser,
    b.formatting.golines,

    -- Ocaml
    b.formatting.ocamlformat,

    -- global
    b.formatting.trim_whitespace,
  },
  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })
    end
  end,
}

null_ls.setup(opts)
