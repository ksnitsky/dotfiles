---@type MappingsTable
local M = {}

M.general = {
  n = {
    ["<C-k>"] = { "<C-v>", "Block select", opts = { remap = false } },
    ["<leader>cll"] = { "iconsole.log()<Esc>ba" },
    ["<leader>bbp"] = { "ibinding.pry<Esc>==f(a" },
    ["<leader>pr"] = { vim.lsp.buf.format, "Format document" },
    ["<leader>o"] = { "<cmd> only <CR>", "only focused split" },
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
