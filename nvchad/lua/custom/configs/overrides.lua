local M = {}

M.treesitter = {
  ensure_installed = {
    "c",
    "css",
    "go",
    "html",
    "javascript",
    "lua",
    "markdown_inline",
    "ocaml",
    "ruby",
    "tsx",
    "typescript",
    "vim",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = false,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- go stuff
    "gopls",
    "gofumpt",
    "goimports-reviser",
    "golines",

    -- work-stuff
    -- "rubocop",
    -- "solargraph",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
