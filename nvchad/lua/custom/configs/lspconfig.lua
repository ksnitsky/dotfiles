local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- if you just want default config for the servers then put them in a table
local servers = {
  -- "html",
  -- "cssls",
  -- "tsserver",
  "clangd",
  -- "vls",
  "ruby_lsp",
  "rubocop",
  "marksman",
  "templ",
  "emmet_language_server",
  "gleam",
  -- "prettierd",
  -- "eslint_d"
  -- "tailwindcss",
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      completeUnimported = true,
      usePlaceholders = true, -- maybe not needed
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
  },
}

lspconfig.ocamllsp.setup {
  cmd = { "ocamllsp" },
  filetypes = { "ocaml", "ocaml.menhir", "ocaml.interface", "ocaml.ocamllex", "reason", "dune" },
  root_dir = lspconfig.util.root_pattern(
    "*.opam",
    "esy.json",
    "package.json",
    ".git",
    "dune-project",
    "dune-workspace"
  ),
  on_attach = on_attach,
  capabilities = capabilities,
}

-- vim.g.markdown_fenced_languages = {
--   "ts=typescript",
-- }

-- lspconfig.denols.setup {
--   filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
--   on_attach = on_attach,
--   root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
-- }

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern "package.json",
  single_file_support = false,
}

lspconfig.crystalline.setup {
  cmd = { "crystalline" },
  filetypes = { "crystal" },
  on_attach = on_attach,
  capabilities = capabilities,
}

-- lspconfig.rescriptls.setup {
--   cmd = { "rescript-language-server", "--stdio" },
--   filetypes = { "rescript", ".eml.re" },
-- }

-- lspconfig.solargraph.setup {
--   settings = {
--     solargraph = {
--       -- diagnostic = true,
--       -- typecheck = true,
--       diagnostics = false,
--     },
--   },
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

lspconfig.elixirls.setup {
  cmd = { "/home/ks/.local/share/nvim/mason/bin/elixir-ls" },
}

lspconfig.emmet_language_server.setup {
  filetypes = {
    "css",
    "eruby",
    "html",
    "htmldjango",
    "javascriptreact",
    "less",
    "pug",
    "sass",
    "scss",
    "typescriptreact",
    "templ",
  },
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
