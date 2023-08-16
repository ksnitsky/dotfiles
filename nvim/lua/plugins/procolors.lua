local lush = require('lush')
local hsl = lush.hsl

local theme = lush(function ()
  return {
    Normal { fg = hsl(210, 15, 90), bg = hsl(210, 15, 10) },
  }
end)

return theme
