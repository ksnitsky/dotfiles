---@type MappingsTable
local M = {}

local insertDebugEntrypoint = function()
  local filetype = vim.bo.filetype
  local cases = {
    ["ruby"] = "binding.pry",
    ["slim"] = "- binding.pry",
    ["javascript"] = "debugger;",
    ["typescript"] = "debugger;",
  }
  local text = cases[filetype]

  if text == nil then
    text = ""
  else
    text = string.format("i%s<Esc>", text)
  end

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(text, true, true, true), "n", true)
end

M.general = {
  n = {
    ["<C-k>"] = { "<C-v>", "Block select", opts = { remap = false } },
    ["<leader>cll"] = { "iconsole.log()<Esc>ba" },
    -- ["<leader>bbp"] = { "ibinding.pry<Esc>==f(a" },
    ["<leader>bbp"] = { insertDebugEntrypoint, "Insert debug entrypoint" },
    ["<leader>pr"] = {
      function()
        vim.lsp.buf.format { async = true }
      end,
      "Format document",
    },
    ["<leader>o"] = { "<cmd> only <CR>", "only focused split" },
    ["gx"] = { '<cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>', "open link in browser" },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
  i = {},
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags",
    },
  },
}

-- more keybinds!

return M
