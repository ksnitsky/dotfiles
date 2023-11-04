local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local util = require "lspconfig/util"

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  -- "cssls",
  -- "tsserver",
  "clangd",
  "solargraph",
  "rescriptls"
  -- "prettierd",
  -- "eslint_d"
  -- "tailwindcss",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl", "templ" },
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

-- lspconfig.denols.setup {
--   filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
--   on_attach = on_attach,
--   root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
-- }

lspconfig.tsserver.setup {
  on_attach = on_attach,
  root_dir = lspconfig.util.root_pattern "package.json",
  single_file_support = false,
}

lspconfig.crystalline.setup {
  cmd = { "crystalline" },
  filetypes = { "crystal" },
  on_attach = on_attach,
  capabilities = capabilities,
}

lspconfig.rescriptls.setup {
  cmd = { 'rescript-lsp', '--stdio' },
  filetypes = { "rescript", ".eml.re" }
}
