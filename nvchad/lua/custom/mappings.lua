---@type MappingsTable
local M = {}

M.general = {
  n = {
    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    -- nnoremap <c-k> <c-v>
    ["<C-k>"] = { "<C-v>", "Block select", opts = { remap = false } },
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
  i = {
    ["cll"] = { "console.log()<Esc>ba" },
    ["bbp"] = { "binding.pry<Esc>==f(a" },
  },
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
