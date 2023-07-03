return function()
  local get_hlgroup = require("astronvim.utils").get_hlgroup
  local nontext = get_hlgroup "NonText"
  -- get highlights from highlight groups
  local normal = get_hlgroup "Normal"
  local fg, bg = normal.fg, normal.bg
  local bg_alt = get_hlgroup("Visual").bg
  local green = get_hlgroup("String").fg
  local red = get_hlgroup("Error").fg

  return {
    TelescopeBorder = { fg = bg_alt, bg = bg },
    TelescopeNormal = { bg = bg },
    TelescopePreviewBorder = { fg = bg, bg = bg },
    TelescopePreviewNormal = { bg = bg },
    TelescopePreviewTitle = { fg = bg, bg = green },
    TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
    TelescopePromptNormal = { fg = fg, bg = bg_alt },
    TelescopePromptPrefix = { fg = red, bg = bg_alt },
    TelescopePromptTitle = { fg = bg, bg = red },
    TelescopeResultsBorder = { fg = bg, bg = bg },
    TelescopeResultsNormal = { bg = bg },
    TelescopeResultsTitle = { fg = bg, bg = bg },
    CursorLineFold = { link = "CursorLineNr" }, -- highlight fold indicator as well as line number
    GitSignsCurrentLineBlame = { fg = nontext.fg, italic = true }, -- italicize git blame virtual text
    HighlightURL = { underline = true }, -- always underline URLs

    -- flash
    FlashMatch = { bg = bg, fg = "#89b4fa", bold = true, italic = true },
    FlashCurrent = { bg = bg, fg = "#04a5e5", bold = true, italic = true, underline = true },
    FlashLabel = { bg = bg, fg = "#ff007c", bold = true },
    FlashBackdrop = { bg = bg, fg = "#6c7086" },

    -- HopNextKey = { bg = bg, fg = C.peach, style = { "bold", "underline" } },
    -- HopNextKey1 = { bg = bg, fg = C.blue, style = { "bold" } },
    -- HopNextKey2 = { bg = bg, fg = C.teal, style = { "bold", "italic" } },
    -- HopUnmatched = { bg = bg, fg = C.overlay0 },
  }
end
