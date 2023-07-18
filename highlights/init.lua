return function()
  local get_hlgroup = require("astronvim.utils").get_hlgroup
  -- get highlights from highlight groups
  local normal = get_hlgroup "Normal"
  local bg = normal.bg

  return {
    -- flash
    FlashMatch = { bg = bg, fg = "#89b4fa", bold = true, italic = true },
    FlashCurrent = { bg = bg, fg = "#04a5e5", bold = true, italic = true, underline = true },
    FlashLabel = { bg = bg, fg = "#ff007c", bold = true },
    FlashBackdrop = { bg = bg, fg = "#6c7086" },
  }
end
