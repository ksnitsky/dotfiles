local null_ls = require "null-ls"
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local b = null_ls.builtins
local h = require "null-ls.helpers"

local offense_to_diagnostic = function(offense)
  local diagnostic = nil

  diagnostic = {
    message = offense.message,
    ruleId = offense.rule_name,
    level = offense.severity,
    line = offense.location.line,
    column = offense.location.column,
    endLine = offense.end_location.line,
    endColumn = offense.end_location.column,
  }

  if offense.location.line ~= offense.end_location.line then
    diagnostic = vim.tbl_extend("force", diagnostic, { endLine = offense.location.line, endColumn = 0 })
  end

  return diagnostic
end

local handle_ameba_output = function(params)
  if params.output and params.output.sources then
    local source = params.output.sources[1]

    if source and source.issues then
      local parser = h.diagnostics.from_json {
        severities = {
          info = h.diagnostics.severities.information,
          convention = h.diagnostics.severities.information,
          refactor = h.diagnostics.severities.hint,
          warning = h.diagnostics.severities.warning,
          error = h.diagnostics.severities.error,
          fatal = h.diagnostics.severities.fatal,
        },
      }
      local issues = {}

      for _, issue in ipairs(source.issues) do
        table.insert(issues, offense_to_diagnostic(issue))
      end

      return parser { output = issues }
    end
  end

  return {}
end

local ameba_diagnostics = h.make_builtin {
  name = "ameba",
  filetypes = { "crystal" },
  method = null_ls.methods.DIAGNOSTICS,
  generator_opts = {
    command = "ameba",
    args = { "-f", "json", "$FILENAME" },
    format = "json",
    check_exit_code = function(code)
      return code <= 1
    end,
    on_output = handle_ameba_output,
  },
  factory = h.generator_factory,
}

local opts = {
  sources = {
    -- b.diagnostics.ameba,
    ameba_diagnostics,
    -- webdev stuff
    -- b.diagnostics.deno_lint, -- choosed deno for ts/js files cuz its very fast!
    b.formatting.deno_fmt, -- choosed deno for ts/js files cuz its very fast!
    -- b.formatting.prettier,
    --   .with {
    --   condition = function(utils)
    --     return utils.root_has_file "package.json" and utils.root_has_file ".prettierrc.yml"
    --   end,
    --   filetypes = { "html", "markdown", "css", "scss" },
    -- }, -- so prettier works only on these filetypes
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
    b.formatting.ocamlformat.with {
      command = "ocamlformat",
      args = { "--enable-outside-detected-project", "--name", "$FILENAME", "-" },
    },

    -- global
    b.formatting.trim_whitespace,

    -- sql
    -- b.diagnostics.sqlfluff.with {
    --   extra_args = { "--dialect", "postgres" },
    -- },
    -- b.formatting.sqlfluff.with {
    --   extra_args = { "--dialect", "postgres" },
    -- },
  },

  -- TODO: chatgpt answer to setup formatting only new lines
  -- Git Integration (Optional):
  --
  -- To format only the changed lines, you can use Git to identify the changes. You can use a Git pre-commit hook to format only the lines that are about to be committed.
  --
  -- You can create a custom script for this and configure it as a Git pre-commit hook. This script can use Neovim to call null-ls to format only the lines within the staged changes. Here's a basic outline of the script:
  --
  -- bash
  --
  -- #!/bin/bash
  -- changed_lines=$(git diff --staged --name-only | xargs nvim --headless -c "lua require('null-ls').try_attach()")
  -- git add $changed_lines
  --
  -- This script identifies the changed files, opens Neovim in headless mode, attaches null-ls, and formats the changed lines. After formatting, it stages the changes back to Git.
  --
  -- Configure Neovim to Save on Format:
  --
  -- You can configure Neovim to save automatically after formatting. You can add the following lines to your Neovim configuration:
  --
  -- lua
  --
  -- autocmd BufWritePre *.js,*.ts,*.lua,*.py,*.html,*.css,*.scss lua require('null-ls').try_attach()
  -- autocmd BufWritePost *.js,*.ts,*.lua,*.py,*.html,*.css,*.scss FormatWrite
  --
  -- Replace the file extensions in the autocmd pattern with the extensions for the languages you are working with.
  -- on_attach = function(client, bufnr)
  --   if client.supports_method "textDocument/formatting" then
  --     vim.api.nvim_clear_autocmds {
  --       group = augroup,
  --       buffer = bufnr,
  --     }
  --     vim.api.nvim_create_autocmd("BufWritePre", {
  --       group = augroup,
  --       buffer = bufnr,
  --       callback = function()
  --         vim.lsp.buf.format { bufnr = bufnr }
  --       end,
  --     })
  --   end
  -- end,
}

null_ls.setup(opts)
