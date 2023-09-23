-- credits to original theme https://rosepinetheme.com/
-- this is a modified version of it

local M = {}

M.base_30 = {
  white = "#54555b",
  darker_black = "#efeff0",
  black = "#faf4ed", --  nvim bg
  black2 = "#EAEAEB",
  -- black2 = "#54555b",
  one_bg = "#dadadb", -- real bg of onedark
  one_bg2 = "#d4d4d5",
  one_bg3 = "#cccccd",
  grey = "#b7b7b8",
  grey_fg = "#b0b0b1",
  grey_fg2 = "#a9a9aa",
  light_grey = "#a2a2a3",
  red = "#d84a3d",
  baby_pink = "#F07178",
  pink = "#ff75a0",
  line = "#e2e2e2", -- for lines like vertsplit
  green = "#50a14f",
  vibrant_green = "#7eca9c",
  nord_blue = "#428bab",
  blue = "#4078f2",
  yellow = "#c18401",
  sun = "#dea95f",
  purple = "#a28dcd",
  dark_purple = "#8e79b9",
  teal = "#519ABA",
  orange = "#FF6A00",
  cyan = "#0b8ec6",
  statusline_bg = "#ececec",
  lightbg = "#d3d3d3",
  pmenu_bg = "#5e5f65",
  folder_bg = "#6C6C6C",
}

M.base_16 = {
  base00 = "#faf4ed",
  base01 = "#f2e9de",
  base02 = "#f2e9de",
  base03 = "#9893a5",
  base04 = "#797593",
  base05 = "#575279",
  base06 = "#575279",
  base07 = "#cecacd",
  base08 = "#b4637a",
  base09 = "#ea9d34",
  base0A = "#d7827e",
  base0B = "#286983",
  base0C = "#56949f",
  base0D = "#907aa9",
  base0E = "#ea9d34",
  base0F = "#cecacd",
}

M.type = "light"

M = require("base46").override_theme(M, "rosepine-dawn")

return M
